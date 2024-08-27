import 'package:equatable/equatable.dart';
import 'package:expesne_tracker_app/core/enums/auth_type.dart';

abstract class Failure with FailureMessage, EquatableMixin {}

class ServerFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class SocketFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class AuthenticationFailure extends Failure {
  final String? code;
  final AuthenticationType type;

  AuthenticationFailure({this.code, required this.type});

  @override
  List<Object?> get props => [code, type];
}

class UnexpectedFailure extends Failure {
  @override
  List<Object?> get props => [];
}

mixin FailureMessage {
  String getMessage() {
    if (this is ServerFailure) {
      return 'Server error occurred. Please try again later.';
    } else if (this is SocketFailure) {
      return 'There are some issues with your internet connection. Please check and try again.';
    } else if (this is AuthenticationFailure) {
      return _getAuthenticationErrorMessage(
          (this as AuthenticationFailure).code,
          (this as AuthenticationFailure).type);
    } else {
      return 'An unexpected error occurred. Please try again.';
    }
  }

  String _getAuthenticationErrorMessage(String? code, AuthenticationType type) {
    switch (type) {
      case AuthenticationType.signIn:
        return _getSignInErrorMessage(code);
      case AuthenticationType.signUp:
        return _getSignUpErrorMessage(code);
      case AuthenticationType.google:
        return _getGoogleAuthErrorMessage(code);
      case AuthenticationType.apple:
        return _getAppleAuthErrorMessage(code);
      case AuthenticationType.signOut:
        return _getSignOutErrorMessage(code);
      case AuthenticationType.resetPassword:
        return _getResetPasswordErrorMessage(code);
    }
  }

  String _getSignInErrorMessage(String? code) {
    switch (code) {
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'user-disabled':
        return 'This user account has been disabled.';
      case 'too-many-requests':
        return 'Too many unsuccessful login attempts. Please try again later.';
      case 'operation-not-allowed':
        return 'Email/password accounts are not enabled.';
      case 'network-request-failed':
        return 'A network error occurred. Please check your connection.';
      default:
        return 'Failed to sign in. Please try again.';
    }
  }

  String _getSignUpErrorMessage(String? code) {
    switch (code) {
      case 'email-already-in-use':
        return 'An account already exists for that email.';
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'operation-not-allowed':
        return 'Email/password accounts are not enabled.';
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'network-request-failed':
        return 'A network error occurred. Please check your connection.';
      default:
        return 'Failed to create account. Please try again.';
    }
  }

  String _getGoogleAuthErrorMessage(String? code) {
    switch (code) {
      case 'account-exists-with-different-credential':
        return 'An account already exists with the same email address but different sign-in credentials.';
      case 'invalid-credential':
        return 'The credential received is malformed or has expired.';
      case 'operation-not-allowed':
        return 'Google sign-in is not enabled for this project.';
      case 'user-disabled':
        return 'The user account has been disabled.';
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Invalid password.';
      case 'invalid-verification-code':
        return 'The credential verification code received is invalid.';
      case 'invalid-verification-id':
        return 'The credential verification ID received is invalid.';
      case 'network-request-failed':
        return 'A network error occurred. Please check your connection.';
      default:
        return 'Failed to sign in with Google. Please try again.';
    }
  }

  String _getAppleAuthErrorMessage(String? code) {
    switch (code) {
      case 'auth/operation-not-allowed':
        return 'Apple sign-in is not enabled for this project.';
      case 'auth/invalid-credential':
        return 'The credential received is malformed or has expired.';
      case 'auth/user-disabled':
        return 'The user account has been disabled.';
      case 'auth/user-not-found':
        return 'No user found for that email.';
      case 'auth/network-request-failed':
        return 'A network error occurred. Please check your connection.';
      default:
        return 'Failed to sign in with Apple. Please try again.';
    }
  }

  String _getResetPasswordErrorMessage(String? code) {
    switch (code) {
      case 'auth/invalid-email':
        return 'The email address is not valid.';
      case 'auth/user-not-found':
        return 'No user found for that email.';
      case 'auth/user-disabled':
        return 'This user account has been disabled.';
      case 'auth/too-many-requests':
        return 'Too many requests. Try again later.';
      case 'auth/network-request-failed':
        return 'A network error occurred. Please check your connection.';
      default:
        return 'Failed to send password reset email. Please try again.';
    }
  }

  String _getSignOutErrorMessage(String? code) {
    switch (code) {
      case 'auth/network-request-failed':
        return 'A network error occurred while signing out. Please check your connection and try again.';
      default:
        return 'Failed to sign out. Please try again.';
    }
  }
}
