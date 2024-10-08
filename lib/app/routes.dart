import 'package:expesne_tracker_app/features/auth/presentation/pages/on_boarding_page.dart';
import 'package:expesne_tracker_app/features/auth/presentation/pages/reset_sucess_page.dart';
import 'package:expesne_tracker_app/features/savings/presentation/pages/entry/add_expense_page.dart';
import 'package:expesne_tracker_app/features/savings/presentation/pages/entry/add_income_page.dart';
import 'package:expesne_tracker_app/features/savings/presentation/pages/entry/add_new_entry_page.dart';
import 'package:expesne_tracker_app/features/savings/presentation/pages/entry/entries_page.dart';
import 'package:expesne_tracker_app/features/savings/presentation/pages/entry/total_expense_page.dart';
import 'package:expesne_tracker_app/features/savings/presentation/pages/goals/add_goal_page.dart';
import 'package:expesne_tracker_app/features/savings/presentation/pages/goals/your_goals_page.dart';
import 'package:flutter/material.dart';
import 'package:expesne_tracker_app/features/auth/presentation/pages/reset_password_page.dart';
import 'package:expesne_tracker_app/features/auth/presentation/pages/sign_in_page.dart';
import 'package:expesne_tracker_app/features/auth/presentation/pages/sign_up_page.dart';
import 'package:expesne_tracker_app/features/home/presentation/pages/home_page.dart';

abstract class AppRoutes {
  static const String root = '/';

  // Child routes which carry implicit transitions
  static Map<String, WidgetBuilder> builder = {
    HomePage.routeName: (context) => HomePage(),
    SignInPage.routeName: (context) => const SignInPage(),
    SignUpPage.routeName: (context) => const SignUpPage(),
    ResetPasswordPage.routeName: (context) => const ResetPasswordPage(),
    ResetSucessPage.routeName: (context) => const ResetSucessPage(),
    OnBoardingPage.routeName: (context) => const OnBoardingPage(),
    AddGoalPage.routeName: (context) => const AddGoalPage(),
    YourGoalsPage.routeName: (context) => const YourGoalsPage(),
    AddExpensePage.routeName: (context) => const AddExpensePage(),
    AddIncomePage.routeName: (context) => const AddIncomePage(),
    AddNewEntryPage.routeName: (context) => const AddNewEntryPage(),
    EntriesPage.routeName: (context) => const EntriesPage(),
    TotalExpensePage.routeName: (context) => const TotalExpensePage(),
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
