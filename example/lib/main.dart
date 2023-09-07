import 'package:flutter/material.dart';
import 'dart:async';

import 'package:poc_flutter_smart_lift_sdk_plugin/poc_flutter_smart_lift_sdk_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    SmartLiftSdkPlugin.shared().start(
      appKey: '9gkqeyckm39umcm5h9am',
      secretKey: 's584kn3e5aujfuut3wwe9fkvasfc34we',
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextButton(
                  child: const Text('Device Pairing'),
                  onPressed: () => _startPairingDeviceWithAPMode(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _startPairingDeviceWithAPMode() async {
    try {
      final result =
          await SmartLiftSdkPlugin.shared().startPairingDeviceWithAPMode(
        ssid: 'CodeApp',
        password: '9code7app9',
        token: 'sdf',
      );

      print(result);
    } catch (error) {
      print(error.toString());
    }
  }
}
