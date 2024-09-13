import 'package:dartz/dartz.dart';
import 'package:expesne_tracker_app/core/failures/failures.dart';
import 'package:expesne_tracker_app/features/auth/domain/entities/user_entity.dart';
import 'package:expesne_tracker_app/features/auth/domain/respositories/auth_remote_repository.dart';

class AuthWithFacebook {
  final AuthRemoteRepository authRemoteRepository;

  AuthWithFacebook({required this.authRemoteRepository});

  Future<Either<Failure, UserEntity>> call() {
    return authRemoteRepository.authWithFacebook();
  }
}
