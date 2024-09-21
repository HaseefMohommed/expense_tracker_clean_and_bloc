import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expesne_tracker_app/features/savings/data/models/entry_model/entry_model.dart';
import 'package:expesne_tracker_app/features/savings/domain/entities/entry_entity.dart';
import 'package:expesne_tracker_app/utils/enums/expense_category.dart';
import 'package:expesne_tracker_app/utils/enums/goal_category.dart';
import 'package:expesne_tracker_app/core/failures/failures.dart';
import 'package:expesne_tracker_app/features/savings/data/models/goal/goal_model.dart';
import 'package:expesne_tracker_app/features/savings/domain/entities/goal_entity.dart';
import 'package:expesne_tracker_app/utils/enums/income_category.dart';
import 'package:expesne_tracker_app/utils/enums/payment_method.dart';

abstract class SavingsDatasource {
  Future<GoalEntity> addGoal({
    required String title,
    required GoalCategory category,
    required String contributionType,
    required String selectedDate,
    required int savedAmount,
    required int goalAmount,
  });

  Future<List<GoalEntity>> fetchAllGoals();

  Future<EntryEntity> addEntry({
    required String title,
    required String addedDate,
    IncomeCategory? incomeCategory,
    ExpenseCategory? expenseCategory,
    PaymentMethod? paymentMethod,
    required int amount,
  });
}

class SavingsDatasourceImp extends SavingsDatasource {
  final FirebaseFirestore firebaseFirestore;

  SavingsDatasourceImp({
    required this.firebaseFirestore,
  });

  @override
  Future<GoalEntity> addGoal({
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

      return GoalEntity(
        id: goalModel.id,
        title: goalModel.title,
        category: goalModel.category,
        contributionType: goalModel.contributionType,
        selectedDate: goalModel.selectedDate,
        savedAmount: goalModel.savedAmount,
        goalAmount: goalModel.goalAmount,
      );
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
  Future<EntryEntity> addEntry({
    required String title,
    required String addedDate,
    IncomeCategory? incomeCategory,
    ExpenseCategory? expenseCategory,
    PaymentMethod? paymentMethod,
    required int amount,
  }) async {
    try {
      final newEntryRef = firebaseFirestore.collection('entries').doc();

      final entryModel = EntryModel(
        id: newEntryRef.id,
        title: title,
        addedDate: addedDate,
        incomeCategory: incomeCategory,
        expenseCategory: expenseCategory,
        paymentMethod: paymentMethod,
        amount: amount,
      );

      final entryJson = entryModel.toJson();
      entryJson['id'] = newEntryRef.id;

      await newEntryRef.set(entryJson);

      return EntryEntity(
        id: entryModel.id,
        title: entryModel.title,
        addedDate: entryModel.addedDate,
        incomeCategory: entryModel.incomeCategory,
        expenseCategory: entryModel.expenseCategory,
        paymentMethod: entryModel.paymentMethod,
        amount: entryModel.amount,
      );
    } on FirebaseException catch (_) {
      throw ServerFailure();
    } catch (e) {
      throw ServerFailure();
    }
  }
}
