import 'package:expesne_tracker_app/utils/enums/app_status.dart';
import 'package:expesne_tracker_app/utils/enums/goal_category.dart';
import 'package:expesne_tracker_app/core/failures/failures.dart';
import 'package:expesne_tracker_app/features/savings/domain/entities/goal_entity.dart';
import 'package:expesne_tracker_app/features/savings/domain/usecases/add_goal.dart';
import 'package:expesne_tracker_app/features/savings/domain/usecases/fetch_all_goals.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'goal_state.dart';
part 'goal_cubit.freezed.dart';

class GoalCubit extends Cubit<GoalState> {
  final AddGoal addGoal;
  final FetchAllGoals fetchAllGoals;

  GoalCubit({
    required this.addGoal,
    required this.fetchAllGoals,
  }) : super(const GoalState());

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

    await fetchAllGoals();
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
}
