import 'package:expesne_tracker_app/features/common/cubit/bottom_nav_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expesne_tracker_app/core/theme.dart';
import 'package:expesne_tracker_app/features/home/presentation/widgets/components/notification_bell.dart';



class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavCubit, int>(
      builder: (context, currentIndex) {
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
                currentIndex: currentIndex,
              ),
              NavItem(
                icon: Icons.checklist,
                index: 1,
                currentIndex: currentIndex,
              ),
              const SizedBox(width: 48),
              const NotificationBell(
                index: 2,
                notificationCount: 2,
              ),
              NavItem(
                icon: Icons.settings,
                index: 3,
                currentIndex: currentIndex,
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
  final int currentIndex;

  const NavItem({
    super.key,
    required this.icon,
    required this.index,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = currentIndex == index;
    return IconButton(
      icon: Icon(
        icon,
        size: 32,
        color: isSelected ? AppTheme.primaryColor : AppTheme.secondaryColor,
      ),
      onPressed: () => context.read<BottomNavCubit>().updateIndex(index),
    );
  }
}
