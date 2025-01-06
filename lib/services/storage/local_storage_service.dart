import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static late final LocalStorageService _instance;
  final SharedPreferences _prefs;

  LocalStorageService._(this._prefs);

  static void init(SharedPreferences prefs) {
    _instance = LocalStorageService._(prefs);
  }

  static LocalStorageService get instance => _instance;

  Future<bool> getOnboardingStatus() async {
    return _prefs.getBool('hasOnboarded') ?? false;
  }
}
