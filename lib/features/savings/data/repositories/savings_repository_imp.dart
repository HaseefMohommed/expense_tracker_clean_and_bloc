import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:expesne_tracker_app/core/failures/failures.dart';
import 'package:expesne_tracker_app/features/savings/data/datasources/savings_datasource.dart';
import 'package:expesne_tracker_app/features/savings/domain/entities/goal_entity.dart';
import 'package:expesne_tracker_app/features/savings/domain/repositories/savings_repository.dart';

class SavingsRepositoryImp implements SavingsRepository {
  final SavingsDatasource savingsDatasource;

  SavingsRepositoryImp({
    required this.savingsDatasource,
  });
  @override
  Future<Either<Failure, void>> addGoal({
    required String title,
    required String category,
    required String contributionType,
    required String selectedDate,
    required int savedAmount,
    required int goalAmount,
  }) async {
    try {
      final result = await savingsDatasource.addGoal(
        title: title,
        category: category,
        contributionType: contributionType,
        selectedDate: selectedDate,
        savedAmount: savedAmount,
        goalAmount: goalAmount,
      );
      return Right(result);
    } on FirebaseException catch (_) {
      return Left(ServerFailure());
    } catch (e) {
      return Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, List<GoalEntity>>> fetchAllGoals() async {
    try {
      final result = await savingsDatasource.fetchAllGoals();
      return Right(result);
    } on FirebaseException catch (_) {
      return Left(ServerFailure());
    } catch (e) {
      return Left(UnexpectedFailure());
    }
  }
}
