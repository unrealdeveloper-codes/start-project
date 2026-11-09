import 'package:desa/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../controllers/bottom_navigation_bar_controller.dart';

class BottomNavigationBarView extends StatelessWidget {
  const BottomNavigationBarView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BottomNavigationBarController());
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: Obx(
        () => AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          child: controller.screens[controller.selectedIndex.value],
        ),
      ),
      bottomNavigationBar: Obx(
        () => Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: AppColor.greyTextColor.withOpacity(0.2),
              blurRadius: 20,
              spreadRadius: 0.1,
            )
          ]),
          // height: height * 0.1,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(width * 0.025),
            child: BottomNavigationBar(
              currentIndex: controller.selectedIndex.value,
              onTap: (index) {
                controller.changeTabIndex(index);
              },

              elevation: 30,
              items: [
                BottomNavigationBarItem(
                  icon: _buildIcon(
                      'assets/bottomBarSvgIcons/home_active.svg', 0, context),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: _buildIcon(
                      'assets/bottomBarSvgIcons/food_active.svg', 1, context),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: _buildIcon(
                      'assets/bottomBarSvgIcons/exercise_active.svg',
                      2,
                      context),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: _buildIcon(
                      'assets/bottomBarSvgIcons/process_active.svg',
                      3,
                      context),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: _buildIcon(
                      'assets/bottomBarSvgIcons/profile_active.svg',
                      4,
                      context),
                  label: '',
                ),
              ],
              selectedItemColor: AppColor.primaryColor1,
              unselectedItemColor: Colors.grey,
              showUnselectedLabels: false,
              type: BottomNavigationBarType.fixed,
              backgroundColor: AppColor.appBackgroundColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(String assetPath, int index, BuildContext context) {
    final controller = BottomNavigationBarController.instance;
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: controller.selectedIndex.value == index ? height * 0.01 : 0.0,
          ),
          child: SvgPicture.asset(
            assetPath,
            color: controller.selectedIndex.value == index
                ? AppColor.primaryColor1
                : Colors.grey,
          ),
        ),
        if (controller.selectedIndex.value == index)
          Column(
            children: [
              SizedBox(height: height * 0.005),
              CircleAvatar(
                radius: width * 0.005,
                backgroundColor: AppColor.primaryColor1,
              ),
            ],
          ),
      ],
    );
  }
}
