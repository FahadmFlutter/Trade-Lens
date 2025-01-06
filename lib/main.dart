import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as dotenv;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trade_lens/screens/home/home_screen.dart';
import 'package:trade_lens/screens/onboarding/onboarding_screen.dart';
import 'package:trade_lens/services/storage/local_storage_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initializeApp();

  runApp(const StockTradingApp());
}

Future<void> _initializeApp() async {
  // Load environment variables
  try {
    await dotenv.DotEnv().load(fileName: ".env");
  } catch (e) {
    debugPrint("Error loading .env file: $e");
  }

  // Initialize LocalStorageService as a singleton
  final prefs = await SharedPreferences.getInstance();
  LocalStorageService.init(prefs);
}

class StockTradingApp extends StatelessWidget {
  const StockTradingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stock Trading App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: FutureBuilder<bool>(
        future: LocalStorageService.instance.getOnboardingStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading app'));
          } else {
            final hasOnboarded = snapshot.data ?? false;
            return hasOnboarded ? HomeScreen() : const OnboardingScreen();
          }
        },
      ),
    );
  }
}
