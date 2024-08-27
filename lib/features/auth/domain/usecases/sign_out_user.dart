import 'package:dartz/dartz.dart';
import 'package:expesne_tracker_app/core/failures/failures.dart';
import 'package:expesne_tracker_app/features/auth/domain/respositories/auth_remote_repository.dart';

class SignOutUser {
  final AuthRemoteRepository authRemoteRepository;

  SignOutUser({required this.authRemoteRepository});

  Future<Either<Failure, void>> call() {
    return authRemoteRepository.signOutUser();
  }
}
