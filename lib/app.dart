import 'package:expesne_tracker_app/features/auth/presentation/pages/on_boarding_page.dart';
import 'package:flutter/material.dart';
import 'package:expesne_tracker_app/app/routes.dart';
import 'package:expesne_tracker_app/core/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker',
      theme: AppTheme.lightTheme,
      initialRoute: OnboardingPage.routeName,
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
