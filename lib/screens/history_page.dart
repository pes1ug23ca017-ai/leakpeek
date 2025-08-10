import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final stream = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('history')
        .orderBy('date', descending: true)
        .snapshots();
    return Scaffold(
      appBar: AppBar(title: const Text('My Breach History')),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final docs = snapshot.data?.docs ?? [];
          if (docs.isEmpty) {
            return const Center(child: Text('No history yet'));
          }
          return ListView(
            children: docs.map((d) {
              final data = d.data();
              final breached = (data['breached'] as bool?) ?? false;
              return ListTile(
                leading: Icon(
                  breached ? Icons.warning : Icons.check_circle,
                  color: breached ? Colors.red : Colors.green,
                ),
                title: Text(data['source']?.toString() ?? 'Unknown'),
                subtitle: Text(data['date']?.toString() ?? ''),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}


