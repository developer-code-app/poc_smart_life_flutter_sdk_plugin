import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'poc_flutter_smart_lift_sdk_plugin_platform_interface.dart';

/// An implementation of [PocFlutterSmartLiftSdkPluginPlatform] that uses method channels.
class MethodChannelPocFlutterSmartLiftSdkPlugin
    extends PocFlutterSmartLiftSdkPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel =
      const MethodChannel('poc_flutter_smart_lift_sdk_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future register({required String appKey, required String secretKey}) async {
    final argument = {
      'app_key': appKey,
      'secret_key': secretKey,
    };

    return await methodChannel.invokeMethod(
      'register',
      argument,
    );
  }

  @override
  Future<String> loginWithTicket({required String ticket}) async {
    final argument = {
      'ticket': ticket,
    };

    return await methodChannel.invokeMethod(
      'loginWithTicket',
      argument,
    );
  }

  @override
  Future<String> pairingDeviceAPMode({
    required String ssid,
    required String password,
    required String token,
  }) async {
    final argument = {
      'ssid': ssid,
      'password': password,
      'token': token,
    };

    return await methodChannel.invokeMethod(
      'pairingDeviceAPMode',
      argument,
    );
  }
}
