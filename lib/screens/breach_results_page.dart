import 'package:flutter/material.dart';

class BreachResultsPage extends StatelessWidget {
  final String query;
  final List<Map<String, dynamic>> results;

  const BreachResultsPage({super.key, required this.query, required this.results});

  @override
  Widget build(BuildContext context) {
    final bool anyBreached = results.any((e) => (e['breached'] as bool?) ?? false);
    return Scaffold(
      appBar: AppBar(title: const Text('Breach Results')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Query: $query', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            if (results.isEmpty)
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.verified, color: Colors.green, size: 72),
                      SizedBox(height: 8),
                      Text('No breaches found')
                    ],
                  ),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: results.length,
                  itemBuilder: (context, index) {
                    final item = results[index];
                    final bool breached = (item['breached'] as bool?) ?? false;
                    final Color color = breached ? Colors.red : Colors.green;
                    return Card(
                      child: ListTile(
                        leading: Icon(breached ? Icons.warning : Icons.check_circle, color: color),
                        title: Text(item['source']?.toString() ?? 'Unknown source'),
                        subtitle: Text(item['date']?.toString() ?? ''),
                        trailing: Text(
                          item['type']?.toString() ?? '',
                          style: TextStyle(color: color, fontWeight: FontWeight.w600),
                        ),
                      ),
                    );
                  },
                ),
              ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(anyBreached ? Icons.warning : Icons.check_circle, color: anyBreached ? Colors.red : Colors.green),
                const SizedBox(width: 8),
                Text(anyBreached ? 'Breaches found' : 'No breaches'),
              ],
            )
          ],
        ),
      ),
    );
  }
}


