import 'package:expesne_tracker_app/constants/assets_provider.dart';
import 'package:expesne_tracker_app/core/theme.dart';
import 'package:expesne_tracker_app/resources/ui_components/bottom_navbar/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

import 'package:svg_flutter/svg.dart';

class NotificationPage extends StatefulWidget {
  static String routeName = '/notificationPage';
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
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

  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notification',
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
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
                style: const TextStyle(color: Colors.grey),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: currentIndex,
        onSelected: (index) {
          setState(() {
            currentIndex = index;
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
