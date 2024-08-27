import 'package:expesne_tracker_app/core/enums/validity_status.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svg_flutter/svg.dart';

import 'package:expesne_tracker_app/constants/assets_provider.dart';
import 'package:expesne_tracker_app/core/enums/app_status.dart';
import 'package:expesne_tracker_app/core/extentions/failure_extention.dart';
import 'package:expesne_tracker_app/core/theme.dart';
import 'package:expesne_tracker_app/features/auth/presentation/bloc/auth_cubit/auth_cubit.dart';
import 'package:expesne_tracker_app/features/auth/presentation/pages/reset_password_page.dart';
import 'package:expesne_tracker_app/features/auth/presentation/pages/sign_up_page.dart';
import 'package:expesne_tracker_app/features/home/presentation/pages/home_page.dart';
import 'package:expesne_tracker_app/resources/ui_components/buttons/app_button.dart';
import 'package:expesne_tracker_app/resources/ui_components/text_field/app_text_field.dart';

class SignInPage extends StatefulWidget {
  static String routeName = '/signInPage';
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AuthCubit>().state;
    return Scaffold(
      body: AbsorbPointer(
        absorbing: state.appState == AppStatus.loading,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(
              AppTheme.primaryPadding,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AssetsProvider.logo,
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
                            controller: _emailController,
                            hintText: 'Email',
                            prefixIcon: AssetsProvider.email,
                            errorText: switch (state.emailValidityStatus) {
                              ValidityStatus.valid || null => null,
                              ValidityStatus.empty => 'Required Feild',
                              ValidityStatus.invalid => 'invalid email'
                            },
                            onChanged: (value) {
                              context
                                  .read<AuthCubit>()
                                  .validateField('email', value);
                            },
                          ),
                          const SizedBox(height: 16),
                          AppTextField(
                            controller: _passwordController,
                            hintText: 'Password',
                            isObscureText: true,
                            prefixIcon: AssetsProvider.padLock,
                            suffixIconVisible: AssetsProvider.visibility,
                            suffixIconHidden: AssetsProvider.visibilityOff,
                            errorText: switch (state.passwordValidityStatus) {
                              ValidityStatus.valid || null => null,
                              ValidityStatus.empty => 'Required Feild',
                              ValidityStatus.invalid => 'invalid password'
                            },
                            onChanged: (value) {
                              context
                                  .read<AuthCubit>()
                                  .validateField('password', value);
                            },
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            width: double.infinity,
                            child: AppButton(
                              name: state.appState == AppStatus.loading
                                  ? 'Please Wait..'
                                  : 'log in',
                              onPressed: state.appState == AppStatus.loading
                                  ? null
                                  : () {
                                      context
                                          .read<AuthCubit>()
                                          .validateLoginFields(
                                            email: _emailController.text.trim(),
                                            password:
                                                _passwordController.text.trim(),
                                          );
                                      if (state.emailValidityStatus ==
                                              ValidityStatus.valid &&
                                          state.passwordValidityStatus ==
                                              ValidityStatus.valid) {
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                        context
                                            .read<AuthCubit>()
                                            .signInwithEmail(
                                              email:
                                                  _emailController.text.trim(),
                                              password: _passwordController.text
                                                  .trim(),
                                            );
                                      }
                                    },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: AppButton.seondary(
                    name: 'Forgot Passsword',
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        ResetPasswordPage.routeName,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Or',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: AppButton.icon(
                    name: 'Continue with Google',
                    iconPath: AssetsProvider.google,
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
                    name: 'Continue with apple',
                    iconPath: AssetsProvider.apple,
                    enabledBorder: true,
                    onPressed: () {
                      context.read<AuthCubit>().authenticationWithApple();
                    },
                  ),
                ),
                const SizedBox(height: 24),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: [
                      const TextSpan(
                        text: "Don't have an account? ",
                      ),
                      TextSpan(
                        text: 'Register here',
                        style: const TextStyle(
                          color: AppTheme.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.read<AuthCubit>().resetValidityStatus();
                            Navigator.pushNamed(context, SignUpPage.routeName);
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
