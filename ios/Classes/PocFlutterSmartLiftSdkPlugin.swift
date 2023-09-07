import Flutter
import UIKit
import ThingSmartBaseKit
import ThingSmartDeviceKit
import ThingSmartActivatorKit

public class PocFlutterSmartLiftSdkPlugin: NSObject, FlutterPlugin, ThingSmartActivatorDelegate {
  let tuyaActivator = ThingSmartActivator()
  var pairingMethodCall: FlutterMethodCall?
  var pairingResult: FlutterResult?
    
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "poc_flutter_smart_lift_sdk_plugin", binaryMessenger: registrar.messenger())
    let instance = PocFlutterSmartLiftSdkPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
    case "start":
        start(call, result: result)
    case "startPairingDeviceWithAPMode":
      startPairingDeviceWithAPMode(call, result: result)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
   
    private func start(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      guard
        let args = call.arguments as? Dictionary<String, Any>,
        let appKey = args["app_key"] as? String,
        let secretKey = args["secret_key"] as? String
      else {
        let flutterError = FlutterError(
          code: "ARGUMENTS_ERROR",
          message: "Arguments missing.",
          details: nil
        );

        return result(flutterError)
      }
       
      ThingSmartSDK.sharedInstance().start(
        withAppKey: appKey,
        secretKey: secretKey
      )
    }
    
  private func startPairingDeviceWithAPMode(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    guard
      let args = call.arguments as? Dictionary<String, Any>,
      let ssid = args["ssid"] as? String,
      let password = args["password"] as? String,
      let token = args["token"] as? String,
      let timeout = args["time_out"] as? Int?
    else {
      let flutterError = FlutterError(
        code: "ARGUMENTS_ERROR",
        message: "Arguments missing.",
        details: nil
      );

      return result(flutterError)      
    }
     
    pairingMethodCall = call
    pairingResult = result
    tuyaActivator.delegate = self
    tuyaActivator.startConfigWiFi(
      .AP,
      ssid: ssid,
      password: password,
      token: token,
      timeout: TimeInterval(timeout ?? 200)
    )
  }
    
  public func activator(
    _ activator: ThingSmartActivator!,
    didReceiveDevice deviceModel: ThingSmartDeviceModel!,
    error: Error!
  ) {
    if deviceModel != nil && error == nil {
      pairingResult?("SUCCESS")
    }
              
    if let error = error {
      let flutterError = FlutterError(
        code: "PAIRING_ERROR",
        message: error.localizedDescription,
        details: nil
      );
    
      pairingResult?(flutterError)
    }
  }
}
