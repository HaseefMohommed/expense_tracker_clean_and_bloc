import 'package:flutter/material.dart';
import 'package:expesne_tracker_app/core/theme.dart';
import 'package:expesne_tracker_app/features/home/presentation/widgets/components/notification_bell.dart';

class BottomNavBar extends StatelessWidget {
  final ValueNotifier<int> currentIndexNotifier;

  const BottomNavBar({
    super.key,
    required this.currentIndexNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: currentIndexNotifier,
      builder: (context, currentIndex, _) {
        return BottomAppBar(
          color: AppTheme.secondaryPaleColor,
          shape: const CircularNotchedRectangle(),
          notchMargin: 8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              NavItem(
                icon: Icons.home,
                index: 0,
                currentIndexNotifier: currentIndexNotifier,
              ),
              NavItem(
                icon: Icons.checklist,
                index: 1,
                currentIndexNotifier: currentIndexNotifier,
              ),
              const SizedBox(width: 48),
              NotificationBell(
                index: 2,
                currentIndexNotifier: currentIndexNotifier,
                notificationCount: 2,
              ),
              NavItem(
                icon: Icons.settings,
                index: 3,
                currentIndexNotifier: currentIndexNotifier,
              ),
            ],
          ),
        );
      },
    );
  }
}

class NavItem extends StatelessWidget {
  final IconData icon;
  final int index;

  final ValueNotifier<int> currentIndexNotifier;

  const NavItem({
    super.key,
    required this.icon,
    required this.index,
    required this.currentIndexNotifier,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = currentIndexNotifier.value == index;
    return IconButton(
      icon: Icon(
        icon,
        size: 32,
        color: isSelected ? AppTheme.primaryColor : AppTheme.secondaryColor,
      ),
      onPressed: () => currentIndexNotifier.value = index,
    );
  }
}
