import 'package:expesne_tracker_app/utils/enums/expense_category.dart';
import 'package:expesne_tracker_app/utils/enums/payment_method.dart';

class ExpenseEntity {
  final String id;
  final String title;
  final String addedDate;
  final ExpenseCategory expenseCategory;
  final PaymentMethod paymentMethod;
  final int amount;

  ExpenseEntity({
    required this.id,
    required this.title,
    required this.addedDate,
    required this.expenseCategory,
    required this.paymentMethod,
    required this.amount,
  });
}
