import 'package:expesne_tracker_app/features/savings/domain/entities/entry_entity.dart';
import 'package:expesne_tracker_app/features/savings/domain/usecases/add_entry.dart';
import 'package:expesne_tracker_app/utils/enums/app_status.dart';
import 'package:expesne_tracker_app/utils/enums/expense_category.dart';
import 'package:expesne_tracker_app/utils/enums/goal_category.dart';
import 'package:expesne_tracker_app/core/failures/failures.dart';
import 'package:expesne_tracker_app/features/savings/domain/entities/goal_entity.dart';
import 'package:expesne_tracker_app/features/savings/domain/usecases/add_goal.dart';
import 'package:expesne_tracker_app/features/savings/domain/usecases/fetch_all_goals.dart';
import 'package:expesne_tracker_app/utils/enums/income_category.dart';
import 'package:expesne_tracker_app/utils/enums/payment_method.dart';
import 'package:expesne_tracker_app/utils/enums/validity_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'savings_state.dart';
part 'savings_cubit.freezed.dart';

class SavingsCubit extends Cubit<SavingsState> {
  final AddGoal addGoal;
  final AddEntry addEntry;
  final FetchAllGoals fetchAllGoals;

  SavingsCubit({
    required this.addGoal,
    required this.addEntry,
    required this.fetchAllGoals,
  }) : super(const SavingsState());

  void validateFields({
    required String title,
    required String amount,
    required String date,
    String? goalCategory,
    String? expenseCategory,
    String? incomeCategory,
    String? paymentMethod,
    String? contributionType,
    bool isValidDate = true,
  }) {
    final Map<String, ValidityStatus> fieldStatuses = {};

    void validateField(
      String field,
      String? value,
      bool Function(String) isValid,
    ) {
      if (value != null) {
        fieldStatuses[field] = value.isEmpty
            ? ValidityStatus.empty
            : isValid(value)
                ? ValidityStatus.valid
                : ValidityStatus.invalid;
      }
    }

    final Map<String, bool Function(String)> validations = {
      'title': (value) => value.isNotEmpty,
      'amount': (value) {
        if (value.isEmpty) return false;
        try {
          int.parse(value);
          return true;
        } catch (_) {
          return false;
        }
      },
      'date': (value) => value.isNotEmpty && isValidDate,
      'goalCategory': (value) => value.isNotEmpty,
      'expenseCategory': (value) => value.isNotEmpty,
      'incomeCategory': (value) => value.isNotEmpty,
      'paymentMethod': (value) => value.isNotEmpty,
      'contributionType': (value) => value.isNotEmpty,
    };

    final Map<String, String?> fieldValues = {
      'title': title,
      'amount': amount,
      'date': date,
      'goalCategory': goalCategory,
      'expenseCategory': expenseCategory,
      'incomeCategory': incomeCategory,
      'paymentMethod': paymentMethod,
      'contributionType': contributionType,
    };

    fieldValues.forEach((field, value) {
      if (value != null) {
        final isValid = validations[field];
        if (isValid != null) {
          validateField(field, value, isValid);
        }
      }
    });

    emit(state.copyWith(
      formValidityStatus: Map.fromEntries(
        fieldStatuses.keys.map(
          (field) =>
              MapEntry(field, fieldStatuses[field] ?? ValidityStatus.valid),
        ),
      ),
      appState: AppStatus.initial,
    ));
  }

  void resetForm() {
    emit(const SavingsState());
  }

  Future<void> addNewGoal({
    required String title,
    required GoalCategory category,
    required String contributionType,
    required String selectedDate,
    required int savedAmount,
    required int goalAmount,
  }) async {
    emit(state.copyWith(appState: AppStatus.loading));

    final result = await addGoal(
      title: title,
      category: category,
      contributionType: contributionType,
      selectedDate: selectedDate,
      savedAmount: savedAmount,
      goalAmount: goalAmount,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        appState: AppStatus.failure,
        failure: failure,
      )),
      (newGoal) => emit(state.copyWith(
        appState: AppStatus.success,
        goalEntity: newGoal,
        goalsList: [...state.goalsList, newGoal],
      )),
    );
  }

  Future<void> fetchGoals() async {
    emit(state.copyWith(appState: AppStatus.loading));
    final result = await fetchAllGoals();

    result.fold(
      (failure) => emit(state.copyWith(
        appState: AppStatus.failure,
        failure: failure,
      )),
      (goalsList) => emit(state.copyWith(
        appState: AppStatus.success,
        goalsList: goalsList,
      )),
    );
  }

  Future<void> addNewEntry({
    required String title,
    required String addedDate,
    IncomeCategory? incomeCategory,
    ExpenseCategory? expenseCategory,
    PaymentMethod? paymentMethod,
    required int amount,
  }) async {
    emit(state.copyWith(appState: AppStatus.loading));

    final result = await addEntry(
      title: title,
      addedDate: addedDate,
      incomeCategory: incomeCategory,
      expenseCategory: expenseCategory,
      paymentMethod: paymentMethod,
      amount: amount,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        appState: AppStatus.failure,
        failure: failure,
      )),
      (newEntry) => emit(state.copyWith(
        appState: AppStatus.success,
        entryEntity: newEntry,
        entriesList: [...state.entriesList, newEntry],
      )),
    );
  }
}
