import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:leakpeek/theme/theme.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _queryController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;
  User? _currentUser;

  @override
  void initState() {
    super.initState();
    _currentUser = FirebaseAuth.instance.currentUser;
  }

  @override
  void dispose() {
    _queryController.dispose();
    super.dispose();
  }

  Future<void> _checkBreach() async {
    final String query = _queryController.text.trim();
    if (query.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter an email or phone number to check';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Hash the query for security
      final String hashedQuery = sha256.convert(utf8.encode(query)).toString();

      // Call Cloud Function
      final HttpsCallable callable = FirebaseFunctions.instance.httpsCallable(
        'checkBreach',
      );
      final result = await callable.call({
        'query': hashedQuery,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      });

      // Store results in Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_currentUser!.uid)
          .collection('history')
          .add({
            'query': hashedQuery,
            'originalQuery': query,
            'timestamp': FieldValue.serverTimestamp(),
            'results': result.data['results'],
            'breached': result.data['breached'],
            'message': result.data['message'],
          });

      if (mounted) {
        // Pass isLoading true initially, then navigate to results once done
        Navigator.pushReplacementNamed(
          context,
          '/results',
          arguments: {
            'query': query,
            'results': result.data['results'],
            'isLoading': false, // Results are ready
          },
        );
      }
    } on FirebaseFunctionsException catch (_) {
      setState(() {
        _errorMessage =
            'Service temporarily unavailable. Please try again later.';
      });
    } catch (_) {
      setState(() {
        _errorMessage = 'An error occurred. Please try again.';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context).openDrawer(); // Open drawer
                  },
                ),
              ),
              const SizedBox(height: 80),
              Center(
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Icon(Icons.search, color: Colors.white, size: 60),
                ),
              ),
              const SizedBox(height: 40),
              Text(
                'Check if your data has breached',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    _errorMessage!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              Text(
                'EMAIL/MOBILE NUMBER',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: kFontColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _queryController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Enter your email or phone number',
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: _isLoading ? null : _checkBreach,
                child:
                    _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('BREACH'),
              ),
              const SizedBox(height: 20),
              Text(
                'Using BREACHER is subject to the terms of use',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
