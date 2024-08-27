import 'package:dartz/dartz.dart';
import 'package:expesne_tracker_app/core/failures/failures.dart';
import 'package:expesne_tracker_app/features/auth/domain/respositories/auth_remote_repository.dart';

class ResetPassword {
  final AuthRemoteRepository authRemoteRepository;

  ResetPassword({required this.authRemoteRepository});

  Future<Either<Failure, void>> call({
    required String email,
  }) {
    return authRemoteRepository.resetOldPassword(
      email: email,
    );
  }
}
