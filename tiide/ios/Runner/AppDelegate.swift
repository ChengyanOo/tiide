import Flutter
import UIKit
import UserNotifications

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let save = UNNotificationAction(
      identifier: "SAVE_TAG",
      title: "Save & tag",
      options: [.foreground])
    let extend = UNNotificationAction(
      identifier: "EXTEND_5",
      title: "+5 minutes",
      options: [])
    let endCategory = UNNotificationCategory(
      identifier: "TIIDE_END",
      actions: [save, extend],
      intentIdentifiers: [],
      options: [])
    UNUserNotificationCenter.current().setNotificationCategories([endCategory])
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
  }
}
