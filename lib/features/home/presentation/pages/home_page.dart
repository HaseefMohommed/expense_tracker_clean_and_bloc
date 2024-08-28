import 'package:expesne_tracker_app/constants/assets_provider.dart';
import 'package:expesne_tracker_app/core/theme.dart';
import 'package:expesne_tracker_app/resources/ui_components/bottom_navbar/bottom_nav_bar.dart';
import 'package:expesne_tracker_app/features/home/presentation/widgets/over_view_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static String routeName = '/homePage';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.secondaryColor,
      body: const Padding(
        padding: EdgeInsets.all(AppTheme.primaryPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OverviewCard(
                  title: 'title',
                  amount: 'amount',
                  iconPath: AssetsProvider.email,
                ),
                OverviewCard(
                  title: 'title',
                  amount: 'amount',
                  iconPath: AssetsProvider.email,
                  backgroundColor: AppTheme.primaryColor,
                  textColor: Colors.white,
                )
              ],
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
