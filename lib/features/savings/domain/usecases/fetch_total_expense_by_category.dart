import 'package:dartz/dartz.dart';
import 'package:expesne_tracker_app/core/failures/failures.dart';
import 'package:expesne_tracker_app/features/savings/domain/repositories/savings_repository.dart';
import 'package:expesne_tracker_app/utils/enums/expense_category.dart';

class FetchTotalExpenseByCategory {
  final SavingsRepository savingsRepository;

  FetchTotalExpenseByCategory({required this.savingsRepository});

  Future<Either<Failure, Map<ExpenseCategory, double>>> call({
    required DateTime date,
  }) {
    return savingsRepository.fetchTotalExpenseByCategory(
      date: date,
    );
  }
}
