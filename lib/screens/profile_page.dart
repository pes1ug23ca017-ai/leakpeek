import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:leakpeek/theme/theme.dart';

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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
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
              const SizedBox(height: 20),
              Text(
                'PROFILE',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Icon(Icons.person, size: 60, color: Colors.white),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 20,
                          ),
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/upload_profile_picture',
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Text(
                'NAME',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: kFontColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _name,
                decoration: InputDecoration(hintText: 'Enter your name'),
              ),
              const SizedBox(height: 20),
              Text(
                'D.O.B',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: kFontColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _dob,
                decoration: InputDecoration(
                  hintText: 'Enter your date of birth',
                ),
                keyboardType: TextInputType.datetime,
              ),
              const SizedBox(height: 20),
              Text(
                'GENDER',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: kFontColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _gender,
                decoration: InputDecoration(hintText: 'Enter your gender'),
              ),
              const SizedBox(height: 20),
              Text(
                'MOBILE NUMBER',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: kFontColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _mobile,
                decoration: InputDecoration(
                  hintText: 'Enter your mobile number',
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 20),
              Text(
                'EMAIL ADDRESS',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: kFontColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _email,
                decoration: InputDecoration(
                  hintText: 'Enter your email address',
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              Text(
                'CITY,COUNTRY',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: kFontColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _city,
                decoration: InputDecoration(
                  hintText: 'Enter your city and country',
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: _saving ? null : _save,
                child:
                    _saving
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('DONE'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
