part of 'auth_cubit.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    @Default(AppStatus.initial) AppStatus appState,
    ValidityStatus? nameValidityStatus,
    ValidityStatus? emailValidityStatus,
    ValidityStatus? passwordValidityStatus,
    UserEntity? userEntity,
    Failure? faliure,
  }) = _AuthState;

  const AuthState._();
}
