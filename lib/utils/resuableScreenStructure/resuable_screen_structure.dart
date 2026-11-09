// import 'package:desa/utils/components/text/app_text.dart';
// import 'package:desa/utils/constants/app_colors.dart';
// import 'package:desa/utils/constants/app_sizer.dart';
// import 'package:desa/utils/constants/app_svg.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:go_router/go_router.dart';

// class ReusableScreenStructure extends StatelessWidget {
//   final String title;
//   final String? description;
//   final Widget bodyContent;
//   final Widget? appBar;
//   final String? backgroundImage;
//   final VoidCallback? onBack;

//   const ReusableScreenStructure({
//     super.key,
//     required this.title,
//     this.description,
//     required this.bodyContent,
//     this.appBar,
//     this.backgroundImage = 'assets/backGroundImages/forgotPassword.png',
//     this.onBack,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         systemOverlayStyle: SystemUiOverlayStyle.dark,
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back_ios_new_sharp,
//             size: AppSizer.width * 0.05,
//           ),
//           onPressed: onBack ?? () => context.pop(),
//         ),
//         elevation: 0,
//       ),
//       body: Stack(
//         children: [
//           // Background Image
//           Image.asset(
//             backgroundImage!,
//             fit: BoxFit.cover,
//             width: AppSizer.width,
//             height: AppSizer.height,
//           ),

//           // Content
//           Column(
//             children: [
//               Expanded(
//                 child: SingleChildScrollView(
//                   padding:
//                       EdgeInsets.symmetric(horizontal: AppSizer.horizontal20),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(height: AppSizer.height * 0.12),
//                       // Space for AppBar
//                       MyManropeText(
//                         text: title,
//                         fontSize: AppSizer.fontSize22,
//                         fontWeight: FontWeight.w900,
//                         maxLines: 2,
//                       ),
//                       SizedBox(height: AppSizer.height * 0.01),
//                       if (description != null)
//                         MyManropeText(
//                           text: description!,
//                           color: AppColor.greyTextColor,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       if (description != null)
//                         SizedBox(height: AppSizer.height * 0.025),
//                       bodyContent,
//                       // Your scrollable content
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// ----------------------------------------------------------------------------------

import 'package:desa/utils/components/text/app_text.dart';
import 'package:desa/utils/constants/app_colors.dart';
import 'package:desa/utils/constants/app_images.dart';
import 'package:desa/utils/constants/app_sizer.dart';
import 'package:desa/utils/constants/app_svg.dart';
import 'package:desa/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class ReusableScreenStructure extends StatelessWidget {
  final String title;
  final String? description;
  final Widget bodyContent;
  final Widget? appBar;
  final String? bgSvg;
  final VoidCallback? onBack;
  final bool? isHeadingVisible;

  const ReusableScreenStructure({
    super.key,
    required this.title,
    this.description,
    required this.bodyContent,
    this.appBar,
    this.onBack,
    this.isHeadingVisible,
    this.bgSvg,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Stack(
      children: [
        if (bgSvg != null)
          SvgPicture.asset(
            bgSvg ?? "",
            fit: BoxFit.cover,
            width: AppSizer.width,
            height: AppSizer.height,
          )
        else
          // Background SVG
          Image.asset(
            "assets/backGroundImages/forgotPassword.png",
            fit: BoxFit.cover,
            width: AppSizer.width,
            height: AppSizer.height,
          ),
        Scaffold(
          backgroundColor: AppColor.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new_sharp,
                size: AppSizer.width * 0.05,
              ),
              onPressed: onBack ?? () => context.pop(),
            ),
            elevation: 0,
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSizer.horizontal20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: AppSizer.height * 0.02),
                // Space for AppBar
                Visibility(
                  visible: isHeadingVisible ?? true,
                  child: MyManropeText(
                    text: title.appCapitalize,
                    fontSize: AppSizer.fontSize22,
                    fontWeight: FontWeight.w900,
                    maxLines: 2,
                  ),
                ),
                SizedBox(height: AppSizer.height * 0.01),
                if (description != null)
                  MyManropeText(
                    text: description!,
                    color: AppColor.greyTextColor,
                    fontWeight: FontWeight.w600,
                  ),
                if (description != null)
                  SizedBox(height: AppSizer.height * 0.025),
                Expanded(
                  child: SingleChildScrollView(child: bodyContent),
                ),
                SizedBox(height: AppSizer.height * 0.025),
                // Your scrollable content
              ],
            ),
          ),
        ),
      ],
    );


  }
}

