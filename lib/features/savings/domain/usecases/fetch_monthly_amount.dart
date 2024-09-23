import 'package:dartz/dartz.dart';
import 'package:expesne_tracker_app/core/failures/failures.dart';
import 'package:expesne_tracker_app/features/savings/domain/repositories/savings_repository.dart';

class FetchMonthlyGoalAmount {
  final SavingsRepository savingsRepository;

  FetchMonthlyGoalAmount({required this.savingsRepository});

  Future<Either<Failure, Map<String, int>>> call() {
    return savingsRepository.fetchMonthlyGoalAmount();
  }
}
