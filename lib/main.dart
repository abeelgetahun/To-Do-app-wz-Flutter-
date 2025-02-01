import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const WelcomeScreenWrapper(),
    );
  }
}

class WelcomeScreenWrapper extends StatefulWidget {
  const WelcomeScreenWrapper({Key? key}) : super(key: key);

  @override
  State<WelcomeScreenWrapper> createState() => _WelcomeScreenWrapperState();
}

class _WelcomeScreenWrapperState extends State<WelcomeScreenWrapper> {
  bool? _showWelcomeScreen;

  @override
  void initState() {
    super.initState();
    _checkFirstTime();
  }

  Future<void> _checkFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _showWelcomeScreen = !prefs.getBool('seen_welcome_screen')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_showWelcomeScreen == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return _showWelcomeScreen! ? const WelcomeScreen() : const Scaffold(); // Replace Scaffold() with your main screen
  }
}