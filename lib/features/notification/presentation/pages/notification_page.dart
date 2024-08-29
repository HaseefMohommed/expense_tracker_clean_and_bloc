import 'package:expesne_tracker_app/constants/assets_provider.dart';
import 'package:expesne_tracker_app/core/theme.dart';
import 'package:flutter/material.dart';

import 'package:svg_flutter/svg.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> notifications = [
      {
        'icon': AssetsProvider.food,
        'title': 'Food',
        'description': 'You just paid your food bill',
        'time': 'Just now'
      },
      {
        'icon': AssetsProvider.food,
        'title': 'Reminder',
        'description': 'Reminder to pay your rent',
        'time': '23 sec ago'
      },
      {
        'icon': AssetsProvider.food,
        'title': 'Goal Achieved',
        'description': 'You just achieved your goal for new bike',
        'time': '2 min ago'
      },
      {
        'icon': AssetsProvider.food,
        'title': 'Reminder',
        'description': 'You just set a new reminder shopping',
        'time': '10 min ago'
      },
      {
        'icon': AssetsProvider.food,
        'title': 'Food',
        'description': 'You just paid your food bill',
        'time': '45 min ago'
      },
      {
        'icon': AssetsProvider.food,
        'title': 'Bill',
        'description': 'You just got a reminder for your bill pay',
        'time': '1 hour ago'
      },
      {
        'icon': AssetsProvider.food,
        'title': 'Uber',
        'description': 'You just paid your uber bill',
        'time': '2 hour ago'
      },
      {
        'icon': AssetsProvider.food,
        'title': 'Ticket',
        'description': 'You just paid for the movie ticket',
        'time': '5 hour ago'
      },
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.primaryPadding,
        vertical: AppTheme.primaryPadding / 2,
      ),
      child: ListView.separated(
        itemCount: notifications.length,
        separatorBuilder: (context, index) => const Divider(
          height: 1,
          color: AppTheme.secondaryColor,
        ),
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return ListTile(
            leading: SvgPicture.asset(
              notification['icon'],
            ),
            title: Text(notification['title']),
            subtitle: Text(notification['description']),
            trailing: Text(
              notification['time'],
              style: const TextStyle(color: AppTheme.secondaryColor),
            ),
          );
        },
      ),
    );
  }
}
