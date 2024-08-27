import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expesne_tracker_app/environment/app_config.dart';
import 'package:expesne_tracker_app/environment/environment.dart';
import 'package:expesne_tracker_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:expesne_tracker_app/features/auth/data/respositories/auth_remote_repository_imp.dart';
import 'package:expesne_tracker_app/features/auth/domain/respositories/auth_remote_repository.dart';
import 'package:expesne_tracker_app/features/auth/domain/usecases/auth_with_apple.dart';
import 'package:expesne_tracker_app/features/auth/domain/usecases/auth_with_google.dart';
import 'package:expesne_tracker_app/features/auth/domain/usecases/reset_password.dart';
import 'package:expesne_tracker_app/features/auth/domain/usecases/sign_in_with_email_and_password.dart';
import 'package:expesne_tracker_app/features/auth/domain/usecases/sign_out_user.dart';
import 'package:expesne_tracker_app/features/auth/domain/usecases/sign_up_with_email_and_password.dart';
import 'package:expesne_tracker_app/features/auth/presentation/bloc/auth_cubit/auth_cubit.dart';
import 'package:expesne_tracker_app/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

final sl = GetIt.I; // Service location

Future<void> init(Environment environment) async {
  //initialize firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //Firebase services
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

  sl.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn());

  // setting up application environment for global access
  sl.registerFactory<AppConfig>(
    () => AppConfig(
      environment: environment,
      appName: 'expesense tracker',
      version: '1.0.0',
    ),
  );

  // Authentication

  //data layer
  sl.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImp(
      googleSignIn: sl(),
      firebaseAuth: sl(),
      firebaseFirestore: sl(),
    ),
  );

  // domain layer
  sl.registerFactory<AuthRemoteRepository>(
    () => AuthRemoteRepositoryImp(
      authRemoteDataSource: sl(),
    ),
  );

  sl.registerFactory(
    () => SignInWithEmailAndPassword(
      authRemoteRepository: sl(),
    ),
  );
  sl.registerFactory(
    () => SignUpWithEmailAndPassword(
      authRemoteRepository: sl(),
    ),
  );

  sl.registerFactory(
    () => AuthWithGoogle(
      authRemoteRepository: sl(),
    ),
  );
  sl.registerFactory(
    () => AuthWithApple(
      authRemoteRepository: sl(),
    ),
  );

  sl.registerFactory(
    () => ResetPassword(
      authRemoteRepository: sl(),
    ),
  );

  sl.registerFactory(
    () => SignOutUser(
      authRemoteRepository: sl(),
    ),
  );

  // bloc
  sl.registerFactory(
    () => AuthCubit(
      signInWithEmailAndPassword: sl(),
      signUpWithEmailAndPassword: sl(),
      authWithApple: sl(),
      authWithGoogle: sl(),
      resetPassword: sl(),
      signOut: sl(),
    ),
  );
}
