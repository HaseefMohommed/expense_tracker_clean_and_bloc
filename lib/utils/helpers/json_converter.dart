import 'package:expesne_tracker_app/utils/enums/goal_category.dart';
import 'package:json_annotation/json_annotation.dart';

class GoalCategoryConverter implements JsonConverter<GoalCategory, String> {
  const GoalCategoryConverter();

  @override
  GoalCategory fromJson(String json) {
    return GoalCategory.values.firstWhere(
      (category) => category.toString().split('.').last == json,
      orElse: () => GoalCategory.other,
    );
  }

  @override
  String toJson(GoalCategory category) => category.toString().split('.').last;
}