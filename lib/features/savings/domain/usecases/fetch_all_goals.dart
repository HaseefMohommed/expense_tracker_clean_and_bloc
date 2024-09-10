import 'package:dartz/dartz.dart';
import 'package:expesne_tracker_app/core/failures/failures.dart';
import 'package:expesne_tracker_app/features/savings/domain/entities/goal_entity.dart';
import 'package:expesne_tracker_app/features/savings/domain/repositories/savings_repository.dart';

class FetchAllGoals {
  final SavingsRepository savingsRepository;

  FetchAllGoals({required this.savingsRepository});

  Future<Either<Failure, List<GoalEntity>>> call() {
    return savingsRepository.fetchAllGoals();
  }
}
