import 'package:expesne_tracker_app/utils/enums/expense_category.dart';
import 'package:expesne_tracker_app/utils/enums/goal_category.dart';
import 'package:expesne_tracker_app/utils/enums/income_category.dart';
import 'package:expesne_tracker_app/utils/enums/payment_method.dart';
import 'package:json_annotation/json_annotation.dart';

class GoalCategoryConverter implements JsonConverter<GoalCategory, String> {
  const GoalCategoryConverter();

  @override
  GoalCategory fromJson(String json) {
    return GoalCategory.values.firstWhere(
      (category) => category.toString().split('.').last == json,
      orElse: () => GoalCategory.other,
    );
  }

  @override
  String toJson(GoalCategory category) => category.toString().split('.').last;
}

class ExpenseCategoryConverter implements JsonConverter<ExpenseCategory, String> {
  const ExpenseCategoryConverter();

  @override
  ExpenseCategory fromJson(String json) {
    return ExpenseCategory.values.firstWhere(
      (category) => category.toString().split('.').last == json,
      orElse: () => ExpenseCategory.other,
    );
  }

  @override
  String toJson(ExpenseCategory category) =>
      category.toString().split('.').last;
}

class IncomeCategoryConverter implements JsonConverter<IncomeCategory, String> {
  const IncomeCategoryConverter();

  @override
  IncomeCategory fromJson(String json) {
    return IncomeCategory.values.firstWhere(
      (category) => category.toString().split('.').last == json,
      orElse: () => IncomeCategory.other,
    );
  }

  @override
  String toJson(IncomeCategory category) => category.toString().split('.').last;
}

class PaymentMethodConverter implements JsonConverter<PaymentMethod, String> {
  const PaymentMethodConverter();

  @override
  PaymentMethod fromJson(String json) {
    return PaymentMethod.values.firstWhere(
      (category) => category.toString().split('.').last == json,
      orElse: () => PaymentMethod.creditCard,
    );
  }

  @override
  String toJson(PaymentMethod category) => category.toString().split('.').last;
}


