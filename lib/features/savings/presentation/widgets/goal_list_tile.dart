import 'package:expesne_tracker_app/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg_flutter.dart';

class GoalListTile extends StatelessWidget {
  final String icon;
  final String title;
  final int savedAmount;
  final int goalAmount;

  const GoalListTile({
    super.key,
    required this.icon,
    required this.title,
    required this.savedAmount,
    required this.goalAmount,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: SvgPicture.asset(icon),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          LinearProgressIndicator(
            value: savedAmount / goalAmount,
            backgroundColor: AppTheme.secondaryPaleColor,
            valueColor:
                const AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
          ),
          const SizedBox(
            height: 4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$$savedAmount',
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
              Text(
                '\$$goalAmount',
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
