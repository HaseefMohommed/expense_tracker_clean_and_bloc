import 'package:expesne_tracker_app/core/enums/app_status.dart';
import 'package:expesne_tracker_app/core/failures/failures.dart';
import 'package:expesne_tracker_app/features/savings/domain/entities/goal_entity.dart';
import 'package:expesne_tracker_app/features/savings/domain/usecases/add_goal.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'goal_state.dart';
part 'goal_cubit.freezed.dart';

class GoalCubit extends Cubit<GoalState> {
  final AddGoal addGoal;
  GoalCubit({
    required this.addGoal,
  }) : super(const GoalState());

  Future<void> addNewGoal({
    required String title,
    required String category,
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
            state.copyWith(appState: AppStatus.failure, faliure: failure),
        (_) => state.copyWith(
          appState: AppStatus.success,
        ),
      ),
    );
  }
}
