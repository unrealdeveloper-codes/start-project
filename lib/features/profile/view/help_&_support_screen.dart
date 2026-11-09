import 'package:desa/utils/cards/image_title_card.dart';
import 'package:desa/utils/components/snackbar/app_snackbar.dart';

import 'package:desa/utils/resuableScreenStructure/resuable_screen_structure.dart';
import 'package:desa/utils/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpAndSupportScreen extends StatelessWidget {
  const HelpAndSupportScreen({super.key});

  void _sendEmail() async {
    const String email = 'app@trimify.com.au';
    final String subject = Uri.encodeComponent('Help & Support Request');
    final String body = Uri.encodeComponent('Hello, I need assistance with...');
    final Uri emailUri = Uri.parse('mailto:$email?subject=$subject&body=$body');
    try {
      await launchUrl(emailUri, mode: LaunchMode.externalApplication);
    } catch (e) {
      print("Error: Could not open email client for URL: $emailUri");
      AppSnackBar.showToast(message: 'No Email Client Found');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ReusableScreenStructure(
      title: 'Help & Support',
      description:
          'Find answers, get support, and learn how to make the most of the app.',
      bodyContent: Column(
        children: [
          ImageTitleCard(
            svg: "assets/profileIcons/mail-line.svg",
            heading: "Send us an E-Mail",
            onTap: () {
              _sendEmail();
            },
          ),
          ImageTitleCard(
            svg: "assets/profileIcons/question-line.svg",
            heading: "FAQ",
            onTap: () {
              context.push(AppRoutes.FAQ_SCREEN);
            },
          ),
          ImageTitleCard(
            svg: "assets/profileIcons/file-lock-line.svg",
            heading: "Privacy Policy",
            onTap: () {
              context.push(AppRoutes.PRIVACY_POLICY_SCREEN);
            },
          ),
          ImageTitleCard(
            svg: "assets/profileIcons/file-text-line.svg",
            heading: "Terms & Conditions",
            onTap: () {
              context.push(AppRoutes.TERMS_AND_CONDITION_SCREEN);
            },
          ),
          // ImageTitleCard(
          //   svg: "assets/profileIcons/star-half-line.svg",
          //   heading: "Rate Us",
          //   onTap: () {},
          // ),
        ],
      ),
    );
  }
}
// class HelpAndSupportScreen extends StatelessWidget {
//   const HelpAndSupportScreen({super.key});
//
//   void _sendEmail(BuildContext context) async {
//     final Uri emailUri = Uri(
//       scheme: 'mailto',
//       path: 'dbtrilok@gmail.com', // Replace with your support email
//       queryParameters: {
//         'subject': 'Support Request',
//         'body': 'Dear Support Team,\n\nI need help with...',
//       },
//     );
//
//     try {
//       if (await canLaunchUrl(emailUri)) {
//         await launchUrl(emailUri);
//       } else {
//
//         _showErrorDialog(context);
//       }
//     } catch (e) {
//       print(e);
//       _showErrorDialog(context);
//     }
//   }
//   void _showErrorDialog(BuildContext context) {
//     // Display a simple error dialog
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Error'),
//         content: Text('No email client found. Please install an email app to continue.'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return ReusableScreenStructure(
//         title: 'Help & Support',
//         description:
//             'Find answers, get support, and learn how to make the most of the app.',
//         bodyContent: Column(
//           children: [
//             ImageTitleCard(
//                 svg: "assets/profileIcons/mail-line.svg",
//                 heading: "Send us an E-Mail",
//                 onTap: () {
//                   _sendEmail(context);
//                 }),
//             ImageTitleCard(
//                 svg: "assets/profileIcons/question-line.svg",
//                 heading: "FAQ",
//                 onTap: () {
//                   context.push(AppRoutes.FAQ_SCREEN);
//                 }),
//             ImageTitleCard(
//                 svg: "assets/profileIcons/file-lock-line.svg",
//                 heading: "Privacy Policy",
//                 onTap: () {
//                   context.push(AppRoutes.PRIVACY_POLICY_SCREEN);
//                 }),
//             ImageTitleCard(
//                 svg: "assets/profileIcons/file-text-line.svg",
//                 heading: "Terms & Conditions",
//                 onTap: () {
//                   context.push(AppRoutes.TERMS_AND_CONDITION_SCREEN);
//                 }),
//             ImageTitleCard(
//                 svg: "assets/profileIcons/star-half-line.svg",
//                 heading: "Rate Us",
//                 onTap: () {}),
//           ],
//         ));
//   }
// }
