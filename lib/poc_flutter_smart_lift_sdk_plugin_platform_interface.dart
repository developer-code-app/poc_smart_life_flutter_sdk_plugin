import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'poc_flutter_smart_lift_sdk_plugin_method_channel.dart';

abstract class PocFlutterSmartLiftSdkPluginPlatform extends PlatformInterface {
  /// Constructs a PocFlutterSmartLiftSdkPluginPlatform.
  PocFlutterSmartLiftSdkPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static PocFlutterSmartLiftSdkPluginPlatform _instance =
      MethodChannelPocFlutterSmartLiftSdkPlugin();

  /// The default instance of [PocFlutterSmartLiftSdkPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelPocFlutterSmartLiftSdkPlugin].
  static PocFlutterSmartLiftSdkPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [PocFlutterSmartLiftSdkPluginPlatform] when
  /// they register themselves.
  static set instance(PocFlutterSmartLiftSdkPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String> loginWithTicket({required String ticket}) async {
    throw UnimplementedError('loginWithTicket() has not been implemented.');
  }

  Future<String> pairingDeviceAPMode({
    required String ssid,
    required String password,
    required String token,
  }) async {
    throw UnimplementedError(
      'pairingDeviceAPMode() has not been implemented.',
    );
  }
}
