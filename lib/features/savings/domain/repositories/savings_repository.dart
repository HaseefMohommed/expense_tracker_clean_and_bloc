import 'package:dartz/dartz.dart';
import 'package:expesne_tracker_app/features/savings/domain/entities/entry_entity.dart';
import 'package:expesne_tracker_app/utils/enums/expense_category.dart';
import 'package:expesne_tracker_app/utils/enums/goal_category.dart';
import 'package:expesne_tracker_app/core/failures/failures.dart';
import 'package:expesne_tracker_app/features/savings/domain/entities/goal_entity.dart';
import 'package:expesne_tracker_app/utils/enums/income_category.dart';
import 'package:expesne_tracker_app/utils/enums/payment_method.dart';

abstract class SavingsRepository {
  Future<Either<Failure, GoalEntity>> addGoal({
    required String title,
    required GoalCategory category,
    required String contributionType,
    required String selectedDate,
    required int savedAmount,
    required int goalAmount,
  });

  Future<Either<Failure, List<GoalEntity>>> fetchAllGoals();

  Future<Either<Failure, EntryEntity>> addEntry({
    required String title,
    required String addedDate,
    IncomeCategory? incomeCategory,
    ExpenseCategory? expenseCategory,
    PaymentMethod? paymentMethod,
    required int amount,
  });

  Future<Either<Failure, List<EntryEntity>>> fetchAllentries();
  Future<Either<Failure, int>> fetchTotalIncome();
  Future<Either<Failure, int>> fetchTotalExpense();
  Future<Either<Failure, int>> fetchSavedAmount();
  Future<Either<Failure, Map<String, int>>> fetchMonthlyGoalAmount();
  Future<Either<Failure, List<EntryEntity>>> fetchExpensesForDay({
    required DateTime date,
  });
  Future<Either<Failure, Map<ExpenseCategory, double>>>
      fetchTotalExpenseByCategory({
    required DateTime date,
  });
}
