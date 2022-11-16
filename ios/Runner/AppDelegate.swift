import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    GMSServices.provideAPIKey(AIzaSyDy2OWrkZfHxWOtw-6xBNKil69-nevAIu0)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
