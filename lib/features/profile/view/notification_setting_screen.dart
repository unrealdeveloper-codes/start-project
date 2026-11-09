import 'package:desa/features/authentication/controllers/auth_controller.dart';
import 'package:desa/features/profile/controllers/notification_controller.dart';
import 'package:desa/utils/components/text/app_text.dart';
import 'package:desa/utils/constants/app_colors.dart';
import 'package:desa/utils/constants/app_sizer.dart';
import 'package:desa/utils/resuableScreenStructure/resuable_screen_structure.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationSettingScreen extends StatelessWidget {
  const NotificationSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Bind the NotificationController
    final notificationController = Get.put(NotificationController(context));

    return ReusableScreenStructure(
      title: 'Notification Settings',
      description:
          'Customise your alerts to stay on track with your fitness goals.',
      bodyContent: Obx(
        () => Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MyManropeText(
                  text: 'Push Notifications',
                  fontSize: AppSizer.width * 0.04,
                ),
                Switch(
                  value: notificationController.isNotificationOn,
                  activeColor: AppColor.primaryColor1,
                  onChanged: (_) {
                    notificationController.toogleNotification(context);
                  },
                ),
              ],
            ),
            // Error message display
            if (notificationController.errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  notificationController.errorMessage,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: AppSizer.width * 0.035,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}








// import 'package:desa/utils/components/text/app_text.dart';
// import 'package:desa/utils/constants/app_colors.dart';
// import 'package:desa/utils/constants/app_sizer.dart';
// import 'package:desa/utils/resuableScreenStructure/resuable_screen_structure.dart';
// import 'package:flutter/material.dart';

// class NotificationSettingScreen extends StatelessWidget {
//   const NotificationSettingScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ReusableScreenStructure(
//       title: 'Notification Settings',
//       description:
//           'Customise your alerts to stay on track with your fitness goals.',
//       bodyContent: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               MyManropeText(
//                 text: 'Push Notifications',
//                 fontSize: AppSizer.width * 0.04,
//               ),
//               Switch(
//                 value: true,
//                 activeColor: AppColor.primaryColor1,
//                 onChanged: (value) {},
//               )
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
