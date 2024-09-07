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
      leading: SvgPicture.asset(icon),
      title: Text(title),
      subtitle: LinearProgressIndicator(
        value: savedAmount / goalAmount,
        backgroundColor: AppTheme.secondaryPaleColor,
        valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
      ),
      trailing: Text('\$$savedAmount / \$$goalAmount'),
    );
  }
}
