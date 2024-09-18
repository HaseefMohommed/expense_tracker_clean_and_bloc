import 'package:dartz/dartz.dart';
import 'package:expesne_tracker_app/utils/enums/goal_category.dart';
import 'package:expesne_tracker_app/core/failures/failures.dart';
import 'package:expesne_tracker_app/features/savings/domain/repositories/savings_repository.dart';

class AddGoal {
  final SavingsRepository savingsRepository;

  AddGoal({required this.savingsRepository});

  Future<Either<Failure, void>> call({
    required String title,
    required GoalCategory category,
    required String contributionType,
    required String selectedDate,
    required int savedAmount,
    required int goalAmount,
  }) {
    return savingsRepository.addGoal(
      title: title,
      category: category,
      contributionType: contributionType,
      selectedDate: selectedDate,
      savedAmount: savedAmount,
      goalAmount: goalAmount,
    );
  }
}
