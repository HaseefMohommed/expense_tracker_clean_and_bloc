import 'package:expesne_tracker_app/features/savings/domain/entities/expense_entity.dart';
import 'package:expesne_tracker_app/features/savings/domain/usecases/add_expense.dart';
import 'package:expesne_tracker_app/utils/enums/app_status.dart';
import 'package:expesne_tracker_app/utils/enums/expense_category.dart';
import 'package:expesne_tracker_app/utils/enums/goal_category.dart';
import 'package:expesne_tracker_app/core/failures/failures.dart';
import 'package:expesne_tracker_app/features/savings/domain/entities/goal_entity.dart';
import 'package:expesne_tracker_app/features/savings/domain/usecases/add_goal.dart';
import 'package:expesne_tracker_app/features/savings/domain/usecases/fetch_all_goals.dart';
import 'package:expesne_tracker_app/utils/enums/payment_method.dart';
import 'package:expesne_tracker_app/utils/enums/validity_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'savings_state.dart';
part 'savings_cubit.freezed.dart';

class SavingsCubit extends Cubit<SavingsState> {
  final AddGoal addGoal;
  final AddExpense addExpense;
  final FetchAllGoals fetchAllGoals;

  SavingsCubit({
    required this.addGoal,
    required this.addExpense,
    required this.fetchAllGoals,
  }) : super(const SavingsState());

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

    emit(
      result.fold(
        (failure) =>
            state.copyWith(appState: AppStatus.failure, failure: failure),
        (_) => state.copyWith(
          appState: AppStatus.success,
        ),
      ),
    );

    await fetchGoals();
  }

  Future<void> fetchGoals() async {
    emit(state.copyWith(appState: AppStatus.loading));
    final result = await fetchAllGoals();

    emit(
      result.fold(
        (failure) =>
            state.copyWith(appState: AppStatus.failure, failure: failure),
        (goalsList) => state.copyWith(
          appState: AppStatus.success,
          goalsList: goalsList,
        ),
      ),
    );
  }

  Future<void> addNewExpense({
    required String title,
    required String addedDate,
    required ExpenseCategory expenseCategory,
    required PaymentMethod paymentMethod,
    required int amount,
  }) async {
    emit(state.copyWith(appState: AppStatus.loading));

    final result = await addExpense(
      title: title,
      addedDate: addedDate,
      expenseCategory: expenseCategory,
      paymentMethod: paymentMethod,
      amount: amount,
    );

    emit(
      result.fold(
        (failure) =>
            state.copyWith(appState: AppStatus.failure, failure: failure),
        (_) => state.copyWith(
          appState: AppStatus.success,
        ),
      ),
    );
  }
}
