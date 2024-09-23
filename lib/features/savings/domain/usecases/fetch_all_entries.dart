import 'package:dartz/dartz.dart';
import 'package:expesne_tracker_app/core/failures/failures.dart';
import 'package:expesne_tracker_app/features/savings/domain/entities/entry_entity.dart';
import 'package:expesne_tracker_app/features/savings/domain/repositories/savings_repository.dart';

class FetchAllEntries {
  final SavingsRepository savingsRepository;

  FetchAllEntries({required this.savingsRepository});

  Future<Either<Failure, List<EntryEntity>>> call() {
    return savingsRepository.fetchAllentries();
  }
}
