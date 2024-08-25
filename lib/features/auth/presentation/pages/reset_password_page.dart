import 'package:expesne_tracker_app/features/auth/presentation/pages/reset_sucess_page.dart';
import 'package:flutter/material.dart';
import 'package:expesne_tracker_app/constants/assets_provider.dart';
import 'package:expesne_tracker_app/core/theme.dart';
import 'package:expesne_tracker_app/resources/ui_components/buttons/app_button.dart';
import 'package:expesne_tracker_app/resources/ui_components/text_field/app_text_field.dart';

class ResetPasswordPage extends StatefulWidget {
  static String routeName = '/resetPasswordPage';
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _passwordController = TextEditingController();
  final _isNameOrEmailIncluded = ValueNotifier<bool>(true);
  final _isPasswordLongEnough = ValueNotifier<bool>(false);
  final _containsSymbolOrNumber = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_validatePassword);
  }

  void _validatePassword() {
    final password = _passwordController.text;

    _isPasswordLongEnough.value = password.length >= 8;
    _containsSymbolOrNumber.value = password.contains(RegExp(r'[!@#\$&*~0-9]'));
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _isNameOrEmailIncluded.dispose();
    _isPasswordLongEnough.dispose();
    _containsSymbolOrNumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              'Create Your New Password',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Your new password must be different from previous password.',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 32),
            AppTextField(
              controller: _passwordController,
              isObscureText: true,
              hintText: 'New Password',
              prefixIcon: AssetsProvider.padLock,
              suffixIconHidden: AssetsProvider.visibility,
              suffixIconVisible: AssetsProvider.visibilityOff,
            ),
            ValueListTile(
              notifier: _isPasswordLongEnough,
              text: 'At least 8 characters',
            ),
            ValueListTile(
              notifier: _containsSymbolOrNumber,
              text: 'Contains a symbol or a number',
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: AppButton(
                name: 'Reset Password',
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    ResetSucessPage.routeName,
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
  }
}

class ValueListTile extends StatelessWidget {
  final ValueNotifier<bool> notifier;
  final String text;

  const ValueListTile({
    super.key,
    required this.notifier,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: notifier,
        builder: (context, value, child) {
          return ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(
              value ? Icons.check_circle : Icons.radio_button_unchecked,
              color: value ? AppTheme.primaryColor : Colors.grey,
            ),
            title: Text(
              text,
              style: TextStyle(
                color: value ? AppTheme.primaryColor : Colors.grey,
              ),
            ),
          );
        });
  }
}
