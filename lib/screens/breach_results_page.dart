import 'package:flutter/material.dart';

class BreachResultsPage extends StatelessWidget {
  final String query;
  final List<Map<String, dynamic>> results;
  final bool isLoading;

  const BreachResultsPage({
    super.key,
    required this.query,
    required this.results,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool anyBreached = results.any(
      (e) => (e['breached'] as bool?) ?? false,
    );
    return Scaffold(
      body: SafeArea(
        child: Padding(
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
              if (isLoading) ...[
                const Spacer(),
                Center(
                  child: SizedBox(
                    width: 120,
                    height: 120,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor,
                      ),
                      strokeWidth: 8,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Text(
                  'Breaching...',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
              ],
              if (!isLoading && results.isEmpty) ...[
                const Spacer(),
                Center(
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 60,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Text(
                  'No breaches',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  'No pastes',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
              ],
              if (!isLoading && results.isNotEmpty) ...[
                // Existing breach results display
                Text(
                  'Query: $query',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: ListView.builder(
                    itemCount: results.length,
                    itemBuilder: (context, index) {
                      final item = results[index];
                      final bool breached =
                          (item['breached'] as bool?) ?? false;
                      final Color color = breached ? Colors.red : Colors.green;
                      return Card(
                        child: ListTile(
                          leading: Icon(
                            breached ? Icons.warning : Icons.check_circle,
                            color: color,
                          ),
                          title: Text(
                            item['source']?.toString() ?? 'Unknown source',
                          ),
                          subtitle: Text(item['date']?.toString() ?? ''),
                          trailing: Text(
                            item['type']?.toString() ?? '',
                            style: TextStyle(
                              color: color,
                              fontWeight: FontWeight.w600,
                            ),
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
                    Icon(
                      anyBreached ? Icons.warning : Icons.check_circle,
                      color: anyBreached ? Colors.red : Colors.green,
                    ),
                    const SizedBox(width: 8),
                    Text(anyBreached ? 'Breaches found' : 'No breaches'),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
