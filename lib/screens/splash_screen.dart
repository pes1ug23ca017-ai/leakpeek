import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../theme/theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 3), _navigateNext);
  }

  void _navigateNext() {
    final bool isLoggedIn = FirebaseAuth.instance.currentUser != null;
    if (!mounted) return;
    Navigator.of(context).pushReplacementNamed(isLoggedIn ? '/home' : '/login');
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: kPrimary,
                borderRadius: BorderRadius.circular(24),
              ),
              alignment: Alignment.center,
              child: const Icon(Icons.lock, color: Colors.white, size: 56),
            ),
            const SizedBox(height: 16),
            Text(
              'LEAKPEEK',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(color: kPrimary, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'SECURE YOUR DATA, YOUR SAFETY',
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(color: kSecondary, letterSpacing: 0.5),
            ),
          ],
        ),
      ),
    );
  }
}


