import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_widgets.dart';
import '../theme/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _query = TextEditingController();
  bool _loading = false;
  List<Map<String, dynamic>> _results = [];
  String? _error;

  Future<void> _breach() async {
    setState(() {
      _loading = true;
      _error = null;
      _results = [];
    });
    try {
      // Call placeholder cloud function; backend to implement
      final call = FirebaseFunctions.instance.httpsCallable('checkBreach');
      final resp = await call.call(<String, dynamic>{'query': _query.text.trim()});
      final List data = resp.data as List? ?? [];
      _results = data.cast<Map<String, dynamic>>();
    } catch (e) {
      _error = e.toString();
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('LeakPeek')),
      drawer: const _AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.search, color: kPrimary, size: 80),
            const SizedBox(height: 16),
            TextInputField(controller: _query, hint: 'Email or Mobile'),
            const SizedBox(height: 12),
            PrimaryButton(label: 'BREACH', icon: Icons.search, onPressed: _loading ? null : _breach),
            const SizedBox(height: 12),
            Align(alignment: Alignment.center, child: TextButton(onPressed: () => Navigator.pushNamed(context, '/settings'), child: const Text('Terms of Use'))),
            if (_loading) const LinearProgressIndicator(),
            if (_error != null) Text(_error!, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 8),
            Expanded(
              child: _results.isEmpty
                  ? const Center(child: Text('No results yet'))
                  : ListView.builder(
                      itemCount: _results.length,
                      itemBuilder: (context, index) {
                        final item = _results[index];
                        final bool breached = (item['breached'] as bool?) ?? false;
                        final Color color = breached ? Colors.red : Colors.green;
                        return Card(
                          child: ListTile(
                            leading: Icon(breached ? Icons.warning : Icons.check_circle, color: color),
                            title: Text(item['source']?.toString() ?? 'Unknown source'),
                            subtitle: Text(item['date']?.toString() ?? ''),
                            trailing: Text(item['type']?.toString() ?? '', style: TextStyle(color: color)),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AppDrawer extends StatelessWidget {
  const _AppDrawer();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(radius: 28, child: Icon(Icons.person)),
                SizedBox(height: 8),
                Text('Username'),
                Text('email@example.com'),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.search),
            title: const Text('Check Data Breach'),
            onTap: () => Navigator.pushReplacementNamed(context, '/home'),
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('My Breach History'),
            onTap: () => Navigator.pushNamed(context, '/history'),
          ),
          ListTile(
            leading: const Icon(Icons.link),
            title: const Text('Database Link Submission'),
            onTap: () => Navigator.pushNamed(context, '/submit'),
          ),
          ListTile(
            leading: const Icon(Icons.forum),
            title: const Text('Community'),
            onTap: () => Navigator.pushNamed(context, '/community'),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () => Navigator.pushNamed(context, '/settings'),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () => Navigator.pushNamed(context, '/logout'),
          ),
        ],
      ),
    );
  }
}


