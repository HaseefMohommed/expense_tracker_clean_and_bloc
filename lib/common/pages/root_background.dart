import 'package:expesne_tracker_app/core/theme.dart';
import 'package:expesne_tracker_app/resources/ui_components/bottom_navbar/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class RootBackground extends StatelessWidget {
  final String? pageTitle;
  final bool isEnabledBottomNavBar;
  final List<Widget> children;
  const RootBackground({
    super.key,
    this.pageTitle = 'Overview',
    required this.children,
    this.isEnabledBottomNavBar = true,
  });

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<int> currentIndex = ValueNotifier<int>(0);
    return Scaffold(
      backgroundColor: AppTheme.secondaryPaleColor,
      appBar: (pageTitle != null && pageTitle!.isNotEmpty)
          ? AppBar(
              title: Text(
                pageTitle!,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                ),
              ),
              centerTitle: true,
            )
          : AppBar(
              title: Text(
                pageTitle ?? '',
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [...children],
      ),
      bottomNavigationBar: isEnabledBottomNavBar
          ? BottomNavBar(currentIndexNotifier: currentIndex)
          : null,
      floatingActionButton: isEnabledBottomNavBar
          ? Container(
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
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
