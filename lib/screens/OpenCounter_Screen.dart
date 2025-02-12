import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _openCount = 0; // Counter for app opens

  @override
  void initState() {
    super.initState();
    _updateOpenCount();
  }

  /// Loads and updates the app open count using SharedPreferences
  Future<void> _updateOpenCount() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int count = (prefs.getInt('open_count') ?? 0) + 1; // Retrieve and increment
    await prefs.setInt('open_count', count); // Save updated count

    if (mounted) {
      setState(() => _openCount = count); // Update UI only if mounted
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("App Open Counter")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "You have opened this app $_openCount times!",
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Home()),
              ),
              child: const Text("Start now"),
            ),
          ],
        ),
      ),
    );
  }
}
