import 'package:expesne_tracker_app/features/savings/domain/entities/goal_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'goal_model.freezed.dart';
part 'goal_model.g.dart';

@freezed
class GoalModel extends GoalEntity with _$GoalModel {
  const factory GoalModel({
    required String id,
    required String title,
    required String category,
    required String contributionType,
    required String selectedDate,
    required int savedAmount,
    required int goalAmount,
  }) = _GoalModel;

  factory GoalModel.fromJson(Map<String, dynamic> json) =>
      _$GoalModelFromJson(json);
}
