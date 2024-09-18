import 'package:expesne_tracker_app/utils/enums/app_status.dart';
import 'package:expesne_tracker_app/utils/enums/validity_status.dart';
import 'package:expesne_tracker_app/utils/extentions/failure_extention.dart';
import 'package:expesne_tracker_app/utils/extentions/locale_extention.dart';
import 'package:expesne_tracker_app/features/auth/presentation/bloc/auth_cubit/auth_cubit.dart';
import 'package:expesne_tracker_app/features/auth/presentation/pages/reset_sucess_page.dart';
import 'package:flutter/material.dart';
import 'package:expesne_tracker_app/constants/assets_paths.dart';
import 'package:expesne_tracker_app/core/theme.dart';
import 'package:expesne_tracker_app/resources/ui_components/buttons/app_button.dart';
import 'package:expesne_tracker_app/resources/ui_components/text_field/app_text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordPage extends StatefulWidget {
  static String routeName = '/resetPasswordPage';
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locale = context.locale;
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.appState == AppStatus.success) {
          Navigator.pushNamed(
            context,
            ResetSucessPage.routeName,
          );
        }
        state.faliure.showError(context, state.appState);
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.primaryPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  locale.rest_your_password,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  locale.enter_your_email,
                  style: const TextStyle(
                    color: AppTheme.secondaryColor,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 32),
                AppTextField(
                  controller: _emailController,
                  hintText: locale.email,
                  prefixIcon: AssetsPaths.email,
                  errorText: switch (state.emailValidityStatus) {
                    ValidityStatus.valid || null => null,
                    ValidityStatus.empty => locale.requird_field,
                    ValidityStatus.invalid => locale.invaild_password
                  },
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: AppButton(
                    name: state.appState == AppStatus.loading
                        ? locale.please_wait
                        : locale.reset_password,
                    onPressed: () {
                      context.read<AuthCubit>().resetOldPassword(
                            email: _emailController.text.trim(),
                          );
                    },
                  ),
                ),
                const SizedBox(
                  height: 15,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class ValueListTile extends StatelessWidget {
  final bool isValid;
  final String text;

  const ValueListTile({
    super.key,
    required this.isValid,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        isValid ? Icons.check_circle : Icons.radio_button_unchecked,
        color: isValid ? AppTheme.primaryColor : AppTheme.secondaryColor,
      ),
      title: Text(
        text,
        style: TextStyle(
          color: isValid ? AppTheme.primaryColor : AppTheme.secondaryColor,
        ),
      ),
    );
  }
}
