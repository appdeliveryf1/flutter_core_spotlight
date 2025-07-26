import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_core_spotlight/flutter_core_spotlight.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    FlutterCoreSpotlight.instance.configure(
      onSearchableItemSelected: (userActivity) {
        print(userActivity);
        Fluttertoast.showToast(
          msg: 'Selected: ${userActivity?.uniqueIdentifier ?? 'Unknown'}',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _textController,
                autocorrect: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                child: Text('Index'),
                onPressed: () {
                  if (_textController.text.trim().isEmpty) {
                    Fluttertoast.showToast(msg: 'Please enter a value');
                    return;
                  }
                  FlutterCoreSpotlight.instance.indexSearchableItems([
                    FlutterSpotlightItem(
                      uniqueIdentifier: _textController.text,
                      domainIdentifier: 'com.example.flutter_spotlight_plugin',
                      attributeTitle: _textController.text,
                      attributeDescription: 'This is an example description',
                    )
                  ]);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
