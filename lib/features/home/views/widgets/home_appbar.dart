import 'package:desa/features/authentication/controllers/auth_controller.dart';
import 'package:desa/features/static/bottomNavigationBar/controllers/bottom_navigation_bar_controller.dart';
import 'package:desa/utils/components/image/app_cache_image.dart';
import 'package:desa/utils/components/shimmer/app_shimmer_effect.dart';
import 'package:desa/utils/components/text/app_text.dart';
import 'package:desa/utils/constants/app_colors.dart';
import 'package:desa/utils/constants/app_sizer.dart';
import 'package:desa/utils/constants/app_strings.dart';
import 'package:desa/utils/constants/app_svg.dart';
import 'package:desa/utils/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    final authController = AuthController.instance;
    final userFirstName = authController.user.name?.split(" ")[0].toUpperCase();
    return AppBar(
      elevation: 3,
      backgroundColor: Colors.white,
      surfaceTintColor: AppColor.appBackgroundColor,
      shadowColor: Colors.grey.withOpacity(0.2),
      automaticallyImplyLeading: false,
      title: InkWell(
        onTap: () {
          Get.find<BottomNavigationBarController>().selectedIndex.value = 4;
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MySofiaSansText(
              text: "HELLO  ${userFirstName ?? ""}",
              fontSize: AppSizer.fontSize17,
              height: height * 0.001,
              fontWeight: FontWeight.w800,
            ),
            SizedBox(height: AppSizer.height * 0.005),
            MyManropeText(
              text: AppStrings.greeting,
              color: AppColor.greyTextColor,
              fontWeight: FontWeight.w600,
              fontSize: AppSizer.fontSize12,
            ),
          ],
        ),
      ),
      leadingWidth: width * 0.14,
      titleSpacing: width * 0.03,
      toolbarHeight: AppSizer.appBarHeight,
      leading: Padding(
        padding: EdgeInsets.only(
          left: width * 0.035,
          // top: width * 0.012,
          // bottom: width * 0.012,
        ),
        child: InkWell(
          onTap: () {
            Get.find<BottomNavigationBarController>().selectedIndex.value = 4;
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: AppCacheImage(
              image: authController.user.profileImage ?? "",
              isCircular: true,
              isNetworkImage: true,
              fit: BoxFit.contain,
              progressIndicatorWidget: Shimmer.fromColors(
                baseColor: AppColor.shimmerBaseColor,
                highlightColor: AppColor.shimmerHighlightColor,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.shimmerContentColor,
                  ),
                ),
              ),
              errorWidget: SvgPicture.asset(
                AppSvg.profileIcon,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            context.push(AppRoutes.NOTIFICATION_SCREEN);
          },
          icon: SvgPicture.asset(AppSvg.notificationIcon),
        ),
        SizedBox(width: width * 0.015),
      ],
    );
  }
}
