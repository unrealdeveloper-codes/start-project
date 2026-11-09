import 'package:desa/data/datasources/local/storage_utility.dart';
import 'package:desa/data/notificationSection/NotificationService.dart';
import 'package:desa/utils/constants/app_colors.dart';
import 'package:desa/utils/constants/app_sizer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'utils/routes/app_pages.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  final context = navigatorKey.currentContext; // Access the context
  if (context != null) {
    context.push(AppRoutes.NOTIFICATION_SCREEN);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await AppLocalStorage.init("user_pref");
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final notificationService = NotificationService();
    notificationService.initialize();

    AppRes.init(context);
    // Get.put(NetworkManager(context));
    return GlobalLoaderOverlay(
      duration: Durations.medium4,
      reverseDuration: Durations.medium4,
      overlayColor: Colors.grey.withOpacity(0.6),
      overlayWidgetBuilder: (_) {
        return const Center(
          child: CircularProgressIndicator(color: AppColor.primaryColor1),
        );
      },
      child: MaterialApp.router(
        title: "Desa",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFAFAFA)),
          scaffoldBackgroundColor: AppColor.appBackgroundColor,
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColor.appBackgroundColor,
            surfaceTintColor: Colors.transparent,
          ),
          scrollbarTheme: ScrollbarThemeData(
            thickness: WidgetStateProperty.all(4.0),
            radius: const Radius.circular(100.0),
            minThumbLength: 30.0,
            thumbColor: WidgetStateProperty.all(AppColor.primaryColor1),
          ),
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: AppColor.primaryColor3,
            selectionColor: AppColor.primaryColor3.withOpacity(0.2),
            selectionHandleColor: AppColor.primaryColor1,
          ),
        ),
        routerConfig: AppGoRouter.router,
      ),
    );
  }
}
