import 'poc_flutter_smart_lift_sdk_plugin_platform_interface.dart';

class PocFlutterSmartLiftSdkPlugin {
  Future<String> loginWithTicket({required String ticket}) async {
    return PocFlutterSmartLiftSdkPluginPlatform.instance.loginWithTicket(
      ticket: ticket,
    );
  }

  Future<String> pairingDeviceAPMode({
    required String ssid,
    required String password,
    required String token,
  }) async {
    return PocFlutterSmartLiftSdkPluginPlatform.instance.pairingDeviceAPMode(
      ssid: ssid,
      password: password,
      token: token,
    );
  }
}
