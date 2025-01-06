import '../config/env_config.dart';

class ApiConstants {
  static const String baseUrl = 'https://www.alphavantage.co/query';

  static String get apiKey => EnvConfig.apiKey;
}
