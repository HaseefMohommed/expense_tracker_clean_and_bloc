part of 'savings_cubit.dart';

@freezed
class SavingsState with _$SavingsState {
  const factory SavingsState({
    @Default(AppStatus.initial) AppStatus appState,
    GoalEntity? goalEntity,
    ExpenseEntity? expenseEntity,
    @Default([]) List<GoalEntity> goalsList,
    @Default([]) List<ExpenseEntity> expensesList,
    Failure? failure,
  }) = _SavingsState;

  const SavingsState._();
}
