import 'package:expesne_tracker_app/environment/environment.dart';

class AppConfig {
  final Environment environment;
  final String appName;
  final String version;

  AppConfig({
    required this.environment,
    required this.appName,
    required this.version,
  });
}
