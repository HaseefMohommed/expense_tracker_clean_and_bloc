import 'package:expesne_tracker_app/constants/assets_provider.dart';
import 'package:expesne_tracker_app/core/theme.dart';
import 'package:expesne_tracker_app/features/auth/presentation/pages/sign_in_page.dart';
import 'package:expesne_tracker_app/resources/ui_components/buttons/app_button.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg_flutter.dart';

class ResetSucessPage extends StatelessWidget {
  static String routeName = '/resetSucessPage';
  const ResetSucessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(
          AppTheme.primaryPadding,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            SvgPicture.asset(
              AssetsProvider.resetSuccess,
            ),
            const Text(
              'Password updated!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Your password has been setup successfully',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: AppButton(
                name: 'Back to log in',
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    SignInPage.routeName,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
