import 'package:expesne_tracker_app/core/enums/app_status.dart';
import 'package:expesne_tracker_app/core/enums/validity_status.dart';
import 'package:expesne_tracker_app/core/extentions/failure_extention.dart';
import 'package:expesne_tracker_app/features/auth/presentation/bloc/auth_cubit/auth_cubit.dart';
import 'package:expesne_tracker_app/features/auth/presentation/pages/reset_sucess_page.dart';
import 'package:flutter/material.dart';
import 'package:expesne_tracker_app/constants/assets_provider.dart';
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
                const Text(
                  'Rest your password with email',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Enter your email to get the reset password email here.',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 32),
                AppTextField(
                  controller: _emailController,
                  hintText: 'Email',
                  prefixIcon: AssetsProvider.email,
                  errorText: switch (state.emailValidityStatus) {
                    ValidityStatus.valid || null => null,
                    ValidityStatus.empty => 'Required Field',
                    ValidityStatus.invalid => 'Invalid password'
                  },
                  onChanged: (value) {
                    context.read<AuthCubit>().validateField('email', value);
                  },
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: AppButton(
                    name: state.appState == AppStatus.loading
                        ? 'please wait..'
                        : 'Reset Password',
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
        color: isValid ? AppTheme.primaryColor : Colors.grey,
      ),
      title: Text(
        text,
        style: TextStyle(
          color: isValid ? AppTheme.primaryColor : Colors.grey,
        ),
      ),
    );
  }
}
