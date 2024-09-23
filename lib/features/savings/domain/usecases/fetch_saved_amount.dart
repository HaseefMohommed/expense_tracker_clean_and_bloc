import 'package:dartz/dartz.dart';
import 'package:expesne_tracker_app/core/failures/failures.dart';
import 'package:expesne_tracker_app/features/savings/domain/repositories/savings_repository.dart';

class FetchSavedAmount {
  final SavingsRepository savingsRepository;

  FetchSavedAmount({required this.savingsRepository});

  Future<Either<Failure, int>> call() {
    return savingsRepository.fetchSavedAmount();
  }
}