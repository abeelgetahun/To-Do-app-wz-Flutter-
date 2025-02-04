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
    _incrementOpenCount(); // Call method to update open count
  }

  Future<void> _incrementOpenCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int count = prefs.getInt('open_count') ?? 0; // Get stored count, default to 0
    count++; // Increment count
    await prefs.setInt('open_count', count); // Save updated count

    setState(() {
      _openCount = count; // Update UI with new count
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("App Open Counter")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text(
            "You have opened this app $_openCount times!)",
            style: const TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
          ),
            const SizedBox(height: 50),
            ElevatedButton(
                onPressed: (){
                  Navigator.push(
                  context,
                      MaterialPageRoute(builder: (context) => const Home()),
                  );
                },
                child: Text("Start now"))
            ]
        ),
      ),
    );
  }
}