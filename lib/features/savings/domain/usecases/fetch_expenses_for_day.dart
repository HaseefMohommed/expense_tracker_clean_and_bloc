import 'package:dartz/dartz.dart';
import 'package:expesne_tracker_app/core/failures/failures.dart';
import 'package:expesne_tracker_app/features/savings/domain/entities/entry_entity.dart';
import 'package:expesne_tracker_app/features/savings/domain/repositories/savings_repository.dart';

class FetchExpensesForDay {
  final SavingsRepository savingsRepository;

  FetchExpensesForDay({required this.savingsRepository});

  Future<Either<Failure, List<EntryEntity>>> call({
    required DateTime date,
  }) {
    return savingsRepository.fetchExpensesForDay(
      date: date,
    );
  }
}
