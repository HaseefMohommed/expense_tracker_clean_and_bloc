import 'package:expesne_tracker_app/constants/assets_paths.dart';
import 'package:expesne_tracker_app/core/extentions/locale_extention.dart';
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
    final locale = context.locale;
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
              AssetsPaths.resetSuccess,
            ),
            Text(
              locale.password_updated,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              locale.your_password_has_been_setup_sucessfully,
              style: const TextStyle(
                color: AppTheme.secondaryColor,
                fontSize: 16,
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: AppButton(
                name: locale.back_to_log_in,
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
