import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_widgets.dart';

class DatabaseSubmitPage extends StatefulWidget {
  const DatabaseSubmitPage({super.key});

  @override
  State<DatabaseSubmitPage> createState() => _DatabaseSubmitPageState();
}

class _DatabaseSubmitPageState extends State<DatabaseSubmitPage> {
  final TextEditingController _link = TextEditingController();
  bool _saving = false;
  String? _msg;

  Future<void> _submit() async {
    setState(() {
      _saving = true;
      _msg = null;
    });
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      await FirebaseFirestore.instance.collection('submissions').add({
        'uid': uid,
        'link': _link.text.trim(),
        'createdAt': FieldValue.serverTimestamp(),
      });
      setState(() => _msg = 'Submitted. Our crawler will process it.');
    } catch (e) {
      setState(() => _msg = 'Failed: $e');
    } finally {
      setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Database Link Submission')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextInputField(controller: _link, hint: 'Paste database/link'),
            const SizedBox(height: 12),
            PrimaryButton(label: _saving ? 'Submitting...' : 'Submit', onPressed: _saving ? null : _submit, icon: Icons.send),
            if (_msg != null) ...[
              const SizedBox(height: 8),
              Text(_msg!),
            ]
          ],
        ),
      ),
    );
  }
}


