import 'package:expesne_tracker_app/features/savings/domain/entities/expense_entity.dart';
import 'package:expesne_tracker_app/utils/enums/expense_category.dart';
import 'package:expesne_tracker_app/utils/enums/payment_method.dart';
import 'package:expesne_tracker_app/utils/helpers/json_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'expense_model.freezed.dart';
part 'expense_model.g.dart';

@freezed
class ExpenseModel extends ExpenseEntity with _$ExpenseModel {
  const factory ExpenseModel({
    required String id,
    required String title,
    required String addedDate,
    @ExpenseCategoryConverter() required ExpenseCategory expenseCategory,
    @PaymentMethodConverter() required PaymentMethod paymentMethod,
    required int amount,
  }) = _ExpenseModel;

  factory ExpenseModel.fromJson(Map<String, dynamic> json) =>
      _$ExpenseModelFromJson(json);
}
