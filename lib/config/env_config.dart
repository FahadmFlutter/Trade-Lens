import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  static String get apiKey {
    final key = dotenv.env['ALPHA_VANTAGE_API_KEY'] ?? Platform.environment['ALPHA_VANTAGE_API_KEY'];
    if (key == null || key.isEmpty) {
      throw Exception('No API key found. Make sure to add ALPHA_VANTAGE_API_KEY in your .env file or as an environment variable.');
    }
    return key;
  }
}
