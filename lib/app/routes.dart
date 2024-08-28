import 'package:expesne_tracker_app/features/auth/presentation/pages/on_boarding_page.dart';
import 'package:expesne_tracker_app/features/auth/presentation/pages/reset_sucess_page.dart';
import 'package:expesne_tracker_app/features/notification/presentation/pages/notification_page.dart';
import 'package:expesne_tracker_app/features/profile/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:expesne_tracker_app/features/auth/presentation/pages/reset_password_page.dart';
import 'package:expesne_tracker_app/features/auth/presentation/pages/sign_in_page.dart';
import 'package:expesne_tracker_app/features/auth/presentation/pages/sign_up_page.dart';
import 'package:expesne_tracker_app/features/home/presentation/pages/home_page.dart';

abstract class AppRoutes {
  static const String root = '/';

  // Child routes which carry implicit transitions
  static Map<String, WidgetBuilder> builder = {
    HomePage.routeName: (context) => const HomePage(),
    SignInPage.routeName: (context) => const SignInPage(),
    SignUpPage.routeName: (context) => const SignUpPage(),
    ResetPasswordPage.routeName: (context) => const ResetPasswordPage(),
    ResetSucessPage.routeName: (context) => const ResetSucessPage(),
    OnboardingPage.routeName: (context) => const OnboardingPage(),
    ProfilePage.routeName: (context) => const ProfilePage(),
    NotificationPage.routeName: (context) => const NotificationPage(),
  };

  // Note: Named pages under routes will not trigger onGenerateRoute!
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final String routeName = settings.name!;

    return PageRouteBuilder(pageBuilder: (BuildContext context,
        Animation<double> animation, Animation<double> secondaryAnimation) {
      if (settings.name == AppRoutes.root) {
        return const SignInPage();
      }

      assert(builder.containsKey(routeName));
      return builder[routeName]!(context);
    });
  }
}
