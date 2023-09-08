import 'package:flutter_test/flutter_test.dart';
import 'package:poc_flutter_smart_lift_sdk_plugin/poc_flutter_smart_lift_sdk_plugin.dart';
import 'package:poc_flutter_smart_lift_sdk_plugin/poc_flutter_smart_lift_sdk_plugin_platform_interface.dart';
import 'package:poc_flutter_smart_lift_sdk_plugin/poc_flutter_smart_lift_sdk_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockPocFlutterSmartLiftSdkPluginPlatform
    with MockPlatformInterfaceMixin
    implements PocFlutterSmartLiftSdkPluginPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<String> pairingDeviceAPMode({
    required String ssid,
    required String password,
    required String token,
  }) {
    throw UnimplementedError();
  }

  @override
  Future register({required String appKey, required String secretKey}) {
    throw UnimplementedError();
  }

  @override
  Future<String> loginWithTicket({required String ticket}) {
    throw UnimplementedError();
  }
}

void main() {
  final PocFlutterSmartLiftSdkPluginPlatform initialPlatform =
      PocFlutterSmartLiftSdkPluginPlatform.instance;

  test('$MethodChannelPocFlutterSmartLiftSdkPlugin is the default instance',
      () {
    expect(initialPlatform,
        isInstanceOf<MethodChannelPocFlutterSmartLiftSdkPlugin>());
  });

  test('getPlatformVersion', () async {
    PocFlutterSmartLiftSdkPlugin pocFlutterSmartLiftSdkPlugin =
        PocFlutterSmartLiftSdkPlugin();
    MockPocFlutterSmartLiftSdkPluginPlatform fakePlatform =
        MockPocFlutterSmartLiftSdkPluginPlatform();
    PocFlutterSmartLiftSdkPluginPlatform.instance = fakePlatform;

    expect(await pocFlutterSmartLiftSdkPlugin.getPlatformVersion(), '42');
  });
}
