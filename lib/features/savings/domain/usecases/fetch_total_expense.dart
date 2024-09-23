import 'package:dartz/dartz.dart';
import 'package:expesne_tracker_app/core/failures/failures.dart';
import 'package:expesne_tracker_app/features/savings/domain/repositories/savings_repository.dart';

class FetchTotalExpense {
  final SavingsRepository savingsRepository;

  FetchTotalExpense({required this.savingsRepository});

  Future<Either<Failure, int>> call() {
    return savingsRepository.fetchTotalExpense();
  }
}
