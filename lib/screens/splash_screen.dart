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
    final route = MaterialPageRoute(
      builder: (_) => isLoggedIn
          ? const _NextPlaceholder(title: 'Home (stub)')
          : const _NextPlaceholder(title: 'Login (stub)'),
    );
    if (mounted) Navigator.of(context).pushReplacement(route);
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

class _NextPlaceholder extends StatelessWidget {
  final String title;
  const _NextPlaceholder({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text(
          '$title screen will be implemented next.',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}


