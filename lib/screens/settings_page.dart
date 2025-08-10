import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: const [
          ListTile(title: Text('Security'), subtitle: Text('2FA, encryption preferences')),
          ListTile(title: Text('Notifications'), subtitle: Text('Email alerts for breaches')), 
        ],
      ),
    );
  }
}


