part of 'savings_cubit.dart';

@freezed
class SavingsState with _$SavingsState {
  const factory SavingsState({
    @Default(AppStatus.initial) AppStatus appState,
    GoalEntity? goalEntity,
    EntryEntity? entryEntity,
    @Default([]) List<GoalEntity> goalsList,
    @Default([]) List<EntryEntity> entriesList,
    @Default({}) Map<String, ValidityStatus> formValidityStatus,
    @Default(0) int totalIncome,
    @Default(0) int totalExpense,
    @Default(0) int savedAmount,
    @Default({}) Map<String, int> monthlyGoalAmount,
    Failure? failure,
  }) = _SavingsState;

  const SavingsState._();
}
