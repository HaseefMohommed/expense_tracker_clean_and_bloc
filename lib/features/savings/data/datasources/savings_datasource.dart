import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expesne_tracker_app/core/failures/failures.dart';
import 'package:expesne_tracker_app/features/savings/data/models/goal_model.dart';
import 'package:expesne_tracker_app/features/savings/domain/entities/goal_entity.dart';

abstract class SavingsDatasource {
  Future<void> addGoal({
    required String title,
    required String category,
    required String contributionType,
    required String selectedDate,
    required int savedAmount,
    required int goalAmount,
  });

  Future<List<GoalEntity>> fetchAllGoals();
}

class SavingsDatasourceImp extends SavingsDatasource {
  final FirebaseFirestore firebaseFirestore;

  SavingsDatasourceImp({
    required this.firebaseFirestore,
  });

  @override
  Future<void> addGoal({
    required String title,
    required String category,
    required String contributionType,
    required String selectedDate,
    required int savedAmount,
    required int goalAmount,
  }) async {
    try {
      final newGoalRef = firebaseFirestore.collection('goals').doc();

      final goalModel = GoalModel(
        id: newGoalRef.id,
        title: title,
        category: category,
        contributionType: contributionType,
        selectedDate: selectedDate,
        savedAmount: savedAmount,
        goalAmount: goalAmount,
      );

      final goalJson = goalModel.toJson();
      goalJson['id'] = newGoalRef.id;

      await newGoalRef.set(goalJson);
    } on FirebaseException catch (_) {
      throw ServerFailure();
    } catch (e) {
      throw ServerFailure();
    }
  }

  @override
  Future<List<GoalEntity>> fetchAllGoals() async {
    try {
      final goalsMap = await firebaseFirestore.collection('goals').get();
      return goalsMap.docs
          .map((goal) => GoalModel.fromJson({...goal.data(), 'id': goal.id}))
          .toList();
    } on FirebaseException catch (_) {
      throw ServerFailure();
    } catch (e) {
      throw ServerFailure();
    }
  }
}
