import 'package:expesne_tracker_app/core/theme.dart';
import 'package:flutter/material.dart';

class NotificationBell extends StatelessWidget {
  const NotificationBell({
    super.key,
    this.notificationCount,
    required this.index,
    required this.currentIndexNotifier,
  });

  final int? notificationCount;
  final int index;

  final ValueNotifier<int> currentIndexNotifier;

  @override
  Widget build(BuildContext context) {
    final isSelected = currentIndexNotifier.value == index;
    final bool badgeVisibility = (notificationCount ?? 0) > 0;

    return InkWell(
      onTap: () {
        currentIndexNotifier.value = index;
      },
      child: Badge(
        backgroundColor: badgeVisibility
            ? AppTheme.notificationIndicatorColor
            : Colors.transparent,
        label: badgeVisibility
            ? Text(
                '$notificationCount',
                style: const TextStyle(
                  color: Colors.white,
                ),
              )
            : null,
        child: Icon(
          Icons.notifications_outlined,
          size: 32,
          color: isSelected ? AppTheme.primaryColor : AppTheme.secondaryColor,
        ),
      ),
    );
  }
}
