import 'package:expesne_tracker_app/features/common/cubit/bottom_nav_cubit.dart';
import 'package:expesne_tracker_app/features/savings/presentation/pages/goals/add_goal_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expesne_tracker_app/core/theme.dart';
import 'package:expesne_tracker_app/features/home/presentation/pages/over_view_page.dart';
import 'package:expesne_tracker_app/features/notification/presentation/pages/notification_page.dart';
import 'package:expesne_tracker_app/features/profile/presentation/pages/profile_page.dart';
import 'package:expesne_tracker_app/features/savings/presentation/pages/goals/savings_page.dart';
import 'package:expesne_tracker_app/resources/ui_components/bottom_navbar/bottom_nav_bar.dart';

class HomePage extends StatelessWidget {
  static String routeName = '/homePage';

  HomePage({super.key});

  final List<Widget> pageViews = [
    const OverViewPage(),
    const SavingsPage(),
    const NotificationPage(),
    const ProfilePage(),
  ];

  final List<String> pageTitles = [
    'Overview',
    'Savings',
    'Notifications',
    'Profile',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavCubit(),
      child: BlocBuilder<BottomNavCubit, int>(
        builder: (context, currentIndex) {
          return Scaffold(
            backgroundColor: AppTheme.secondaryPaleColor,
            appBar: (currentIndex == 0)
                ? AppBar(
                    title: const Text('Overview'),
                  )
                : AppBar(
                    title: Text(
                      pageTitles[currentIndex],
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    centerTitle: true,
                  ),
            body: IndexedStack(
              index: currentIndex,
              children: pageViews,
            ),
            bottomNavigationBar: const BottomNavBar(),
            floatingActionButton: Container(
              height: 70,
              width: 70,
              decoration: const BoxDecoration(
                color: AppTheme.primaryColor,
                shape: BoxShape.circle,
              ),
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AddGoalPage.routeName,
                  );
                },
                backgroundColor: Colors.transparent,
                elevation: 0,
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 35,
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
          );
        },
      ),
    );
  }
}
