import 'package:desa/features/authentication/controllers/auth_controller.dart';
import 'package:desa/features/home/controllers/home_controller.dart';
import 'package:desa/utils/cards/image_title_card.dart';

import 'package:desa/utils/components/buttons/customeElevatedButton.dart';
import 'package:desa/utils/components/image/app_cache_image.dart';
import 'package:desa/utils/components/text/app_text.dart';
import 'package:desa/utils/constants/app_colors.dart';
import 'package:desa/utils/constants/app_sizer.dart';
import 'package:desa/utils/constants/resuable_box_decoration.dart';
import 'package:desa/utils/routes/app_pages.dart';
import 'package:desa/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final authController = AuthController.instance;
    final user = authController.user;
    return Scaffold(
      backgroundColor: AppColor.appBackgroundColor,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: AppColor.appBackgroundColor,
        surfaceTintColor: AppColor.appBackgroundColor,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // Positioned(
            //   top: -height * 0.02,
            //   child: AppCacheImage(
            //     image: authController.user.profileImage ?? "",
            //     isCircular: true,
            //     isNetworkImage: true,
            //     errorWidget: SvgPicture.asset(
            //       'assets/profileIcons/profile_background.svg',
            //       fit: BoxFit.contain,
            //     ),
            //   ),
            // ),
            Positioned(
              top: -height * 0.02,
              child: SvgPicture.asset(
                'assets/profileIcons/profile_background.svg',
                width: AppSizer.width,
              ),
            ),
            Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: AppSizer.horizontal20),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: AppSizer.height * 0.11,
                        ),
                        AppCacheImage(
                          image: user.profileImage ?? "",
                          isCircular: true,
                          width: AppSizer.width * 0.3,
                          height: AppSizer.width * 0.3,
                          isNetworkImage: true,
                          errorWidget: SvgPicture.asset(
                            'assets/homePageIcons/profileicon.svg',
                            fit: BoxFit.contain,
                          ),
                        ),
                        // SvgPicture.asset(
                        //   'assets/homePageIcons/profileicon.svg',
                        //   width: AppSizer.width * 0.3,
                        // ),
                        SizedBox(height: AppSizer.height * 0.02),
                        SizedBox(
                          width: width * 0.8,
                          child: Center(
                            child: MySofiaSansText(
                              text: user.name ?? "",
                              maxLines: 1,
                            ),
                          ),
                        ),
                        SizedBox(height: AppSizer.height * 0.005),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.calendar_month,
                              size: AppSizer.width * 0.05,
                            ),
                            SizedBox(width: AppSizer.width * 0.02),
                            MyManropeText(
                              text: Utils.formatDob(user.dob ?? ""),
                              color: AppColor.primaryColor2,
                            )
                          ],
                        ),
                        SizedBox(height: AppSizer.height * 0.01),
                        SizedBox(
                          width: width * 0.8,
                          child: Center(
                            child: MyManropeText(
                              text: user.email ?? "",
                              color: AppColor.greyTextColor,
                              maxLines: 1,
                            ),
                          ),
                        ),
                        SizedBox(height: AppSizer.height * 0.025),
                        Container(
                          decoration: ReusableDecoration.reusableBoxDecoration(
                              context: context),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: AppSizer.vertical8),
                                child: Row(
                                  children: [
                                    // TODO : Add a logic for female get an icon from desginer
                                    SvgPicture.asset(
                                      'assets/profileIcons/maleIcon.svg',
                                      width: AppSizer.width * 0.05,
                                    ),
                                    SizedBox(
                                      width: AppSizer.width * 0.015,
                                    ),
                                    MyManropeText(
                                      text: user.gender?.capitalizeFirst ?? "",
                                      color: AppColor.primaryColor2,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: AppSizer.height * 0.05,
                                // Add height constraint for the divider
                                width: AppSizer.width * 0.0015,
                                // Thickness of the divider
                                color: AppColor.greyTextColor.withOpacity(0.5),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: AppSizer.vertical8),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/profileIcons/scaleIcon.svg',
                                      width: AppSizer.width * 0.05,
                                    ),
                                    SizedBox(
                                      width: AppSizer.width * 0.015,
                                    ),
                                    SizedBox(
                                      width: width * 0.18,
                                      child: Center(
                                        child: MyManropeText(
                                          text: '${user.height} cm',
                                          color: AppColor.primaryColor2,
                                          maxLines: 1,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                  height: AppSizer.height * 0.05,
                                  // Add height constraint for the divider
                                  width: AppSizer.width * 0.0015,
                                  // Thickness of the divider
                                  color:
                                      AppColor.greyTextColor.withOpacity(0.5)),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: AppSizer.vertical8),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/profileIcons/weight.svg',
                                      width: AppSizer.width * 0.05,
                                    ),
                                    SizedBox(
                                      width: AppSizer.width * 0.015,
                                    ),
                                    SizedBox(
                                      width: width * 0.16,
                                      child: Center(
                                        child: MyManropeText(
                                          text: '${user.weight} kg',
                                          color: AppColor.primaryColor2,
                                          maxLines: 1,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: AppSizer.height * 0.02,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: AppSizer.horizontal15),
                  child: Column(
                    children: [
                      ImageTitleCard(
                        onTap: () {
                          context.push(AppRoutes.CHANGE_PASSWORD_SCREEN);
                        },
                        heading: 'Change Password',
                        svg: 'assets/profileIcons/lock-password-line.svg',
                      ),
                      ImageTitleCard(
                        onTap: () {
                          context.push(AppRoutes.NOTIFICATION_SETTING_SCREEN);
                        },
                        heading: 'Notification Setting',
                        svg: 'assets/profileIcons/notification-line.svg',
                      ),
                      ImageTitleCard(
                        onTap: () {
                          context.push(AppRoutes.HELP_AND_SUPPORT_SCREEN);
                        },
                        heading: 'Help & Support',
                        svg: 'assets/profileIcons/headphone-line.svg',
                      ),
                      ImageTitleCard(
                        onTap: () {
                          context.push(AppRoutes.ABOUT_APP_SCREEN);
                        },
                        heading: 'About App',
                        svg: 'assets/profileIcons/about_appIcon.svg',
                      ),
                      SizedBox(
                        height: AppSizer.height * 0.02,
                      ),
                      CustomeLogOutButton(
                          text: 'LogOut',
                          onPressed: () {
                            // authController.logout(context),
                            _showLogoutConfirmationDialog(
                                context, authController);
                          },
                          // onPressed: () => context.go(AppRoutes.LOGIN_SCREEN),
                          transparent: true,
                          icon: SvgPicture.asset(
                            'assets/profileIcons/logout-box-line.svg',
                            width: AppSizer.width * 0.05,
                          )),
                      SizedBox(
                        height: AppSizer.height * 0.05,
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void _showLogoutConfirmationDialog(
      BuildContext contextt, AuthController authController) {
    showDialog(
      context: contextt,
      barrierDismissible: false,
      // The dialog can't be dismissed by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.symmetric(
              horizontal: AppSizer.horizontal20, vertical: AppSizer.vertical10),
          title: SvgPicture.asset(
            'assets/profileIcons/logOutIcon.svg',
            width: AppSizer.width * 0.12,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MyManropeText(
                text: 'Are you sure you want to log out?',
                fontWeight: FontWeight.w900,
                fontSize: AppSizer.fontSize16,
              ),
              SizedBox(
                height: AppSizer.height * 0.01,
              ),
              MyManropeText(
                text:
                    'Your progress will be saved, but you will need to log in again to continue.',
                color: AppColor.greyTextColor,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomeButton(
                    horizontalPadding: AppSizer.width * 0.1,
                    text: "Logout",
                    borderColor: Colors.white,
                    transparent: true,
                    colour: AppColor.logOutRed,
                    textColour: Colors.white,
                    onPressed: () {
                      Navigator.of(contextt).pop(); // Close the dialog

                      authController.logout(contextt);
                    }),
                CustomeButton(
                    horizontalPadding: AppSizer.width * 0.1,
                    colour: AppColor.greyTextColor,
                    borderColor: Colors.white,
                    text: "Cancel",
                    onPressed: () {
                      Navigator.of(contextt).pop(); // Close the dialog
                    }),
              ],
            ),

            // TextButton(
            //   child: Text('Logout'),
            //   onPressed: () {
            //     authController.logout(context); // Call logout function
            //   },
            // ),
          ],
        );
      },
    );
  }
}
