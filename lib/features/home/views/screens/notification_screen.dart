import 'package:desa/features/home/controllers/notification_controller.dart';
import 'package:desa/features/home/model/notificationModel.dart';
import 'package:desa/utils/components/appbar/transparent_appBar.dart';
import 'package:desa/utils/components/error_display/erroe_dispaly.dart';
import 'package:desa/utils/components/text/app_text.dart';
import 'package:desa/utils/constants/app_colors.dart';
import 'package:desa/utils/constants/app_sizer.dart';
import 'package:desa/utils/constants/resuable_box_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  final NotificationControllerHome notificationController =
      Get.put(NotificationControllerHome());

  @override
  Widget build(BuildContext context) {
    notificationController.featchNotification();
    double height = AppSizer.height;

    return Scaffold(
      appBar: const TransparentAppBar(),
      body: RefreshIndicator(
        color: AppColor.primaryColor1,
        onRefresh: () async {
          await notificationController.featchNotification();
        },
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: AppSizer.vertical6,
            horizontal: AppSizer.horizontal15,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  MySofiaSansText(
                    text: "Notifications",
                    fontSize: AppSizer.fontSize30,
                    fontWeight: FontWeight.w800,
                  ),
                ],
              ),
              SizedBox(height: height * 0.01),
              Expanded(
                child: Obx(() {
                  if (notificationController.isLoading.value) {
                    // Shimmer Effect for Loading
                    return _buildShimmer();
                  } else if (notificationController.errorMessage.isNotEmpty) {
                    // Error State
                    return _buildError(
                        notificationController.errorMessage.value);
                  } else if (notificationController.notificationData.value ==
                          null ||
                      notificationController
                          .notificationData.value!.data!.isEmpty) {
                    // No Notification State
                    return _buildNoNotifications(height);
                  } else {
                    // Notification List with Pull-to-Refresh
                    return _buildNotificationList(
                        notificationController.notificationData.value!.data!);
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShimmer() {
    return ListView.builder(
      itemCount: 5,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: AppSizer.height * 0.009),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: AppSizer.height * 0.09,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildError(String errorMessage) {
    return ErrorDisplay(
      onTap: () {
        notificationController.featchNotification();
      },
      errorMessage: errorMessage,
    );
  }

  Widget _buildNoNotifications(double height) {
    return SizedBox(
      height: height * 0.6,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/homePageIcons/ChatIcon.svg',
            width: AppSizer.width * 0.15,
          ),
          SizedBox(height: AppSizer.height * 0.005),
          MyManropeText(
            text: 'No Notifications',
            fontWeight: FontWeight.w800,
            fontSize: AppSizer.fontSize20,
          ),
          SizedBox(height: AppSizer.height * 0.01),
          SizedBox(
            width: AppSizer.width * 0.6,
            child: MyManropeText(
              text:
                  'We’ll let you know when there will be something to update you.',
              textAlign: TextAlign.center,
              fontSize: AppSizer.fontSize12,
              fontWeight: FontWeight.w600,
              color: AppColor.greyTextColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationList(List<Data> notifications) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final notification = notifications[index];
        return Container(
          margin: EdgeInsets.symmetric(vertical: AppSizer.height * 0.0085),
          decoration:
              ReusableDecoration.reusableBoxDecoration(context: context),
          child: ListTile(
            title: MyManropeText(
              text: notification.title ?? 'No Title',
              fontWeight: FontWeight.w700,
              fontSize: AppSizer.fontSize14,
            ),
            subtitle: MyManropeText(
              text: notification.message ?? 'No Message',
              color: AppColor.greyTextColor,
              fontSize: AppSizer.fontSize12,
              fontWeight: FontWeight.w500,
              maxLines: 500,
            ),
            trailing: MyManropeText(
              text: notification.time ?? '',
              color: AppColor.greyTextColor,
              fontSize: AppSizer.fontSize11,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      },
    );
  }
}

// class NotificationScreen extends StatelessWidget {
//   NotificationScreen({super.key});
//
//   NotificationController notificationController =
//       Get.put(NotificationController());
//
//   @override
//   Widget build(BuildContext context) {
//     notificationController.featchNotification();
//     double height = AppSizer.height;
//     return Scaffold(
//       appBar: const TransparentAppBar(),
//       body: Padding(
//         padding: EdgeInsets.symmetric(
//           vertical: AppSizer.vertical6,
//           horizontal: AppSizer.horizontal15,
//         ),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 MySofiaSansText(
//                   text: "Notifications",
//                   fontSize: AppSizer.fontSize30,
//                   fontWeight: FontWeight.w800,
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: height * 0.01,
//             ),
//             Obx(() {
//               if (notificationController.isLoading.value) {
//                 // Shimmer Effect for Loading
//                 return _buildShimmer();
//               } else if (notificationController.errorMessage.isNotEmpty) {
//                 // Error State
//                 return _buildError(notificationController.errorMessage.value);
//               } else if (notificationController.notificationData.value ==
//                       null ||
//                   notificationController
//                       .notificationData.value!.data!.isEmpty) {
//                 // No Notification State
//                 return _buildNoNotifications(height);
//               } else {
//                 // Notification List
//                 return _buildNotificationList(
//                     notificationController.notificationData.value!.data!);
//               }
//             }),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildShimmer() {
//     return ListView.builder(
//       itemCount: 5,
//       shrinkWrap: true,
//       itemBuilder: (context, index) {
//         return Padding(
//           padding: EdgeInsets.symmetric(vertical: AppSizer.height * 0.009),
//           child: Shimmer.fromColors(
//             baseColor: Colors.grey[300]!,
//             highlightColor: Colors.grey[100]!,
//             child: Container(
//               height: AppSizer.height * 0.09,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(8),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _buildError(
//     String errorMessage,
//   ) {
//     return ErrorDisplay(
//         onTap: () {
//           notificationController.featchNotification();
//         },
//         errorMessage: errorMessage);
//   }
//
//   Widget _buildNoNotifications(double height) {
//     return SizedBox(
//       height: height * 0.6,
//       child: Column(
//         // mainAxisSize: MainAxisSize.max,
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           SvgPicture.asset(
//             'assets/homePageIcons/ChatIcon.svg',
//             width: AppSizer.width * 0.15,
//           ),
//           SizedBox(height: AppSizer.height * 0.005),
//           MyManropeText(
//             text: 'No Notifications',
//             fontWeight: FontWeight.w800,
//             fontSize: AppSizer.fontSize20,
//           ),
//           SizedBox(height: AppSizer.height * 0.01),
//           SizedBox(
//             width: AppSizer.width * 0.6,
//             child: MyManropeText(
//               text:
//                   'We’ll let you know when there will be something to update you.',
//               textAlign: TextAlign.center,
//               fontSize: AppSizer.fontSize12,
//               fontWeight: FontWeight.w600,
//               color: AppColor.greyTextColor,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildNotificationList(List<Data> notifications) {
//     return Expanded(
//       child: ListView.builder(
//         shrinkWrap: true,
//         itemCount: notifications.length,
//         itemBuilder: (context, index) {
//           final notification = notifications[index];
//           return Card(
//             color: AppColor.cardBackGroundBlueColor,
//             elevation: 0.5,
//             child: ListTile(
//               title: MyManropeText(
//                 text: notification.title ?? 'No Title',
//                 fontWeight: FontWeight.w700,
//                 fontSize: AppSizer.fontSize14,
//               ),
//               //
//               // title: Text(
//               //   notification.title ?? 'No Title',
//               //   style: TextStyle(fontWeight: FontWeight.bold),
//               // ),
//               subtitle: MyManropeText(
//                 text: notification.message ?? 'No Message',
//                 color: AppColor.greyTextColor,
//                 fontSize: AppSizer.fontSize12,
//                 fontWeight: FontWeight.w500,
//                 maxLines: 500,
//               ),
//               // subtitle: Text(notification.message ?? 'No Message'),
//
//               trailing: MyManropeText(
//                 text: notification.time ?? '',
//                 color: AppColor.greyTextColor,
//                 fontSize: AppSizer.fontSize11,
//                 fontWeight: FontWeight.w500,
//               ),
//               // trailing: Text(
//               //   notification.time ?? '',
//               //   style: TextStyle(color: Colors.grey),
//               // ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// class NotificationScreen extends StatelessWidget {
//   const NotificationScreen({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const TransparentAppBar(),
//       body: Padding(
//         padding: EdgeInsets.symmetric(
//             vertical: AppSizer.vertical6, horizontal: AppSizer.horizontal15),
//         child: Column(
//           mainAxisSize: MainAxisSize.max,
//           // mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Row(
//               children: [
//                 MySofiaSansText(
//                   text: "Notifications",
//                   fontSize: AppSizer.fontSize30,
//                   fontWeight: FontWeight.w800,
//                 ),
//               ],
//             ),
//             Expanded(
//               child: Column(
//                 mainAxisSize: MainAxisSize.max,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   SvgPicture.asset(
//                     'assets/homePageIcons/ChatIcon.svg',
//                     width: AppSizer.width * 0.15,
//                   ),
//                   SizedBox(
//                     height: AppSizer.height * 0.005,
//                   ),
//                   MyManropeText(
//                     text: 'No Notifications',
//                     fontWeight: FontWeight.w800,
//                     fontSize: AppSizer.fontSize20,
//                   ),
//                   SizedBox(
//                     height: AppSizer.height * 0.01,
//                   ),
//                   SizedBox(
//                       width: AppSizer.width * 0.6,
//                       child: MyManropeText(
//                         text:
//                             'We’ll let you know when there will be something to update you.',
//                         textAlign: TextAlign.center,
//                         fontSize: AppSizer.fontSize12,
//                         fontWeight: FontWeight.w600,
//                         color: AppColor.greyTextColor,
//                       )),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
