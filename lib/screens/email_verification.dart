import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailVerificationPage extends StatefulWidget {
  const EmailVerificationPage({super.key});

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  bool _showEmailInput = true; // State to control which UI to show
  String? _message;
  bool _sending = false;

  @override
  void dispose() {
    _emailController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  Future<void> _sendVerificationEmail() async {
    setState(() {
      _sending = true;
      _message = null;
    });
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.sendEmailVerification();
        setState(() {
          _message =
              'Verification email sent to ${user.email ?? 'your email'}.';
          _showEmailInput = false; // Move to code input
        });
      } else {
        _message = 'User not logged in.';
      }
    } on FirebaseAuthException catch (e) {
      _message = 'Failed to send verification email: ${e.message}';
    } catch (e) {
      _message = 'An unexpected error occurred: $e';
    } finally {
      setState(() => _sending = false);
    }
  }

  Future<void> _verifyCode() async {
    setState(() {
      _sending = true;
      _message = null;
    });
    try {
      // In a real app, you'd send the code to a backend to verify.
      // For this UI, we'll simulate success.
      await Future.delayed(Duration(seconds: 1)); // Simulate network request
      if (_codeController.text == "123456") {
        // Dummy code for UI purposes
        if (mounted) {
          Navigator.pushReplacementNamed(context, '/success');
        }
      } else {
        _message = 'Invalid verification code.';
      }
    } catch (e) {
      _message = 'An error occurred during verification: $e';
    } finally {
      setState(() => _sending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child:
              _showEmailInput
                  ? _buildEmailInput(context)
                  : _buildCodeInput(context),
        ),
      ),
    );
  }

  Widget _buildEmailInput(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        const SizedBox(height: 40),
        Center(
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Icon(Icons.email_outlined, color: Colors.white, size: 60),
          ),
        ),
        const SizedBox(height: 40),
        Text(
          'Enter Your Email Address',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        Text(
          'We will send you a verification code',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40),
        TextFormField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: 'Enter your email',
            labelText: 'EMAIL ADDRESS',
          ),
        ),
        const SizedBox(height: 20),
        // Checkbox and reCAPTCHA Placeholder
        Row(
          children: [
            Checkbox(
              value: false, // Placeholder
              onChanged: (value) {},
              activeColor: Theme.of(context).primaryColor,
            ),
            Text(
              'I\'m not a robot',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Spacer(),
            // reCAPTCHA Image Placeholder
            Container(
              width: 80,
              height: 40,
              color: Colors.grey[200],
              child: Center(
                child: Text('reCAPTCHA', style: TextStyle(fontSize: 10)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 40),
        ElevatedButton(
          onPressed: _sending ? null : _sendVerificationEmail,
          child:
              _sending
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('VERIFY'),
        ),
        if (_message != null) ...[
          const SizedBox(height: 20),
          Text(
            _message!,
            style: TextStyle(color: Theme.of(context).colorScheme.error),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }

  Widget _buildCodeInput(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              setState(() {
                _showEmailInput = true;
                _message = null;
              });
            },
          ),
        ),
        const SizedBox(height: 40),
        Center(
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Icon(
              Icons.chat_bubble_outline,
              color: Colors.white,
              size: 60,
            ),
          ),
        ),
        const SizedBox(height: 40),
        Text(
          'Enter Verification code',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        Text(
          'We sent a verification code to your email\nab*****@gmail.com',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40),
        TextFormField(
          controller: _codeController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: 'Enter your code',
            labelText: 'VERIFICATION CODE',
          ),
        ),
        const SizedBox(height: 40),
        ElevatedButton(
          onPressed: _sending ? null : _verifyCode,
          child:
              _sending
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('SUBMIT'),
        ),
        const SizedBox(height: 20),
        TextButton(
          onPressed: _sending ? null : _sendVerificationEmail,
          child: const Text('Resend again'),
        ),
        if (_message != null) ...[
          const SizedBox(height: 20),
          Text(
            _message!,
            style: TextStyle(color: Theme.of(context).colorScheme.error),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }
}
