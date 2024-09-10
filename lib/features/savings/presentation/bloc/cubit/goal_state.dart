part of 'goal_cubit.dart';

@freezed
class GoalState with _$GoalState {
  const factory GoalState({
    @Default(AppStatus.initial) AppStatus appState,
    GoalEntity? goalEntity,
    Failure? faliure,
  }) = _GoalState;

  const GoalState._();
}
