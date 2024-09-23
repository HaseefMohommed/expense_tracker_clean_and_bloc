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

  Future<List<EntryEntity>> fetchAllentris();
  Future<int> fetchTotalIncome();
  Future<int> fetchTotalExpense();
  Future<int> fetchSavedAmount();
  Future<Map<String, int>> fetchMonthlyGoalAmount();
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

  @override
  Future<List<EntryEntity>> fetchAllentris() async {
    try {
      final QuerySnapshot entriesSnapshot =
          await firebaseFirestore.collection('entries').get();

      return entriesSnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;

        data['id'] = doc.id;
        return EntryModel.fromJson(data);
      }).toList();
    } on FirebaseException catch (_) {
      throw ServerFailure();
    } catch (e) {
      throw ServerFailure();
    }
  }

  @override
  Future<int> fetchTotalIncome() async {
    try {
      final QuerySnapshot incomeSnapshot = await firebaseFirestore
          .collection('entries')
          .where('expenseCategory', isNull: true)
          .get();

      int totalIncome = 0;
      for (var doc in incomeSnapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        totalIncome += (data['amount'] as num).toInt();
      }

      return totalIncome;
    } on FirebaseException catch (_) {
      throw ServerFailure();
    } catch (e) {
      throw ServerFailure();
    }
  }

  @override
  Future<int> fetchTotalExpense() async {
    try {
      final QuerySnapshot expenseSnapshot = await firebaseFirestore
          .collection('entries')
          .where('expenseCategory', isNull: false)
          .get();

      int totalExpense = 0;
      for (var doc in expenseSnapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        totalExpense += (data['amount'] as num).toInt();
      }

      return totalExpense;
    } on FirebaseException catch (_) {
      throw ServerFailure();
    } catch (e) {
      throw ServerFailure();
    }
  }

  @override
  Future<int> fetchSavedAmount() async {
    try {
      final goals = await fetchAllGoals();
      return goals.fold<int>(
          0, (accumulator, goal) => accumulator + goal.savedAmount);
    } catch (e) {
      throw ServerFailure();
    }
  }

  @override
  Future<Map<String, int>> fetchMonthlyGoalAmount() async {
    try {
      final DateTime now = DateTime.now();
      final String startOfMonth =
          '${now.year}-${now.month.toString().padLeft(2, '0')}-01';
      final String endOfMonth =
          '${now.year}-${now.month.toString().padLeft(2, '0')}-${DateTime(now.year, now.month + 1, 0).day.toString().padLeft(2, '0')}';

      final QuerySnapshot goalsSnapshot = await firebaseFirestore
          .collection('goals')
          .where('selectedDate', isGreaterThanOrEqualTo: startOfMonth)
          .where('selectedDate', isLessThanOrEqualTo: endOfMonth)
          .get();

      int monthlyGoalAmount = 0;
      int monthlySavedAmount = 0;

      for (var doc in goalsSnapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        monthlyGoalAmount += (data['goalAmount'] as num).toInt();
        monthlySavedAmount += (data['savedAmount'] as num).toInt();
      }

      return {
        'GoalAmount': monthlyGoalAmount,
        'SavedAmount': monthlySavedAmount,
      };
    } on FirebaseException catch (_) {
      throw ServerFailure();
    } catch (e) {
      throw ServerFailure();
    }
  }
}
