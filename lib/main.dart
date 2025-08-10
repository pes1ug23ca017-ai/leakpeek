import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'theme/theme.dart';
import 'screens/splash_screen.dart';
import 'firebase_options.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const LeakPeekApp());
}
class LeakPeekApp extends StatelessWidget {
  const LeakPeekApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LeakPeek',
      theme: buildLeakPeekTheme(),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
// SplashScreen will navigate to the appropriate first page.
