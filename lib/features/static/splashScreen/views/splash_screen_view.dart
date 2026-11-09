import 'package:desa/features/authentication/controllers/auth_controller.dart';
import 'package:desa/utils/constants/app_colors.dart';
import 'package:desa/utils/network/network_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  @override
  // void initState() {
  //   startTimer();
  //   super.initState();
  // }

  // void startTimer() {
  //   Get.put(NetworkManager(context));
  //   Future.delayed(const Duration(seconds: 2), () {
  //     final controller = Get.put(AuthController());
  //     controller.screenRedirect(context);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    Get.put(AuthController(context));
    Get.put(NetworkManager(context));
    return Scaffold(
      backgroundColor: AppColor.primaryColor3,
      body: Center(
        child: SizedBox(
          width: width * 0.35,
          height: width * 0.35,
          child: SvgPicture.asset('assets/logo/app_icon_new.svg'),
        ),
      ),
    );
  }
}
