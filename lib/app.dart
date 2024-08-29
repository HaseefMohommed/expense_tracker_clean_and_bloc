
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:expesne_tracker_app/features/auth/presentation/pages/on_boarding_page.dart';
import 'package:expesne_tracker_app/app/routes.dart';
import 'package:expesne_tracker_app/core/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: OnBoardingPage.routeName,
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
