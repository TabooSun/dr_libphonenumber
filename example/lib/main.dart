import 'package:dr_libphonenumber/dr_libphonenumber.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              const Text('Click button!'),
              ElevatedButton(
                onPressed: _runFormatNumber,
                child: const Text('Run format number'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _runFormatNumber() {
    print(DrLibphonenumber.instance.format(
      phoneNumber: '0129602189',
      isoCode: 'MY',
    ));
  }
}
