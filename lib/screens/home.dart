import 'package:flutter/material.dart';
import 'package:to_do/screens/TimelinePage.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: const Center(
        child: Text("Welcome to the Home Page"),
      ),
    );
  }
}
