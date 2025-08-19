import 'package:flutter/material.dart';
import 'screens/login_page.dart';
import 'screens/signup_page.dart';
import 'screens/email_verification.dart';
import 'screens/home_page.dart';
import 'screens/history_page.dart';
import 'screens/database_submit_page.dart';
import 'screens/community_page.dart';
import 'screens/settings_page.dart';
import 'screens/logout_page.dart';
import 'screens/profile_page.dart';
import 'screens/breach_results_page.dart';
import 'screens/success_screen.dart';
import 'screens/upload_profile_picture_page.dart';

Map<String, WidgetBuilder> buildRoutes() => {
  '/login': (_) => const LoginPage(),
  '/signup': (_) => const SignupPage(),
  '/verify': (_) => const EmailVerificationPage(),
  '/verify_code': (_) => const EmailVerificationPage(),
  '/success': (_) => const SuccessScreen(),
  '/home': (_) => const HomePage(),
  '/history': (_) => const HistoryPage(),
  '/submit': (_) => const DatabaseSubmitPage(),
  '/community': (_) => const CommunityPage(),
  '/settings': (_) => const SettingsPage(),
  '/logout': (_) => const LogoutPage(),
  '/profile': (_) => const ProfilePage(),
  '/upload_profile_picture': (_) => const UploadProfilePicturePage(),
  // Results route is typically pushed with arguments; adding a fallback placeholder
  '/results': (ctx) => const BreachResultsPage(query: 'Unknown', results: []),
};
