import 'package:expesne_tracker_app/features/auth/presentation/bloc/auth_cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expesne_tracker_app/app.dart';
import 'package:expesne_tracker_app/di/injection.dart';
import 'package:expesne_tracker_app/environment/environment.dart';

import 'di/injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final Environment environment = Environment.values.firstWhere(
    (e) =>
        e.name ==
        const String.fromEnvironment('env', defaultValue: 'development'),
  );
  await di.init(environment);
  runApp(
    MultiBlocProvider(
      providers: [BlocProvider(create: (context) => sl<AuthCubit>())],
      child: const App(),
    ),
  );
}
