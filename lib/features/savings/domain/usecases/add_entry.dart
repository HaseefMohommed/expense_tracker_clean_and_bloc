import 'package:dartz/dartz.dart';
import 'package:expesne_tracker_app/features/savings/domain/entities/entry_entity.dart';
import 'package:expesne_tracker_app/features/savings/domain/repositories/savings_repository.dart';
import 'package:expesne_tracker_app/utils/enums/expense_category.dart';
import 'package:expesne_tracker_app/utils/enums/income_category.dart';
import 'package:expesne_tracker_app/utils/enums/payment_method.dart';
import 'package:expesne_tracker_app/core/failures/failures.dart';

class AddEntry {
  final SavingsRepository savingsRepository;

  AddEntry({required this.savingsRepository});

  Future<Either<Failure, EntryEntity>> call({
    required String title,
    required String addedDate,
    IncomeCategory? incomeCategory,
    ExpenseCategory? expenseCategory,
    PaymentMethod? paymentMethod,
    required int amount,
  }) {
    return savingsRepository.addEntry(
      title: title,
      addedDate: addedDate,
      incomeCategory: incomeCategory,
      expenseCategory: expenseCategory,
      paymentMethod: paymentMethod,
      amount: amount,
    );
  }
}
