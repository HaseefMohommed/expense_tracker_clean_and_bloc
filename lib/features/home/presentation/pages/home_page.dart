import 'package:flutter/material.dart';
import 'package:expesne_tracker_app/core/theme.dart';
import 'package:expesne_tracker_app/features/home/presentation/pages/over_view_page.dart';
import 'package:expesne_tracker_app/features/notification/presentation/pages/notification_page.dart';
import 'package:expesne_tracker_app/features/profile/presentation/pages/profile_page.dart';
import 'package:expesne_tracker_app/features/savings/presentation/pages/savings_page.dart';
import 'package:expesne_tracker_app/resources/ui_components/bottom_navbar/bottom_nav_bar.dart';

class HomePage extends StatelessWidget {
  static String routeName = '/homePage';

  HomePage({super.key});

  final List<Widget> pageViews = [
    const OverViewPage(),
    SavingsPage(),
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
    final ValueNotifier<int> currentIndex = ValueNotifier<int>(0);

    return ValueListenableBuilder<int>(
      valueListenable: currentIndex,
      builder: (context, index, _) {
        return Scaffold(
          backgroundColor: AppTheme.secondaryPaleColor,
          appBar: (currentIndex.value == 0)
              ? AppBar()
              : AppBar(
                  title: Text(
                    pageTitles[index],
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  centerTitle: true,
                ),
          body: IndexedStack(
            index: index,
            children: pageViews,
          ),
          bottomNavigationBar: BottomNavBar(
            currentIndexNotifier: currentIndex,
          ),
          floatingActionButton: Container(
            height: 70,
            width: 70,
            decoration: const BoxDecoration(
              color: AppTheme.primaryColor,
              shape: BoxShape.circle,
            ),
            child: FloatingActionButton(
              onPressed: () {},
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
    );
  }
}
