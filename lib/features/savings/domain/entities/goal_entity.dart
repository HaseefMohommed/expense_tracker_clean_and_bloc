import 'package:expesne_tracker_app/utils/enums/goal_category.dart';

class GoalEntity {
  final String id;
  final String title;
  final GoalCategory category;
  final String contributionType;
  final String selectedDate;
  final int savedAmount;
  final int goalAmount;

  GoalEntity({
    required this.id,
    required this.title,
    required this.category,
    required this.contributionType,
    required this.selectedDate,
    required this.savedAmount,
    required this.goalAmount,
  });
}
