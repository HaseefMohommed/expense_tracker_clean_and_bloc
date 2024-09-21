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
    Failure? failure,
  }) = _SavingsState;

  const SavingsState._();
}
