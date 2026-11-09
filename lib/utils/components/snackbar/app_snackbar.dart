import 'package:desa/utils/components/text/app_text.dart';
import 'package:desa/utils/constants/app_sizer.dart';
import 'package:desa/utils/constants/enum.dart';
import 'package:desa/utils/helper/debouncing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

final AppDebouncer _debouncer = AppDebouncer(milliseconds: 500);

class AppSnackBar {
  static void showSnackbar({
    required BuildContext context,
    required String title,
    String message = '',
    SnackbarType type = SnackbarType.success, // Default type is success
  }) {
    final width = MediaQuery.sizeOf(context).width;

    // Determine the color and icon based on the type
    Color getColor(SnackbarType type) {
      switch (type) {
        case SnackbarType.error:
          return Colors.red;
        case SnackbarType.warning:
          return Colors.orange;
        case SnackbarType.info:
          return Colors.blue;
        default: // Success
          return Colors.green;
      }
    }

    IconData getIcon(SnackbarType type) {
      switch (type) {
        case SnackbarType.error:
          return CupertinoIcons.xmark_circle;
        case SnackbarType.warning:
          return CupertinoIcons.exclamationmark_triangle;
        case SnackbarType.info:
          return CupertinoIcons.info;
        default: // Success
          return CupertinoIcons.checkmark_circle;
      }
    }

    final snackBar = SnackBar(
      content: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Leading Colored Bar
            Container(
              width: width * 0.028,
              constraints: BoxConstraints(
                minHeight: AppSizer.height *
                    0.08, // Set your minimum height here (e.g., 50)
              ),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  topLeft: Radius.circular(16),
                ),
                color: getColor(type),
              ),
            ),
            SizedBox(width: width * 0.03),
            // Icon
            Center(
              child: Icon(
                getIcon(type),
                color: getColor(type),
              ),
            ),
            SizedBox(width: width * 0.03),
            // Title and Message
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Title
                    MyManropeText(
                      text: title,
                      fontSize: AppSizer.fontSize14,
                      fontWeight: FontWeight.w800,
                    ),
                    // Message (conditionally rendered)
                    if (message.isNotEmpty) ...[
                      const SizedBox(height: 4), // Small gap
                      MyManropeText(
                        text: message,
                        fontSize: AppSizer.fontSize12,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      duration: const Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: EdgeInsets.zero,
      elevation: 6,
    );

    _debouncer.run(() {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  static void showToast({
    String message = 'Some thing went wrong. Please try again later.',
  }) {
    _debouncer.run(() {
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey.shade900,
        textColor: Colors.white,
        fontSize: AppSizer.width * 0.03,
      );
    });
  }
}


// class AppSnackbar {
 // static customToast(BuildContext context, {required message}) {
  //   _debouncer.run(() {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         elevation: 0,
  //         content: Container(
  //           padding: const EdgeInsets.all(10.0),
  //           decoration: BoxDecoration(
  //             color: Colors.black.withOpacity(0.8),
  //             borderRadius: BorderRadius.circular(8),
  //           ),
  //           child: Center(
  //               child: MyManropeText(
  //             text: message,
  //             color: AppColor.white,
  //             fontWeight: FontWeight.w700,
  //             fontSize: AppSizer.fontSize13,
  //           )
  //               // Text(
  //               //   message,
  //               //   style: TextStyle(
  //               //     color: AppColor.white,
  //               //     fontWeight: FontWeight.w600,
  //               //     fontSize: AppSizer.fontSize13,
  //               //   ),
  //               // ),
  //               ),
  //         ),
  //         duration: const Duration(seconds: 3),
  //         backgroundColor: AppColor.transparent,
  //         behavior: SnackBarBehavior.floating,
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(10),
  //         ),
  //       ),
  //     );
  //   });
  // }

  // static customToastWithIcon({required message, required IconData icon}) {
  //   ScaffoldMessenger.of(Get.context!).showSnackBar(
  //     SnackBar(
  //       elevation: 0,
  //       content: Container(
  //         padding: const EdgeInsets.all(10.0),
  //         decoration: BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.circular(8),
  //         ),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             Icon(
  //               icon,
  //               color: AppColor.black,
  //               size: 18,
  //             ),
  //             const SizedBox(width: 10),
  //             Text(
  //               message,
  //               style: const TextStyle(
  //                 color: AppColor.black,
  //                 fontWeight: FontWeight.w500,
  //                 fontSize: 12,
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //       duration: const Duration(seconds: 3),
  //       backgroundColor: AppColor.transparent,
  //       behavior: SnackBarBehavior.floating,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(10),
  //       ),
  //     ),
  //   );
  // }

    // static void showSuccess({
  //   required BuildContext context,
  //   required String title,
  //   String message = '',
  // }) {
  //   final height = MediaQuery.sizeOf(context).height;
  //   final width = MediaQuery.sizeOf(context).width;
  //   final snackBar = SnackBar(
  //     content: Row(
  //       children: [
  //         Container(
  //           // height: height * 0.07,
  //           constraints: BoxConstraints(
  //             minWidth: width * 0.03,
  //             maxHeight: height * 0.09,
  //             minHeight: height * 0.07,
  //           ),
  //           decoration: const BoxDecoration(
  //             borderRadius: BorderRadius.only(
  //               bottomLeft: Radius.circular(16),
  //               topLeft: Radius.circular(16),
  //             ),
  //             color: Colors.green,
  //           ),
  //         ),
  //         SizedBox(width: width * 0.04),
  //         // Success Icon
  //         const Icon(
  //           Icons.check_circle, // Using a success icon
  //           color: Colors.green, // Icon color matches the UI image
  //         ),
  //         SizedBox(width: width * 0.04),
  //         // Title and Message
  //         Expanded(
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               MyManropeText(
  //                 text: title,
  //                 fontSize: AppSizer.fontSize14,
  //                 fontWeight: FontWeight.w800,
  //               ),
  //               SizedBox(height: height * 0.005),
  //               if (message.isNotEmpty)
  //                 SizedBox(
  //                   width: width * 0.7,
  //                   child: MyManropeText(
  //                     text: message,
  //                     fontSize: AppSizer.fontSize12,
  //                     fontWeight: FontWeight.w600,
  //                     maxLines: 2,
  //                     color: Colors.black54, // Subtle gray for the message
  //                   ),
  //                 ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //     backgroundColor: Colors.white,
  //     // White background
  //     duration: const Duration(seconds: 3),
  //     behavior: SnackBarBehavior.floating,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(12.0), // Rounded corners
  //     ),
  //     margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  //     padding: EdgeInsets.zero,
  //     elevation: 6, // Adds slight shadow for a clean UI
  //   );
  //   _debouncer.run(() {
  //     if (context.mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //     }
  //     // ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //   });
  // }

  // static void showError({
  //   required BuildContext context,
  //   required String title,
  //   String message = '',
  // }) {
  //   final height = MediaQuery.sizeOf(context).height;
  //   final width = MediaQuery.sizeOf(context).width;
  //   final snackBar = SnackBar(
  //     content: Row(
  //       children: [
  //         Container(
  //           // height: height * 0.07,
  //           constraints: BoxConstraints(
  //             minWidth: width * 0.03,
  //             maxHeight: height * 0.09,
  //             minHeight: height * 0.07,
  //           ),
  //           decoration: const BoxDecoration(
  //             borderRadius: BorderRadius.only(
  //               bottomLeft: Radius.circular(16),
  //               topLeft: Radius.circular(16),
  //             ),
  //             color: Colors.red,
  //           ),
  //         ),
  //         SizedBox(width: width * 0.04),
  //         // Success Icon
  //         const Icon(
  //           CupertinoIcons.xmark, // Using a success icon
  //           color: Colors.red, // Icon color matches the UI image
  //         ),
  //         SizedBox(width: width * 0.04),
  //         // Title and Message
  //         Expanded(
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               MyManropeText(
  //                 text: title,
  //                 fontSize: AppSizer.fontSize14,
  //                 fontWeight: FontWeight.w800,
  //               ),
  //               SizedBox(height: height * 0.005),
  //               if (message.isNotEmpty)
  //                 SizedBox(
  //                   width: width * 0.7,
  //                   child: MyManropeText(
  //                     text: message,
  //                     fontSize: AppSizer.fontSize12,
  //                     fontWeight: FontWeight.w600,
  //                     maxLines: 2,
  //                     color: Colors.black54, // Subtle gray for the message
  //                   ),
  //                 ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //     backgroundColor: Colors.white,
  //     // White background
  //     duration: const Duration(seconds: 3),
  //     behavior: SnackBarBehavior.floating,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(12.0), // Rounded corners
  //     ),
  //     margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  //     padding: EdgeInsets.zero,
  //     elevation: 6, // Adds slight shadow for a clean UI
  //   );
  //   _debouncer.run(() {
  //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //   });
  // }

  // static void showWarning({
  //   required BuildContext context,
  //   required String title,
  //   String message = '',
  // }) {
  //   final width = MediaQuery.sizeOf(context).width;

  //   final snackBar = SnackBar(
  //     content: IntrinsicHeight(
  //       child: Row(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           // Leading Colored Bar
  //           Container(
  //             width: width * 0.022, // Fixed width
  //             decoration: const BoxDecoration(
  //               borderRadius: BorderRadius.only(
  //                 bottomLeft: Radius.circular(16),
  //                 topLeft: Radius.circular(16),
  //               ),
  //               color: Colors.orange,
  //             ),
  //           ),
  //           SizedBox(width: width * 0.03),
  //           // Info Icon
  //           Center(
  //             child: Icon(
  //               CupertinoIcons.info, // Info icon
  //               color: Colors.orange,
  //             ),
  //           ),
  //           SizedBox(width: width * 0.03),
  //           // Title and Message
  //           Expanded(
  //             child: Padding(
  //               padding: const EdgeInsets.symmetric(vertical: 12),
  //               child: Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   // Title
  //                   MyManropeText(
  //                     text: title,
  //                     fontSize: AppSizer.fontSize14,
  //                     fontWeight: FontWeight.w800,
  //                   ),
  //                   // Message (conditionally rendered)
  //                   if (message.isNotEmpty) ...[
  //                     const SizedBox(height: 4), // Small gap
  //                     MyManropeText(
  //                       text: message,
  //                       fontSize: AppSizer.fontSize12,
  //                       fontWeight: FontWeight.w600,
  //                       color: Colors.black54, // Subtle gray for the message
  //                     ),
  //                   ],
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //     backgroundColor: Colors.white,
  //     duration: const Duration(seconds: 3),
  //     behavior: SnackBarBehavior.floating,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(12.0), // Rounded corners
  //     ),
  //     margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  //     padding: EdgeInsets.zero,
  //     elevation: 6, // Shadow for depth
  //   );

  //   _debouncer.run(() {
  //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //   });
  // }
// }