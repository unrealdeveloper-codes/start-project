import 'dart:io';

import 'package:desa/main.dart';
import 'package:desa/utils/routes/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static const platform = MethodChannel('com.example.app/notification');

  Future<void> initialize() async {
    await Firebase.initializeApp();
    await _requestPermission();
    await _initializeLocalNotifications();
    setupForegroundNotificationHandler();
    _setupBackgroundNotificationHandler();
    _setupTokenRefreshHandler();

    // Handle notification when the app is terminated
    _handleTerminatedNotification();

    platform.setMethodCallHandler(_handleNotificationMethodCall);
  }

  Future<void> _handleNotificationMethodCall(MethodCall call) async {
    BuildContext context = navigatorKey.currentContext!;
    context.push(AppRoutes.NOTIFICATION_SCREEN);
    // if (call.method == 'navigateToNotificationScreen') {
    //   String? notificationBody = call.arguments;
    //   print("Navigating to notification screen: $notificationBody");
    //
    //   // Perform navigation
    //   navigatorKey.currentState?.pushNamed('/notificationScreen');
    // }
  }

  Future<void> _requestPermission() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    } else {
      print('User declined or has not accepted permission');
    }
  }

  Future<void> _initializeLocalNotifications() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosInitializationSettings =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      defaultPresentAlert: true,
      defaultPresentBadge: true,
      defaultPresentSound: true,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        print("User tappedffdffff on notification: ${response.payload}");
        print("#########################################");
        _handleNotificationTap(response);
      },
    );
  }

  void setupForegroundNotificationHandler() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _showNotification(message);
    });
  }

  void _setupBackgroundNotificationHandler() {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    print("Handling a background message: ${message.messageId}");
  }

  Future<void> _showNotification(RemoteMessage message) async {
    print("R###########################");
    print("Foreground Notification Payload: ${message.data}");
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'default_channel',
      'Default',
      importance: Importance.max,
      priority: Priority.high,
    );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      sound: "default", // Explicitly set sound
    );

    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _flutterLocalNotificationsPlugin.show(
      message.hashCode,
      message.notification?.title ?? 'Notification',
      message.notification?.body ?? '',
      details,
    );
  }

  void _handleNotificationTap(NotificationResponse response) {
    // Delay navigation until context is ready

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navigateToNotificationScreen();
    });
  }

  void _navigateToNotificationScreen() {
    final context = navigatorKey.currentContext; // Access the context
    if (context != null) {
      print("Navigating to the notification screen");
      context.push(AppRoutes.NOTIFICATION_SCREEN);
    } else {
      print("Navigator context is null, can't navigate");
    }
  }

  Future<String?> getToken() async {
    String? token = await _firebaseMessaging.getToken();
    print("FCM Token: $token");
    return token;
  }

  void _setupTokenRefreshHandler() {
    _firebaseMessaging.onTokenRefresh.listen((newToken) {
      print("Refreshed FCM Token: $newToken");
    });
  }

  void _handleTerminatedNotification() {
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        print(
            "App launched from terminated state by notification: ${message.data}");
        _navigateToNotificationScreen(); // Modify based on your app's requirements
      }
    });
  }
}

// class NotificationService {
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//   final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//
//   Future<void> initialize() async {
//     await Firebase.initializeApp();
//     await _requestPermission();
//     await _initializeLocalNotifications();
//     _setupForegroundNotificationHandler();
//     _setupBackgroundNotificationHandler();
//     _setupTokenRefreshHandler();
//   }
//
//   Future<void> _requestPermission() async {
//     NotificationSettings settings = await _firebaseMessaging.requestPermission(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//
//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       print('User granted permission');
//     } else {
//       print('User declined or has not accepted permission');
//     }
//   }
//
//   Future<void> _initializeLocalNotifications() async {
//     const AndroidInitializationSettings androidInitializationSettings =
//         AndroidInitializationSettings('@mipmap/ic_launcher');
//
//     const DarwinInitializationSettings iosInitializationSettings =
//         DarwinInitializationSettings(
//       requestAlertPermission: true,
//       requestBadgePermission: true,
//       requestSoundPermission: true,
//       defaultPresentAlert: true,
//       defaultPresentBadge: true,
//       defaultPresentSound: true,
//     );
//
//     const InitializationSettings initializationSettings =
//         InitializationSettings(
//       android: androidInitializationSettings,
//       iOS: iosInitializationSettings,
//     );
//
//     await _flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse: (NotificationResponse response) async {
//         print("User tapped on notification: ${response.payload}");
//         _handleNotificationTap(response);
//       },
//     );
//   }
//
//   void _setupForegroundNotificationHandler() {
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       _showNotification(message);
//     });
//   }
//
//   void _setupBackgroundNotificationHandler() {
//     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//   }
//
//   static Future<void> _firebaseMessagingBackgroundHandler(
//       RemoteMessage message) async {
//     await Firebase.initializeApp();
//     print("Handling a background message: ${message.messageId}");
//   }
//
//   Future<void> _showNotification(RemoteMessage message) async {
//     const AndroidNotificationDetails androidDetails =
//         AndroidNotificationDetails(
//       'default_channel',
//       'Default',
//       importance: Importance.max,
//       priority: Priority.high,
//     );
//
//     const DarwinNotificationDetails iosDetails = DarwinNotificationDetails();
//
//     const NotificationDetails details = NotificationDetails(
//       android: androidDetails,
//       iOS: iosDetails,
//     );
//
//     await _flutterLocalNotificationsPlugin.show(
//       message.hashCode,
//       message.notification?.title ?? 'Notification',
//       message.notification?.body ?? '',
//       details,
//     );
//   }
//
//   void _handleNotificationTap(NotificationResponse response) {
//     // Delay navigation until context is ready
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _navigateToNotificationScreen();
//     });
//   }
//
//   void _navigateToNotificationScreen() {
//     final context = navigatorKey.currentContext; // Access the context
//     if (context != null) {
//       print("Navigating to the notification screen");
//       context.push(AppRoutes.NOTIFICATION_SCREEN);
//     } else {
//       print("Navigator context is null, can't navigate");
//     }
//   }
//
//   Future<String?> getToken() async {
//     String? token = await _firebaseMessaging.getToken();
//     print("FCM Token: $token");
//     return token;
//   }
//
//   void _setupTokenRefreshHandler() {
//     _firebaseMessaging.onTokenRefresh.listen((newToken) {
//       print("Refreshed FCM Token: $newToken");
//     });
//   }
// }

// class NotificationService {
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//   final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
//   FlutterLocalNotificationsPlugin();
//
//   // Initialize Firebase, notifications, and set up message handlers
//   Future<void> initialize(BuildContext context) async {
//     await Firebase.initializeApp();
//     await _requestPermission();
//     await _initializeLocalNotifications();
//     _setupForegroundNotificationHandler();
//     _setupBackgroundNotificationHandler();
//     _setupTokenRefreshHandler();
//   }
//
//   Future<void> _requestPermission() async {
//     NotificationSettings settings = await _firebaseMessaging.requestPermission(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//
//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       print('User granted permission');
//     } else {
//       print('User declined or has not accepted permission');
//     }
//   }
//
//   Future<void> _initializeLocalNotifications() async {
//     const AndroidInitializationSettings androidInitializationSettings =
//     AndroidInitializationSettings('@mipmap/ic_launcher');
//
//     const DarwinInitializationSettings iosInitializationSettings =
//     DarwinInitializationSettings();
//
//     const InitializationSettings initializationSettings =
//     InitializationSettings(
//       android: androidInitializationSettings,
//       iOS: iosInitializationSettings,
//     );
//     await _flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse: (NotificationResponse response) async {
//         print("Notification tapped with payload: ${response.payload}");
//         _navigateToNotificationScreen();
//       },
//     );
//   }
//
//   void _setupForegroundNotificationHandler() {
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       _showNotification(message);
//     });
//   }
//
//   void _setupBackgroundNotificationHandler() {
//     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//   }
//
//   static Future<void> _firebaseMessagingBackgroundHandler(
//       RemoteMessage message) async {
//     await Firebase.initializeApp();
//     print("Handling a background message: ${message.messageId}");
//   }
//
//   Future<void> _showNotification(RemoteMessage message) async {
//     const AndroidNotificationDetails androidDetails =
//     AndroidNotificationDetails(
//       'default_channel', // Channel ID
//       'Default', // Channel Name
//       importance: Importance.max,
//       priority: Priority.high,
//     );
//
//     const DarwinNotificationDetails iosDetails = DarwinNotificationDetails();
//
//     const NotificationDetails details = NotificationDetails(
//       android: androidDetails,
//       iOS: iosDetails,
//     );
//
//     await _flutterLocalNotificationsPlugin.show(
//       message.hashCode,
//       message.notification?.title ?? 'Notification',
//       message.notification?.body ?? '',
//       details,
//     );
//   }
//
//   // Navigate to the notification screen using GoRouter
//   void _navigateToNotificationScreen() {
//     final context = navigatorKey.currentContext; // Access the context
//     print(context);
//     if (context != null) {
//       print("(((((((((((((((object)))))))))))))))");
//       context.push(AppRoutes.NOTIFICATION_SCREEN);
//     }
//   }
//
//   Future<String?> getToken() async {
//     String? token = await _firebaseMessaging.getToken();
//     print("FCM Token: $token");
//     return token;
//   }
//
//   void _setupTokenRefreshHandler() {
//     _firebaseMessaging.onTokenRefresh.listen((newToken) {
//       print("Refreshed FCM Token: $newToken");
//     });
//   }
// }

// class NotificationService {
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//   final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
//   FlutterLocalNotificationsPlugin();
//
//   /// Initialize Firebase Messaging and Local Notifications
//   Future<void> initialize(BuildContext context) async {
//     await Firebase.initializeApp();
//     await _requestPermission();
//     await _initializeLocalNotifications(context);
//     _setupForegroundNotificationHandler();
//     _setupBackgroundNotificationHandler();
//     _setupTokenRefreshHandler();
//   }
//
//   /// Request notification permissions (for iOS)
//   Future<void> _requestPermission() async {
//     NotificationSettings settings = await _firebaseMessaging.requestPermission(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//
//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       print('User granted permission');
//     } else {
//       print('User declined or has not accepted permission');
//     }
//   }
//
//   /// Initialize local notifications
//   Future<void> _initializeLocalNotifications(BuildContext context) async {
//     const AndroidInitializationSettings androidInitializationSettings =
//     AndroidInitializationSettings('@mipmap/ic_launcher');
//
//     const DarwinInitializationSettings iosInitializationSettings =
//     DarwinInitializationSettings();
//
//     const InitializationSettings initializationSettings =
//     InitializationSettings(
//       android: androidInitializationSettings,
//       iOS: iosInitializationSettings,
//     );
//
//     await _flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse: (NotificationResponse response) async {
//         print("Notification tapped with payload: ${response.payload}");
//
//           _navigateToNotificationScreen(context, response.payload);
//
//       },
//     );
//   }
//
//
//   /// Handle foreground messages
//   void _setupForegroundNotificationHandler() {
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       _showNotification(message);
//     });
//   }
//
//   /// Handle background messages
//   void _setupBackgroundNotificationHandler() {
//     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//   }
//
//   /// Background message handler
//   static Future<void> _firebaseMessagingBackgroundHandler(
//       RemoteMessage message) async {
//     await Firebase.initializeApp();
//     print("Handling a background message: ${message.messageId}");
//   }
//
//   /// Show a local notification
//   Future<void> _showNotification(RemoteMessage message) async {
//     const AndroidNotificationDetails androidDetails =
//     AndroidNotificationDetails(
//       'default_channel', // Channel ID
//       'Default', // Channel Name
//       importance: Importance.max,
//       priority: Priority.high,
//     );
//
//     const DarwinNotificationDetails iosDetails = DarwinNotificationDetails();
//
//     const NotificationDetails details = NotificationDetails(
//       android: androidDetails,
//       iOS: iosDetails,
//     );
//
//     await _flutterLocalNotificationsPlugin.show(
//       message.hashCode,
//       message.notification?.title ?? 'Notification',
//       message.notification?.body ?? '',
//       details,
//       payload: message.data['screen'], // Pass custom data (screen name or ID)
//     );
//   }
//
//   /// Redirect to the notification screen
//   void _navigateToNotificationScreen(BuildContext context, String? payload) {
//
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => NotificationScreen(),
//         ),
//       );
//     // context.push(AppRoutes.NOTIFICATION_SCREEN);
//
//   }
//
//   /// Get FCM token
//   Future<String?> getToken() async {
//     String? token = await _firebaseMessaging.getToken();
//     print("FCM Token: $token");
//     return token;
//   }
//
//   /// Handle FCM token refresh
//   void _setupTokenRefreshHandler() {
//     _firebaseMessaging.onTokenRefresh.listen((newToken) {
//       print("Refreshed FCM Token: $newToken");
//       refreshToken(newToken);
//     });
//   }
//
//   /// Refresh Token Handler
//   Future<void> refreshToken(String newToken) async {
//     // Handle token refresh logic here
//   }
// }

// class NotificationService {
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//   final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//
//   /// Initialize Firebase Messaging and Local Notifications
//   Future<void> initialize() async {
//     await Firebase.initializeApp();
//     await _requestPermission();
//     await _initializeLocalNotifications();
//     _setupForegroundNotificationHandler();
//     _setupBackgroundNotificationHandler();
//     _setupTokenRefreshHandler();
//   }
//
//   /// Request notification permissions (for iOS)
//   Future<void> _requestPermission() async {
//     NotificationSettings settings = await _firebaseMessaging.requestPermission(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//
//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       print('User granted permission');
//     } else {
//       print('User declined or has not accepted permission');
//     }
//   }
//
//   /// Initialize local notifications
//   Future<void> _initializeLocalNotifications() async {
//     const AndroidInitializationSettings androidInitializationSettings =
//         AndroidInitializationSettings('@mipmap/ic_launcher');
//
//     const DarwinInitializationSettings iosInitializationSettings =
//         DarwinInitializationSettings();
//
//     const InitializationSettings initializationSettings =
//         InitializationSettings(
//       android: androidInitializationSettings,
//       iOS: iosInitializationSettings,
//     );
//     await _flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse: (NotificationResponse response) async {
//         print("Notification tapped with payload: ${response.payload}");
//         // Handle the notification tap action
//       },
//     );
//     // await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }
//
//   /// Handle foreground messages
//   void _setupForegroundNotificationHandler() {
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       _showNotification(message);
//     });
//   }
//
//   /// Handle background messages
//   void _setupBackgroundNotificationHandler() {
//     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//   }
//
//   /// Background message handler
//   static Future<void> _firebaseMessagingBackgroundHandler(
//       RemoteMessage message) async {
//     await Firebase.initializeApp();
//     print("Handling a background message: ${message.messageId}");
//   }
//
//   /// Show a local notification
//   Future<void> _showNotification(RemoteMessage message) async {
//     const AndroidNotificationDetails androidDetails =
//         AndroidNotificationDetails(
//       'default_channel', // Channel ID
//       'Default', // Channel Name
//       importance: Importance.max,
//       priority: Priority.high,
//     );
//
//     const DarwinNotificationDetails iosDetails = DarwinNotificationDetails();
//
//     const NotificationDetails details = NotificationDetails(
//       android: androidDetails,
//       iOS: iosDetails,
//     );
//
//     await _flutterLocalNotificationsPlugin.show(
//       message.hashCode,
//       message.notification?.title ?? 'Notification',
//       message.notification?.body ?? '',
//       details,
//     );
//   }
//
//   /// Get FCM token
//   Future<String?> getToken() async {
//     String? token = await _firebaseMessaging.getToken();
//     print("FCM Token: $token");
//     return token;
//   }
//
//   /// Handle FCM token refresh
//   void _setupTokenRefreshHandler() {
//     _firebaseMessaging.onTokenRefresh.listen((newToken) {
//       print("Refreshed FCM Token: $newToken");
//       refreshToken(newToken);
//       // Save the new token to your server if needed
//     });
//   }
//
//   final prefs = UserPreferences();
//   /// Refresh Token Handler
//   Future<void> refreshToken(String newToken) async {
//     String oldToken = await prefs.getDeviceToken() ?? "";
//
//     if (oldToken.isEmpty) {
//       print('No device token found, cannot refresh.');
//       return;
//     }
//
//     MapSS query = {"old_token": oldToken, "new_token": newToken};
//
//     try {
//       final ResponseType response = await AuthRepo().refreshToken(query);
//
//       if (response.isNotEmpty) {
//         // Handle success, like saving the new token to the server or local storage
//         print('Token refreshed successfully');
//         await prefs.setDeviceToken(newToken);  // Save the new token locally
//       } else {
//         print('Failed to refresh token');
//       }
//     } catch (e) {
//       print('Error refreshing token: $e');
//     }
//   }
//
// }
