import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform = MethodChannel('demo.customPlatformCode/native');

  String _response = 'Press the button to get a native string';

  Future<void> _getNativeString() async {
    String response;
    try {
      response = await platform.invokeMethod('getNativeString');
    } on PlatformException catch (e) {
      response = "Failed to get the native string: '${e.message}'.";
    }

    setState(() {
      _response = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: _getNativeString,
              child: const Text('Get String'),
            ),
            Text(_response),
          ],
        ),
      ),
    );
  }
}
