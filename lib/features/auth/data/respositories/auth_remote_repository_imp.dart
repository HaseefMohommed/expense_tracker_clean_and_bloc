import 'package:dartz/dartz.dart';
import 'package:expesne_tracker_app/core/enums/auth_type.dart';
import 'package:expesne_tracker_app/core/exceptions/exceptions.dart';
import 'package:expesne_tracker_app/core/failures/failures.dart';
import 'package:expesne_tracker_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:expesne_tracker_app/features/auth/domain/entities/user_entity.dart';
import 'package:expesne_tracker_app/features/auth/domain/respositories/auth_remote_repository.dart';

class AuthRemoteRepositoryImp implements AuthRemoteRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRemoteRepositoryImp({
    required this.authRemoteDataSource,
  });
  @override
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final result = await authRemoteDataSource.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return right(result);
    } on AuthenticationException catch (e) {
      return left(AuthenticationFailure(
        code: e.code,
        type: AuthenticationType.signIn,
      ));
    } on ServerException catch (_) {
      return left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final result = await authRemoteDataSource.signUpWithEmailAndPassword(
        name: name,
        email: email,
        password: password,
      );
      return right(result);
    } on AuthenticationException catch (e) {
      return left(
        AuthenticationFailure(
          code: e.code,
          type: AuthenticationType.signUp,
        ),
      );
    } on ServerException catch (_) {
      return left(ServerFailure());
    }
  }
}
