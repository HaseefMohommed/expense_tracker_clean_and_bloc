import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expesne_tracker_app/environment/app_config.dart';
import 'package:expesne_tracker_app/environment/environment.dart';
import 'package:expesne_tracker_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:expesne_tracker_app/features/auth/data/respositories/auth_remote_repository_imp.dart';
import 'package:expesne_tracker_app/features/auth/domain/respositories/auth_remote_repository.dart';
import 'package:expesne_tracker_app/features/auth/domain/usecases/auth_with_facebook.dart';
import 'package:expesne_tracker_app/features/auth/domain/usecases/auth_with_google.dart';
import 'package:expesne_tracker_app/features/auth/domain/usecases/reset_password.dart';
import 'package:expesne_tracker_app/features/auth/domain/usecases/sign_in_with_email_and_password.dart';
import 'package:expesne_tracker_app/features/auth/domain/usecases/sign_out_user.dart';
import 'package:expesne_tracker_app/features/auth/domain/usecases/sign_up_with_email_and_password.dart';
import 'package:expesne_tracker_app/features/auth/presentation/bloc/auth_cubit/auth_cubit.dart';
import 'package:expesne_tracker_app/features/savings/data/datasources/savings_datasource.dart';
import 'package:expesne_tracker_app/features/savings/data/repositories/savings_repository_imp.dart';
import 'package:expesne_tracker_app/features/savings/domain/repositories/savings_repository.dart';
import 'package:expesne_tracker_app/features/savings/domain/usecases/add_entry.dart';
import 'package:expesne_tracker_app/features/savings/domain/usecases/add_goal.dart';
import 'package:expesne_tracker_app/features/savings/domain/usecases/fetch_all_entries.dart';
import 'package:expesne_tracker_app/features/savings/domain/usecases/fetch_all_goals.dart';
import 'package:expesne_tracker_app/features/savings/domain/usecases/fetch_expenses_for_day.dart';
import 'package:expesne_tracker_app/features/savings/domain/usecases/fetch_monthly_amount.dart';
import 'package:expesne_tracker_app/features/savings/domain/usecases/fetch_saved_amount.dart';
import 'package:expesne_tracker_app/features/savings/domain/usecases/fetch_total_expense.dart';
import 'package:expesne_tracker_app/features/savings/domain/usecases/fetch_total_expense_by_category.dart';
import 'package:expesne_tracker_app/features/savings/domain/usecases/fetch_total_income.dart';
import 'package:expesne_tracker_app/features/savings/presentation/bloc/cubit/savings_cubit.dart';
import 'package:expesne_tracker_app/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
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

  sl.registerLazySingleton<FacebookAuth>(() => FacebookAuth.instance);

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
      facebookAuth: sl(),
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
    () => AuthWithFacebook(
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

  // Savings

  //Data layer
  sl.registerFactory<SavingsDatasource>(
    () => SavingsDatasourceImp(
      firebaseFirestore: sl(),
    ),
  );

  //Domain layer
  sl.registerFactory<SavingsRepository>(
    () => SavingsRepositoryImp(
      savingsDatasource: sl(),
    ),
  );

  sl.registerFactory(
    () => AddGoal(
      savingsRepository: sl(),
    ),
  );

  sl.registerFactory(
    () => FetchAllGoals(
      savingsRepository: sl(),
    ),
  );

  sl.registerFactory(
    () => AddEntry(
      savingsRepository: sl(),
    ),
  );

  sl.registerFactory(
    () => FetchAllEntries(
      savingsRepository: sl(),
    ),
  );

  sl.registerFactory(
    () => FetchTotalExpense(
      savingsRepository: sl(),
    ),
  );
  sl.registerFactory(
    () => FetchTotalIncome(
      savingsRepository: sl(),
    ),
  );
  sl.registerFactory(
    () => FetchMonthlyGoalAmount(
      savingsRepository: sl(),
    ),
  );
  sl.registerFactory(
    () => FetchSavedAmount(
      savingsRepository: sl(),
    ),
  );

  sl.registerFactory(
    () => FetchExpensesForDay(
      savingsRepository: sl(),
    ),
  );

  sl.registerFactory(
    () => FetchTotalExpenseByCategory(
      savingsRepository: sl(),
    ),
  );

  // Bloc
  sl.registerFactory(
    () => SavingsCubit(
      addGoal: sl(),
      fetchAllGoals: sl(),
      addEntry: sl(),
      fetchAllEntries: sl(),
      fetchTotalExpense: sl(),
      fetchTotalIncome: sl(),
      fetchMonthlyGoalAmount: sl(),
      fetchSavedAmount: sl(),
      fetchEntriesForDay: sl(),
      fetchTotalExpenseByCategory: sl(),
    ),
  );
}
