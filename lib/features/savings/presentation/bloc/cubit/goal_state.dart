part of 'goal_cubit.dart';

@freezed
class GoalState with _$GoalState {
  const factory GoalState({
    @Default(AppStatus.initial) AppStatus appState,
    GoalEntity? goalEntity,
    @Default([]) List<GoalEntity> goalsList,
    Failure? failure,
  }) = _GoalState;

  const GoalState._();
}
