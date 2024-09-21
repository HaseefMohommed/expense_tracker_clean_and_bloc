import 'package:expesne_tracker_app/utils/enums/expense_category.dart';
import 'package:expesne_tracker_app/utils/enums/income_category.dart';
import 'package:expesne_tracker_app/utils/enums/payment_method.dart';

class EntryEntity {
  final String id;
  final String title;
  final String addedDate;
  final IncomeCategory? incomeCategory;
  final ExpenseCategory? expenseCategory;
  final PaymentMethod? paymentMethod;
  final int amount;

  EntryEntity({
    required this.id,
    required this.title,
    required this.addedDate,
    this.incomeCategory,
    this.expenseCategory,
    this.paymentMethod,
    required this.amount,
  });
}
