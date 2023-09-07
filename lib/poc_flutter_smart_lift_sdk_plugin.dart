import 'poc_flutter_smart_lift_sdk_plugin_platform_interface.dart';

class PocFlutterSmartLiftSdkPlugin {
  Future<String?> getPlatformVersion() {
    return PocFlutterSmartLiftSdkPluginPlatform.instance.getPlatformVersion();
  }
}

class SmartLiftSdkPlugin {
  static final SmartLiftSdkPlugin _instance = SmartLiftSdkPlugin._internal();

  factory SmartLiftSdkPlugin.shared() {
    return _instance;
  }

  SmartLiftSdkPlugin._internal();

  Future start({required String appKey, required String secretKey}) {
    return PocFlutterSmartLiftSdkPluginPlatform.instance.start(
      appKey: appKey,
      secretKey: secretKey,
    );
  }

  Future<String> startPairingDeviceWithAPMode({
    required String ssid,
    required String password,
    required String token,
  }) async {
    return PocFlutterSmartLiftSdkPluginPlatform.instance
        .startPairingDeviceWithAPMode(
      ssid: ssid,
      password: password,
      token: token,
    );
  }
}
