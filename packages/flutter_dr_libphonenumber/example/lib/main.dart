import 'package:flutter/material.dart';
import 'package:flutter_dr_libphonenumber/flutter_dr_libphonenumber.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? _text;

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
              Text(_text ?? '-'),
            ],
          ),
        ),
      ),
    );
  }

  void _runFormatNumber() {
    _text = LibPhoneNumber.i.format(
      phoneNumber: '0129602189',
      isoCode: 'MY',
      phoneNumberFormat: DrPhoneNumberFormat.e164,
    );
    setState(() {});
  }
}
