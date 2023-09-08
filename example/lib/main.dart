import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';

import 'package:poc_flutter_smart_lift_sdk_plugin/poc_flutter_smart_lift_sdk_plugin.dart';
import 'package:poc_flutter_smart_lift_sdk_plugin_example/action_sheet.dart'
    as action_sheet;
import 'package:poc_flutter_smart_lift_sdk_plugin_example/cubit/alert_dialog_cubit.dart';
import 'package:poc_flutter_smart_lift_sdk_plugin_example/cubit/ui_blocking_cubit.dart';
import 'package:poc_flutter_smart_lift_sdk_plugin_example/extensions/alert_dialog_convenience_showing.dart';
import 'package:poc_flutter_smart_lift_sdk_plugin_example/loading_with_blocking_widget.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<AlertDialogCubit>(
        create: (context) => AlertDialogCubit(),
      ),
      BlocProvider<UIBlockingCubit>(
        create: (context) => UIBlockingCubit(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final smartLift = PocFlutterSmartLiftSdkPlugin();

  static const ticket = "";
  static const token = "";

  @override
  void initState() {
    super.initState();

    smartLift.register(
      appKey: '9gkqeyckm39umcm5h9am',
      secretKey: 's584kn3e5aujfuut3wwe9fkvasfc34we',
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiBlocListener(
        listeners: [
          BlocListener<AlertDialogCubit, AlertData?>(
            listener: (context, state) {
              if (state == null) return;
              _showAlertFromData(context, data: state);
            },
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          body: LoadingWithBlockingWidget(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextButton(
                      child: const Text('Login'),
                      onPressed: () => _login(context),
                    ),
                    TextButton(
                      child: const Text('Device Pairing'),
                      onPressed: () => _pairingDeviceAPMode(context),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _login(BuildContext context) async {
    final uiBlockingCubit = context.read<UIBlockingCubit>();
    final alertDialogCubit = context.read<AlertDialogCubit>();

    uiBlockingCubit.block();

    try {
      await smartLift.loginWithTicket(ticket: ticket);

      alertDialogCubit.alert(title: "Login Success");
    } catch (error) {
      alertDialogCubit.alert(
        title: "Pairing Device Error",
        message: error.toString(),
      );
    } finally {
      uiBlockingCubit.unblock();
    }
  }

  Future<void> _pairingDeviceAPMode(BuildContext context) async {
    final uiBlockingCubit = context.read<UIBlockingCubit>();
    final alertDialogCubit = context.read<AlertDialogCubit>();

    uiBlockingCubit.block();

    try {
      await smartLift.pairingDeviceAPMode(
        ssid: 'CodeApp',
        password: '9code7app9',
        token: token,
      );

      alertDialogCubit.alert(title: "Pairing Device Success");
    } catch (error) {
      alertDialogCubit.alert(
        title: "Pairing Device Error",
        message: error.toString(),
      );
    } finally {
      uiBlockingCubit.unblock();
    }
  }

  void _showAlertFromData(
    BuildContext context, {
    required AlertData data,
  }) {
    if (data is DialogData) {
      AlertDialogConvenienceShowing.showAlertDialog(
        context: context,
        title: data.title,
        message: data.message,
        remark: data.remark,
        actions: data.actions,
        onDismissed: data.onDismissed,
        dismissible: data.dismissible,
      );
    } else if (data is ActionSheetData) {
      action_sheet.ActionSheet(
        title: data.title,
        message: data.message,
        actions: data.actions
            .map(
              (action) => action_sheet.Action(
                action.title,
                () => action.onPressed?.call(),
                style: action.style,
              ),
            )
            .toList(),
        cancel: action_sheet.Action(
          data.cancelAction.title,
          () => data.cancelAction.onPressed?.call(),
        ),
      ).show(context);
    }
  }
}
