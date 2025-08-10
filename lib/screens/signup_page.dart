import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_widgets.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _mobile = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirm = TextEditingController();
  bool _agree = false;
  String? _error;
  bool _loading = false;

  Future<void> _signup() async {
    if (!_agree) {
      setState(() => _error = 'You must accept Terms & Conditions.');
      return;
    }
    if (_password.text != _confirm.text) {
      setState(() => _error = 'Passwords do not match');
      return;
    }
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final cred = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email.text.trim(),
        password: _password.text,
      );
      await cred.user?.sendEmailVerification();
      if (mounted) Navigator.pushReplacementNamed(context, '/verify');
    } on FirebaseAuthException catch (e) {
      setState(() => _error = e.message);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign up')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextInputField(controller: _email, hint: 'Email Address', keyboardType: TextInputType.emailAddress),
            const SizedBox(height: 12),
            TextInputField(controller: _mobile, hint: 'Mobile Number', keyboardType: TextInputType.phone),
            const SizedBox(height: 12),
            TextInputField(controller: _password, hint: 'Password', obscure: true),
            const SizedBox(height: 12),
            TextInputField(controller: _confirm, hint: 'Confirm Password', obscure: true),
            const SizedBox(height: 8),
            Row(
              children: [
                Checkbox(value: _agree, onChanged: (v) => setState(() => _agree = v ?? false)),
                const Expanded(child: Text('I agree to terms and conditions')),
              ],
            ),
            if (_error != null)
              Text(_error!, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 8),
            PrimaryButton(
              label: _loading ? 'Creating...' : 'Sign up',
              onPressed: _loading ? null : _signup,
              icon: Icons.person_add,
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Already have an account? Sign in'),
            ),
          ],
        ),
      ),
    );
  }
}


