import 'package:expesne_tracker_app/core/enums/app_status.dart';
import 'package:expesne_tracker_app/core/enums/validity_status.dart';
import 'package:expesne_tracker_app/core/failures/failures.dart';
import 'package:expesne_tracker_app/features/auth/domain/entities/user_entity.dart';
import 'package:expesne_tracker_app/features/auth/domain/usecases/sign_in_with_email_and_password.dart';
import 'package:expesne_tracker_app/features/auth/domain/usecases/sign_up_with_email_and_password.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.dart';
part 'auth_cubit.freezed.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignInWithEmailAndPassword signInWithEmailAndPassword;
  final SignUpWithEmailAndPassword signUpWithEmailAndPassword;

  AuthCubit({
    required this.signInWithEmailAndPassword,
    required this.signUpWithEmailAndPassword,
  }) : super(const AuthState());

  static final RegExp _nameRegExp =
      RegExp(r'^[a-zA-Z]{2,}(?: [a-zA-Z]+){0,2}$');
  static final RegExp _emailRegExp =
      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  static final RegExp _passwordRegExp =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  void validateField(String field, String value) {
    ValidityStatus status = ValidityStatus.valid;
    if (value.isEmpty) {
      status = ValidityStatus.empty;
    } else {
      bool isValid = switch (field) {
        'name' => _nameRegExp.hasMatch(value),
        'email' => _emailRegExp.hasMatch(value),
        'password' => _passwordRegExp.hasMatch(value),
        _ => false,
      };
      status = isValid ? ValidityStatus.valid : ValidityStatus.invalid;
    }

    emit(state.copyWith(
      nameValidityStatus: field == 'name' ? status : state.nameValidityStatus,
      emailValidityStatus:
          field == 'email' ? status : state.emailValidityStatus,
      passwordValidityStatus:
          field == 'password' ? status : state.passwordValidityStatus,
    ));
  }

  void validateLoginFields({
    required String email,
    required String password,
  }) {
    validateField('email', email);
    validateField('password', password);
  }

  void validateSignUpFields({
    required String name,
    required String email,
    required String password,
  }) {
    validateField('name', name);
    validateField('email', email);
    validateField('password', password);
  }

  Future<void> signInwithEmail({
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(appState: AppStatus.loading));

    final result =
        await signInWithEmailAndPassword(email: email, password: password);

    emit(result.fold(
      (failure) =>
          state.copyWith(appState: AppStatus.failure, faliure: failure),
      (user) => state.copyWith(appState: AppStatus.success, userEntity: user),
    ));
  }

  Future<void> signUpWithEmail({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(appState: AppStatus.loading));

    final result = await signUpWithEmailAndPassword(
      email: email,
      name: name,
      password: password,
    );

    emit(result.fold(
      (failure) =>
          state.copyWith(appState: AppStatus.failure, faliure: failure),
      (user) => state.copyWith(
        appState: AppStatus.success,
        userEntity: user,
      ),
    ));
  }
}
