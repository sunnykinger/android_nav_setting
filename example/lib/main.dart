import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:android_nav_setting/android_nav_setting.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _navigationStatus = 'Unknown';
  final _androidNavSettingPlugin = AndroidNavSetting();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    bool? isGestureEnabled;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      isGestureEnabled = await _androidNavSettingPlugin.isGestureNavigationEnabled();
      _navigationStatus = isGestureEnabled ? 'Enabled' : 'Disabled';
    } on PlatformException {
      _navigationStatus = 'Failed to get navigation status.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Gesture Navigation: $_navigationStatus\n'),
        ),
      ),
    );
  }
}