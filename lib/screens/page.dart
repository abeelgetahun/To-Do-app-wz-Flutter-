import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Screens'),
      ),
      body: Center(
        child: SingleChildScrollView( // Allows horizontal scrolling if needed
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              PhoneScreen(
                appName: 'APP NAME',
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.favorite, size: 50, color: Colors.white), // Heart Icon
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Login'),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Sign Up'),
                    ),
                  ],
                ),
              ),
              PhoneScreen(
                appName: 'APP NAME',
                content: ListView(
                  children: <Widget>[
                    ListTile(title: Text('Item 1')),
                    ListTile(title: Text('Item 2')),
                    ListTile(title: Text('Item 3')),
                    // Add more ListTiles as needed
                  ],
                ),
              ),
              PhoneScreen(
                appName: 'APP NAME',
                content: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 100,
                        height: 100,
                        color: Colors.white, // White square
                        child: Icon(Icons.image, size: 50), //Image icon
                      ),
                      SizedBox(height: 20),
                      Text('Some Text Here'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PhoneScreen extends StatelessWidget {
  final String appName;
  final Widget content;

  const PhoneScreen({required this.appName, required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        width: 200, // Adjust width as needed
        height: 400, // Adjust height as needed
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 3),
          borderRadius: BorderRadius.circular(20),
          color: Color(0xFF80CBC4), // Teal background color
        ),
        child: Column(
          children: <Widget>[
            Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: Colors.black,
              ),
              child: Center(
                child: Text(
                  appName,
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: content,
              ),
            ),
          ],
        ),
      ),
    );
  }
}