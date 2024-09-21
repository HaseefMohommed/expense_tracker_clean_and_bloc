import 'package:expesne_tracker_app/features/savings/domain/entities/entry_entity.dart';
import 'package:expesne_tracker_app/utils/enums/expense_category.dart';
import 'package:expesne_tracker_app/utils/enums/income_category.dart';
import 'package:expesne_tracker_app/utils/enums/payment_method.dart';
import 'package:expesne_tracker_app/utils/helpers/json_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'entry_model.freezed.dart';
part 'entry_model.g.dart';

@freezed
class EntryModel extends EntryEntity with _$EntryModel {
  const factory EntryModel({
    required String id,
    required String title,
    required String addedDate,
    required int amount,
    @ExpenseCategoryConverter() ExpenseCategory? expenseCategory,
    @IncomeCategoryConverter() IncomeCategory? incomeCategory,
    @PaymentMethodConverter() PaymentMethod? paymentMethod,
  }) = _EntryModel;

  factory EntryModel.fromJson(Map<String, dynamic> json) =>
      _$EntryModelFromJson(json);
}
