import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expesne_tracker_app/features/savings/data/models/expense/expense_model.dart';
import 'package:expesne_tracker_app/utils/enums/expense_category.dart';
import 'package:expesne_tracker_app/utils/enums/goal_category.dart';
import 'package:expesne_tracker_app/core/failures/failures.dart';
import 'package:expesne_tracker_app/features/savings/data/models/goal/goal_model.dart';
import 'package:expesne_tracker_app/features/savings/domain/entities/goal_entity.dart';
import 'package:expesne_tracker_app/utils/enums/payment_method.dart';

abstract class SavingsDatasource {
  Future<void> addGoal({
    required String title,
    required GoalCategory category,
    required String contributionType,
    required String selectedDate,
    required int savedAmount,
    required int goalAmount,
  });

  Future<List<GoalEntity>> fetchAllGoals();

  Future<void> addExpense({
    required String title,
    required String addedDate,
    required ExpenseCategory expenseCategory,
    required PaymentMethod paymentMethod,
    required int amount,
  });
}

class SavingsDatasourceImp extends SavingsDatasource {
  final FirebaseFirestore firebaseFirestore;

  SavingsDatasourceImp({
    required this.firebaseFirestore,
  });

  @override
  Future<void> addGoal({
    required String title,
    required GoalCategory category,
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
      final QuerySnapshot goalsSnapshot =
          await firebaseFirestore.collection('goals').get();

      return goalsSnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;

        data['id'] = doc.id;
        return GoalModel.fromJson(data);
      }).toList();
    } on FirebaseException catch (_) {
      throw ServerFailure();
    } catch (e) {
      throw ServerFailure();
    }
  }

  @override
  Future<void> addExpense({
    required String title,
    required String addedDate,
    required ExpenseCategory expenseCategory,
    required PaymentMethod paymentMethod,
    required int amount,
  }) async {
    try {
      final newExpenseRef = firebaseFirestore.collection('expenses').doc();

      final expenseModel = ExpenseModel(
        id: newExpenseRef.id,
        title: title,
        addedDate: addedDate,
        expenseCategory: expenseCategory,
        paymentMethod: paymentMethod,
        amount: amount,
      );

      final expenseJson = expenseModel.toJson();
      expenseJson['id'] = newExpenseRef.id;

      await newExpenseRef.set(expenseJson);
    } on FirebaseException catch (_) {
      throw ServerFailure();
    } catch (e) {
      throw ServerFailure();
    }
  }
}
