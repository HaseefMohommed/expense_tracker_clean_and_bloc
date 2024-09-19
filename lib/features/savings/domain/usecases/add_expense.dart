import 'package:dartz/dartz.dart';
import 'package:expesne_tracker_app/features/savings/domain/repositories/savings_repository.dart';
import 'package:expesne_tracker_app/utils/enums/expense_category.dart';
import 'package:expesne_tracker_app/utils/enums/payment_method.dart';
import 'package:expesne_tracker_app/core/failures/failures.dart';

class AddExpense {
  final SavingsRepository savingsRepository;

  AddExpense({required this.savingsRepository});

  Future<Either<Failure, void>> call({
    required String title,
    required String addedDate,
    required ExpenseCategory expenseCategory,
    required PaymentMethod paymentMethod,
    required int amount,
  }) {
    return savingsRepository.addExpense(
      title: title,
      addedDate: addedDate,
      expenseCategory: expenseCategory,
      paymentMethod: paymentMethod,
      amount: amount,
    );
  }
}
