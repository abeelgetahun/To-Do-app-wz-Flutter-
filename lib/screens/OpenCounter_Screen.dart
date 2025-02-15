import 'package:flutter/material.dart';
import 'Home.dart'; // Add this line if not already present

class OpenCounterScreen extends StatefulWidget {
  const OpenCounterScreen({super.key});

  @override
  State<OpenCounterScreen> createState() => _OpenCounterScreenState();
}

class _OpenCounterScreenState extends State<OpenCounterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Open Counter Screen"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Home()),
            );
          },
          child: const Text("Go to Home"),
        ),
      ),
    );
  }
}
