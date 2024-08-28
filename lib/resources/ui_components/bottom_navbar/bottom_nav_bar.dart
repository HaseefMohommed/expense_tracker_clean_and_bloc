import 'package:expesne_tracker_app/features/notification/presentation/pages/notification_page.dart';
import 'package:expesne_tracker_app/features/profile/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:expesne_tracker_app/core/theme.dart';
import 'package:expesne_tracker_app/features/home/presentation/widgets/notification_bell.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onSelected;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: AppTheme.secondaryColor,
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          NavItem(
            icon: Icons.home,
            index: 0,
            currentIndex: currentIndex,
            onSelected: onSelected,
            onPressed: () {},
          ),
          NavItem(
            icon: Icons.checklist,
            index: 1,
            currentIndex: currentIndex,
            onSelected: onSelected,
            onPressed: () {},
          ),
          const SizedBox(width: 48),
          NotificationBell(
            currentIndex: currentIndex,
            index: 2,
            onPressed: () {
              Navigator.pushNamed(
                context,
                NotificationPage.routeName,
              );
            },
            onSelected: onSelected,
            notificationCount: 2,
          ),
          NavItem(
            icon: Icons.settings,
            index: 3,
            currentIndex: currentIndex,
            onSelected: onSelected,
            onPressed: () {
              Navigator.pushNamed(
                context,
                ProfilePage.routeName,
              );
            },
          ),
        ],
      ),
    );
  }
}

class NavItem extends StatelessWidget {
  final IconData icon;
  final int index;
  final int currentIndex;
  final Function() onPressed;
  final Function(int) onSelected;

  const NavItem({
    super.key,
    required this.icon,
    required this.index,
    required this.currentIndex,
    required this.onSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = currentIndex == index;
    return IconButton(
      icon: Icon(
        icon,
        size: 32,
        color: isSelected ? AppTheme.primaryColor : null,
      ),
      onPressed: () {
        onSelected(index);
        onPressed();
      },
    );
  }
}
