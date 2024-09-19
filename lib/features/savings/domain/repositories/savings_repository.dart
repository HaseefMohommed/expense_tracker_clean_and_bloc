import 'package:dartz/dartz.dart';
import 'package:expesne_tracker_app/utils/enums/expense_category.dart';
import 'package:expesne_tracker_app/utils/enums/goal_category.dart';
import 'package:expesne_tracker_app/core/failures/failures.dart';
import 'package:expesne_tracker_app/features/savings/domain/entities/goal_entity.dart';
import 'package:expesne_tracker_app/utils/enums/payment_method.dart';

abstract class SavingsRepository {
  Future<Either<Failure, void>> addGoal({
    required String title,
    required GoalCategory category,
    required String contributionType,
    required String selectedDate,
    required int savedAmount,
    required int goalAmount,
  });

  Future<Either<Failure, List<GoalEntity>>> fetchAllGoals();

  Future<Either<Failure, void>> addExpense({
    required String title,
    required String addedDate,
    required ExpenseCategory expenseCategory,
    required PaymentMethod paymentMethod,
    required int amount,
  });
}
