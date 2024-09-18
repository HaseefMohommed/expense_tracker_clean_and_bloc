import 'package:expesne_tracker_app/utils/enums/app_status.dart';
import 'package:expesne_tracker_app/utils/enums/validity_status.dart';
import 'package:expesne_tracker_app/core/failures/failures.dart';
import 'package:expesne_tracker_app/features/auth/domain/entities/user_entity.dart';
import 'package:expesne_tracker_app/features/auth/domain/usecases/auth_with_facebook.dart';
import 'package:expesne_tracker_app/features/auth/domain/usecases/auth_with_google.dart';
import 'package:expesne_tracker_app/features/auth/domain/usecases/reset_password.dart';
import 'package:expesne_tracker_app/features/auth/domain/usecases/sign_in_with_email_and_password.dart';
import 'package:expesne_tracker_app/features/auth/domain/usecases/sign_out_user.dart';
import 'package:expesne_tracker_app/features/auth/domain/usecases/sign_up_with_email_and_password.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.dart';
part 'auth_cubit.freezed.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignInWithEmailAndPassword signInWithEmailAndPassword;
  final SignUpWithEmailAndPassword signUpWithEmailAndPassword;
  final AuthWithGoogle authWithGoogle;
  final AuthWithFacebook authWithApple;
  final ResetPassword resetPassword;
  final SignOutUser signOut;

  AuthCubit({
    required this.signInWithEmailAndPassword,
    required this.signUpWithEmailAndPassword,
    required this.authWithGoogle,
    required this.authWithApple,
    required this.resetPassword,
    required this.signOut,
  }) : super(const AuthState());

  static final RegExp _nameRegExp =
      RegExp(r'^[a-zA-Z]{2,}(?: [a-zA-Z]+){0,2}$');
  static final RegExp _emailRegExp =
      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  static final RegExp _passwordRegExp =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  void validateFields({
    String? name,
    required String email,
    required String? password,
  }) {
    Map<String, ValidityStatus> fieldStatuses = {
      'name': ValidityStatus.valid,
      'email': ValidityStatus.valid,
      'password': ValidityStatus.valid,
    };

    void validateField(String field, String? value) {
      if (value == null || value.isEmpty) {
        fieldStatuses[field] = ValidityStatus.empty;
      } else {
        bool isValid = switch (field) {
          'name' => _nameRegExp.hasMatch(value),
          'email' => _emailRegExp.hasMatch(value),
          'password' => _passwordRegExp.hasMatch(value),
          _ => false,
        };
        fieldStatuses[field] =
            isValid ? ValidityStatus.valid : ValidityStatus.invalid;
      }
    }

    if (password != null) validateField('password', password);
    if (name != null) validateField('name', name);
    validateField('email', email);

    emit(state.copyWith(
      nameValidityStatus: fieldStatuses['name'],
      emailValidityStatus: fieldStatuses['email'],
      passwordValidityStatus: fieldStatuses['password'],
    ));
  }

  void resetValidityStatus() {
    emit(state.copyWith(
      emailValidityStatus: null,
      passwordValidityStatus: null,
      nameValidityStatus: null,
    ));
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

  Future<void> authenticationWithGoogle() async {
    emit(state.copyWith(appState: AppStatus.loading));

    final result = await authWithGoogle();

    emit(result.fold(
      (failure) =>
          state.copyWith(appState: AppStatus.failure, faliure: failure),
      (user) => state.copyWith(
        appState: AppStatus.success,
        userEntity: user,
      ),
    ));
  }

  Future<void> authenticationWithFacebook() async {
    emit(state.copyWith(appState: AppStatus.loading));

    final result = await authWithApple();

    emit(result.fold(
      (failure) =>
          state.copyWith(appState: AppStatus.failure, faliure: failure),
      (user) => state.copyWith(
        appState: AppStatus.success,
        userEntity: user,
      ),
    ));
  }

  Future<void> resetOldPassword({
    required String email,
  }) async {
    emit(state.copyWith(appState: AppStatus.loading));

    final result = await resetPassword(
      email: email,
    );

    emit(result.fold(
      (failure) => state.copyWith(
        appState: AppStatus.failure,
        faliure: failure,
      ),
      (_) => state.copyWith(
        appState: AppStatus.success,
      ),
    ));
  }

  Future<void> signOutUser() async {
    emit(state.copyWith(appState: AppStatus.loading));

    final result = await signOut();

    emit(result.fold(
      (failure) => state.copyWith(
        appState: AppStatus.failure,
        faliure: failure,
      ),
      (_) => state.copyWith(
        appState: AppStatus.success,
        userEntity: null,
      ),
    ));
  }
}
