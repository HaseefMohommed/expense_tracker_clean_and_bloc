import 'package:expesne_tracker_app/core/enums/validity_status.dart';
import 'package:expesne_tracker_app/core/extentions/locale_extention.dart';
import 'package:expesne_tracker_app/features/auth/presentation/pages/sign_in_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svg_flutter/svg.dart';

import 'package:expesne_tracker_app/constants/assets_paths.dart';
import 'package:expesne_tracker_app/core/enums/app_status.dart';
import 'package:expesne_tracker_app/core/extentions/failure_extention.dart';
import 'package:expesne_tracker_app/core/theme.dart';
import 'package:expesne_tracker_app/features/auth/presentation/bloc/auth_cubit/auth_cubit.dart';
import 'package:expesne_tracker_app/features/home/presentation/pages/home_page.dart';
import 'package:expesne_tracker_app/resources/ui_components/buttons/app_button.dart';
import 'package:expesne_tracker_app/resources/ui_components/text_field/app_text_field.dart';

class SignUpPage extends StatefulWidget {
  static String routeName = '/signUpPage';
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locale = context.locale;
    final state = context.watch<AuthCubit>().state;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      appBar: AppBar(),
      body: AbsorbPointer(
        absorbing: state.appState == AppStatus.loading,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(
                AppTheme.primaryPadding,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AssetsPaths.logo,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SvgPicture.asset(
                    AssetsPaths.textlogo,
                    colorFilter: ColorFilter.mode(baseColor, BlendMode.srcIn),
                  ),
                  const SizedBox(height: 40),
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state.appState == AppStatus.success) {
                        context.read<AuthCubit>().resetValidityStatus();
                        Navigator.pushNamed(context, HomePage.routeName);
                      }

                      state.faliure.showError(context, state.appState);
                    },
                    builder: (context, state) {
                      return Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            AppTextField(
                              controller: _nameController,
                              hintText: locale.name,
                              prefixIcon: AssetsPaths.user,
                              errorText: switch (state.nameValidityStatus) {
                                ValidityStatus.valid || null => null,
                                ValidityStatus.empty => locale.requird_field,
                                ValidityStatus.invalid => locale.invaild_name,
                              },
                            ),
                            const SizedBox(height: 16),
                            AppTextField(
                              controller: _emailController,
                              hintText: locale.email,
                              prefixIcon: AssetsPaths.email,
                              errorText: switch (state.emailValidityStatus) {
                                ValidityStatus.valid || null => null,
                                ValidityStatus.empty => locale.requird_field,
                                ValidityStatus.invalid => locale.email
                              },
                            ),
                            const SizedBox(height: 16),
                            AppTextField(
                              controller: _passwordController,
                              hintText: locale.password,
                              isObscureText: true,
                              prefixIcon: AssetsPaths.padLock,
                              suffixIconVisible: AssetsPaths.visibility,
                              suffixIconHidden: AssetsPaths.visibilityOff,
                              errorText: switch (state.passwordValidityStatus) {
                                ValidityStatus.valid || null => null,
                                ValidityStatus.empty => locale.requird_field,
                                ValidityStatus.invalid =>
                                  locale.invaild_password
                              },
                            ),
                            const SizedBox(height: 24),
                            SizedBox(
                              width: double.infinity,
                              child: AppButton(
                                  name: state.appState == AppStatus.loading
                                      ? locale.please_wait
                                      : locale.sign_up,
                                  onPressed: state.appState == AppStatus.loading
                                      ? null
                                      : () {
                                          context
                                              .read<AuthCubit>()
                                              .validateFields(
                                                name:
                                                    _nameController.text.trim(),
                                                email: _emailController.text
                                                    .trim(),
                                                password: _passwordController
                                                    .text
                                                    .trim(),
                                              );
                                          if (state.nameValidityStatus ==
                                                  ValidityStatus.valid &&
                                              state.emailValidityStatus ==
                                                  ValidityStatus.valid &&
                                              state.passwordValidityStatus ==
                                                  ValidityStatus.valid) {
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();
                                            context
                                                .read<AuthCubit>()
                                                .signUpWithEmail(
                                                  name: _nameController.text
                                                      .trim(),
                                                  email: _emailController.text
                                                      .trim(),
                                                  password: _passwordController
                                                      .text
                                                      .trim(),
                                                );
                                          }
                                        }),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  Text(
                    locale.or,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: baseColor,
                        ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: AppButton.icon(
                      name: locale.continue_with_google,
                      iconPath: AssetsPaths.google,
                      enabledBorder: true,
                      onPressed: () {
                        context.read<AuthCubit>().authenticationWithGoogle();
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: AppButton.icon(
                      name: locale.continue_with_facebook,
                      iconPath: AssetsPaths.facebook,
                      enabledBorder: true,
                      onPressed: () {
                        context.read<AuthCubit>().authenticationWithFacebook();
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: baseColor,
                          ),
                      children: [
                        TextSpan(
                          text: locale.already_have_account,
                        ),
                        TextSpan(
                          text: locale.sign_in_here,
                          style: const TextStyle(
                            color: AppTheme.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              context.read<AuthCubit>().resetValidityStatus();
                              Navigator.pushNamed(
                                context,
                                SignInPage.routeName,
                              );
                            },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
