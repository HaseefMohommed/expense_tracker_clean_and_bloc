import 'package:expesne_tracker_app/core/theme.dart';
import 'package:expesne_tracker_app/features/common/cubit/bottom_nav_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationBell extends StatelessWidget {
  const NotificationBell({
    super.key,
    this.notificationCount,
    required this.index,
  });

  final int? notificationCount;
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavCubit, int>(
      builder: (context, currentIndex) {
        final isSelected = currentIndex == index;
        final bool badgeVisibility = (notificationCount ?? 0) > 0;

        return InkWell(
          onTap: () {
            context.read<BottomNavCubit>().updateIndex(index);
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
      },
    );
  }
}