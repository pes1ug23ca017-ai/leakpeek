import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'theme/theme.dart';
import 'screens/splash_screen.dart';
import 'firebase_options.dart';
import 'router.dart';
import 'env.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (EnvConfig.useEmulators) {
    FirebaseFirestore.instance.useFirestoreEmulator(EnvConfig.firestoreHost, EnvConfig.firestorePort);
    FirebaseFunctions.instanceFor(region: EnvConfig.functionsRegion)
        .useFunctionsEmulator(EnvConfig.functionsHost, EnvConfig.functionsPort);
  }
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
      routes: buildRoutes(),
    );
  }
}
// SplashScreen will navigate to the appropriate first page.
