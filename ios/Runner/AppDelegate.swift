import Flutter
import UIKit
import UserNotifications
import FirebaseCore
import FirebaseMessaging
import Firebase


@main
@objc class AppDelegate: FlutterAppDelegate {

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // Initialize Firebase
    FirebaseApp.configure()

    // Register for push notifications
    requestPushNotificationPermission()

    // Register Flutter plugins
    GeneratedPluginRegistrant.register(with: self)

    // Set UNUserNotificationCenter delegate
    UNUserNotificationCenter.current().delegate = self

    // Set Firebase Messaging delegate
    Messaging.messaging().delegate = self

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  // Request push notification permission for iOS
  func requestPushNotificationPermission() {
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
      if granted {
        print("Push notification permission granted")
      } else {
        print("Push notification permission denied: \(error?.localizedDescription ?? "unknown error")")
      }
    }

    // Register for remote notifications
    UIApplication.shared.registerForRemoteNotifications()
  }

  // Handle device token registration
  override func application(_ application: UIApplication,
                            didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    // Pass the device token to Firebase Messaging
    Messaging.messaging().apnsToken = deviceToken
    print("APNs device token: \(deviceToken.map { String(format: "%02.2hhx", $0) }.joined())")
  }

  // Handle foreground notifications
  override func userNotificationCenter(
      _ center: UNUserNotificationCenter,
      willPresent notification: UNNotification,
      withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
  ) {
      print("Notification received in foreground: \(notification.request.content.userInfo)")

      // Check if sound exists in the payload
      if let aps = notification.request.content.userInfo["aps"] as? [String: AnyObject],
         let sound = aps["sound"] as? String {
          print("Sound: \(sound)")  // Log sound field if available
      } else {
          print("No sound field in the notification payload.")
      }

      // Explicitly add sound to ensure it plays
      completionHandler([.alert, .badge, .sound])
  }

//  override func userNotificationCenter(
//    _ center: UNUserNotificationCenter,
//    willPresent notification: UNNotification,
//    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
//  ) {
//
//
//
//
//
//   print("User tttttttttttttttttt on notification: \(notification.request.content.sound)")
//       print("Notification received in foreground: \(notification.request.content.userInfo)")
//
//    // Show notification when app is in the foreground
//    completionHandler([.alert, .badge, .sound])
//  }

  // Handle background or terminated notifications
  override func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    didReceive response: UNNotificationResponse,
    withCompletionHandler completionHandler: @escaping () -> Void
  ) {
    // Handle user tapping on the notification
    print("User tappedttt on notification: \(response.notification.request.content.body)")
    if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
      let channel = FlutterMethodChannel(name: "com.example.app/notification", binaryMessenger: appDelegate.window?.rootViewController as! FlutterBinaryMessenger)

      // Send a message to Flutter to handle the navigation
      channel.invokeMethod("navigateToNotificationScreen", arguments: response.notification.request.content.body)
    }
    completionHandler()
  }
}


// Extend AppDelegate to conform to MessagingDelegate
extension AppDelegate: MessagingDelegate {
  func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
    print("Firebase registration token: \(fcmToken ?? "None")")
    // Save or send the token to your server as needed
  }
}

//import Flutter
//import UIKit
//import UserNotifications
//
//@main
//@objc class AppDelegate: FlutterAppDelegate {
//
//  override func application(
//    _ application: UIApplication,
//    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
//  ) -> Bool {
//    // Register for push notifications
//    requestPushNotificationPermission()
//
//    // Register Flutter plugins
//    GeneratedPluginRegistrant.register(with: self)
//
//    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
//  }
//
//  // Request push notification permission for iOS
//  func requestPushNotificationPermission() {
//    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
//      if granted {
//        print("Push notification permission granted")
//      } else {
//        print("Push notification permission denied")
//      }
//    }
//
//    // Register for remote notifications
//    UIApplication.shared.registerForRemoteNotifications()
//  }
//
//  // Handle the push notification when the app is in the foreground
//  override func userNotificationCenter(
//    _ center: UNUserNotificationCenter,
//    willPresent notification: UNNotification,
//    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
//  ) {
//    // Show notification when app is in the foreground
//    completionHandler([.alert, .badge, .sound])
//  }
//
//  // Handle the push notification when the app is in the background or terminated
//  override func userNotificationCenter(
//    _ center: UNUserNotificationCenter,
//    didReceive response: UNNotificationResponse,
//    withCompletionHandler completionHandler: @escaping () -> Void
//  ) {
//    // Handle user tapping on the notification
//    print("User tapped on notification: \(response.notification.request.content.body)")
//    completionHandler()
//  }
//}

//import Flutter
//import UIKit
//
//@main
//@objc class AppDelegate: FlutterAppDelegate {
//  override func application(
//    _ application: UIApplication,
//    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
//  ) -> Bool {
//    GeneratedPluginRegistrant.register(with: self)
//    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
//  }
//}

