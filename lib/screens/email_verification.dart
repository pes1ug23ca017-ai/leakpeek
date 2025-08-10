import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_widgets.dart';

class EmailVerificationPage extends StatefulWidget {
  const EmailVerificationPage({super.key});

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  String? _message;
  bool _sending = false;

  Future<void> _resend() async {
    setState(() {
      _sending = true;
      _message = null;
    });
    try {
      await FirebaseAuth.instance.currentUser?.sendEmailVerification();
      setState(() => _message = 'Verification email sent.');
    } catch (e) {
      setState(() => _message = 'Failed to send: $e');
    } finally {
      setState(() => _sending = false);
    }
  }

  Future<void> _checkVerified() async {
    await FirebaseAuth.instance.currentUser?.reload();
    final verified = FirebaseAuth.instance.currentUser?.emailVerified ?? false;
    if (!mounted) return;
    if (verified) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      setState(() => _message = 'Not verified yet.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Email Verification')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Step 1: Check your inbox for a verification email.\nStep 2: Tap the link.'),
            const SizedBox(height: 12),
            PrimaryButton(label: _sending ? 'Sending...' : 'Resend Email', onPressed: _sending ? null : _resend, icon: Icons.email),
            const SizedBox(height: 8),
            PrimaryButton(label: 'I\'ve Verified', onPressed: _checkVerified, icon: Icons.verified_user),
            if (_message != null) ...[
              const SizedBox(height: 12),
              Text(_message!, style: const TextStyle(color: Colors.black87)),
            ]
          ],
        ),
      ),
    );
  }
}


