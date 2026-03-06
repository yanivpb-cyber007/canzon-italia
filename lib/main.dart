import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/progress_store.dart';
import 'services/speech_service.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize persistent storage
  final progressStore = ProgressStore();
  await progressStore.init();

  // Initialize speech recognition
  final speechService = SpeechService();
  await speechService.init();

  runApp(
    MultiProvider(
      providers: [
        Provider<ProgressStore>.value(value: progressStore),
        Provider<SpeechService>.value(value: speechService),
      ],
      child: const CanzonItaliaApp(),
    ),
  );
}

class CanzonItaliaApp extends StatelessWidget {
  const CanzonItaliaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CanzonItalia',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        cardTheme: const CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
