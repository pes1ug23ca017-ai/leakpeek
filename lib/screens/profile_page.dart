import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_widgets.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _dob = TextEditingController();
  final TextEditingController _gender = TextEditingController();
  final TextEditingController _mobile = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _city = TextEditingController();
  bool _saving = false;

  Future<void> _save() async {
    setState(() => _saving = true);
    final uid = FirebaseAuth.instance.currentUser?.uid;
    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'name': _name.text,
      'dob': _dob.text,
      'gender': _gender.text,
      'mobile': _mobile.text,
      'email': _email.text,
      'city': _city.text,
    }, SetOptions(merge: true));
    if (mounted) setState(() => _saving = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const CircleAvatar(radius: 36, child: Icon(Icons.person)),
            const SizedBox(height: 12),
            TextInputField(controller: _name, hint: 'Name'),
            const SizedBox(height: 8),
            TextInputField(controller: _dob, hint: 'D.O.B'),
            const SizedBox(height: 8),
            TextInputField(controller: _gender, hint: 'Gender'),
            const SizedBox(height: 8),
            TextInputField(controller: _mobile, hint: 'Mobile Number', keyboardType: TextInputType.phone),
            const SizedBox(height: 8),
            TextInputField(controller: _email, hint: 'Email Address', keyboardType: TextInputType.emailAddress),
            const SizedBox(height: 8),
            TextInputField(controller: _city, hint: 'City/Country'),
            const SizedBox(height: 12),
            PrimaryButton(label: _saving ? 'Saving...' : 'Done', onPressed: _saving ? null : _save, icon: Icons.save),
          ],
        ),
      ),
    );
  }
}


