// // ignore_for_file: avoid_unnecessary_containers

import 'package:desa/features/introduction/controllers/introduction_controller.dart';
import 'package:desa/utils/components/error_display/erroe_dispaly.dart';
import 'package:desa/utils/components/warning_dispaly.dart';
import 'package:desa/utils/constants/app_colors.dart';
import 'package:desa/utils/constants/app_sizer.dart';
import 'package:desa/utils/constants/app_svg.dart';
import 'package:desa/utils/loaders/loader/animated_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class IntroductionScreen extends StatefulWidget {
  final String id;
  final String from;

  const IntroductionScreen({
    super.key,
    required this.id,
    required this.from,
  });

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  late IntroductionController controller;

  @override
  void initState() {
    controller = Get.put(IntroductionController());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchIntroduction(context, widget.id, widget.from);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      body: Scrollbar(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: height * 0.25,
              pinned: true,
              backgroundColor: AppColor.appBackgroundColor,
              systemOverlayStyle: SystemUiOverlayStyle.dark,
              flexibleSpace: FlexibleSpaceBar(
                background: SvgPicture.asset(
                  AppSvg.introductionScreenImage,
                  width: width * 0.7,
                  fit: BoxFit.cover,
                ),
              ),
              leading: Padding(
                padding: EdgeInsets.only(left: width * 0.02),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: width * 0.045,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    context.pop();
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Obx(() {
                if (controller.isLoading) {
                  return SizedBox(
                    height: height * 0.5,
                    child: const Center(
                      child: AnimatedLoading(
                        text: "Loading Introduction",
                      ),
                    ),
                  );
                } else if (controller.errorMessage.value.isNotEmpty) {
                  return ErrorDisplay(
                    boxHeight: height * 0.5,
                    errorMessage: controller.errorMessage.value,
                    onTap: () {
                      controller.fetchIntroduction(
                        context,
                        widget.id,
                        widget.from,
                      );
                    },
                  );
                } else if (controller.introduction.html == null) {
                  return WarningDisplay(boxHeight: height * 0.5);
                } else {
                  // If Data Found
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSizer.horizontal15,
                      vertical: AppSizer.vertical20,
                    ),
                    child: HtmlWidget(
                      controller.introduction.html ?? "",
                      textStyle: const TextStyle(color: Colors.black),
                    ),
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:desa/features/introduction/controllers/introduction_controller.dart';
// import 'package:desa/utils/components/background/custom_background_widget.dart';
// import 'package:desa/utils/components/error_display/erroe_dispaly.dart';
// import 'package:desa/utils/components/image/app_cache_image.dart';
// import 'package:desa/utils/components/text/app_text.dart';
// import 'package:desa/utils/components/warning_dispaly.dart';
// import 'package:desa/utils/constants/app_sizer.dart';
// import 'package:desa/utils/constants/app_svg.dart';
// import 'package:desa/utils/loaders/loader/animated_loader.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
// import 'package:get/get.dart';
// import 'package:go_router/go_router.dart';

// class IntroductionScreen extends StatefulWidget {
//   final String id;
//   final String from;

//   const IntroductionScreen({
//     super.key,
//     required this.id,
//     required this.from,
//   });

//   @override
//   State<IntroductionScreen> createState() => _IntroductionScreenState();
// }

// class _IntroductionScreenState extends State<IntroductionScreen> {
//   late IntroductionController controller;

//   @override
//   void initState() {
//     controller = Get.put(IntroductionController());
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       controller.fetchIntroduction(context, widget.id, widget.from);
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.sizeOf(context).height;
//     final width = MediaQuery.sizeOf(context).width;
//     final scrollController = ScrollController();

//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             // Fixed Image and Back Button
//             Stack(
//               children: [
//                 Align(
//                   alignment: Alignment.topCenter,
//                   child: SvgPicture.asset(
//                     AppSvg.introductionScreenImage,
//                     width: width,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 Align(
//                   alignment: Alignment.topLeft,
//                   child: Padding(
//                     padding: EdgeInsets.only(
//                       top: height * .073,
//                       left: width * 0.018,
//                     ),
//                     child: IconButton(
//                       onPressed: () {
//                         context.pop();
//                       },
//                       icon: Icon(
//                         Icons.arrow_back_ios,
//                         size: width * 0.045,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),

//             // Dynamic Content
//             Scrollbar(
//               controller: scrollController,
//               thickness: 5,
//               child: Obx(
//                 () {
//                   if (controller.isLoading) {
//                     return SizedBox(
//                       height: height * 0.5,
//                       child: const Center(
//                         child: AnimatedLoading(
//                           text: "Loading Introduction",
//                         ),
//                       ),
//                     );
//                   } else if (controller.errorMessage.value.isNotEmpty) {
//                     return ErrorDisplay(
//                       boxHeight: height * 0.5,
//                       errorMessage: controller.errorMessage.value,
//                       onTap: () {
//                         controller.fetchIntroduction(
//                           context,
//                           widget.id,
//                           widget.from,
//                         );
//                       },
//                     );
//                   } else if (controller.introduction.html == null) {
//                     return WarningDisplay(boxHeight: height * 0.5);
//                   } else {
//                     // If Data Found
//                     return Padding(
//                       padding: EdgeInsets.symmetric(
//                         horizontal: AppSizer.horizontal15,
//                         vertical: AppSizer.vertical20,
//                       ),
//                       child: HtmlWidget(
//                         controller.introduction.html ?? "",
//                         textStyle: const TextStyle(color: Colors.black),
//                       ),
//                     );
//                   }
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class IntroductionScreen extends StatefulWidget {
//   final String id;
//   final String from;
//
//   const IntroductionScreen({
//     super.key,
//     required this.id,
//     required this.from,
//   });
//
//   @override
//   State<IntroductionScreen> createState() => _IntroductionScreenState();
// }
//
// class _IntroductionScreenState extends State<IntroductionScreen> {
//   late IntroductionController controller;
//
//   @override
//   void initState() {
//     controller = Get.put(IntroductionController());
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       controller.fetchIntroduction(context, widget.id, widget.from);
//     });
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.sizeOf(context).height;
//     final width = MediaQuery.sizeOf(context).width;
//     final scrollController = ScrollController();
//     return Scaffold(
//       body: Scrollbar(
//         controller: scrollController,
//         thickness: 5,
//         child: SingleChildScrollView(
//           controller: scrollController,
//           physics: const BouncingScrollPhysics(),
//           child: Obx(
//             () {
//               if (controller.isLoading) {
//                 return SizedBox(
//                   height: height * 0.8,
//                   child: const Center(
//                     child: AnimatedLoading(
//                       text: "Loading Introduction",
//                     ),
//                   ),
//                 );
//               } else if (controller.errorMessage.value.isNotEmpty) {
//                 return ErrorDisplay(
//                   boxHeight: height * 0.8,
//                   errorMessage: controller.errorMessage.value,
//                   onTap: () {
//                     controller.fetchIntroduction(
//                       context,
//                       widget.id,
//                       widget.from,
//                     );
//                   },
//                 );
//               }
//               // ----  If No Data Found
//               else if (controller.introduction.html == null) {
//                 return WarningDisplay(boxHeight: height * 0.7);
//               }
//               // ----  If Data Found
//               else {
//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Stack(
//                       children: [
//                         Align(
//                           alignment: Alignment.topCenter,
//                           child: SvgPicture.asset(
//                             AppSvg.introductionScreenImage,
//                             width: width,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                         Align(
//                           alignment: Alignment.topLeft,
//                           child: Padding(
//                             padding: EdgeInsets.symmetric(
//                                 vertical: height * 0.02,
//                                 horizontal: AppSizer.horizontal10),
//                             child: IconButton(
//                                 onPressed: () {
//                                   context.pop();
//                                 },
//                                 icon: Icon(Icons.arrow_back_ios)),
//                           ),
//                         )
//                       ],
//                     ),
//                     if (controller.introduction.html != null &&
//                         controller.introduction.html!.isNotEmpty)
//                       // -- HTML Data render here
//                       Padding(
//                         padding: EdgeInsets.symmetric(
//                           horizontal: AppSizer.horizontal15,
//                           vertical: AppSizer.vertical20,
//                         ),
//                         child: HtmlWidget(
//                           controller.introduction.html ?? "",
//                           textStyle: const TextStyle(color: Colors.black),
//                         ),
//                       )
//                     else
//                       Padding(
//                         padding: EdgeInsets.symmetric(
//                           horizontal: AppSizer.horizontal15,
//                           vertical: AppSizer.vertical20,
//                         ),
//                         child: Center(
//                             child: MyManropeText(
//                           text: "HTML Not Found",
//                           fontSize: AppSizer.fontSize16,
//                           color: Colors.red,
//                         )),
//                       ),
//                     // if (controller.introduction.html!.isNotEmpty &&
//                     //     controller.introduction.illustrators!.length > 1)
//                     //   AppCacheImage(
//                     //     image: controller.introduction.illustrators!.last,
//                     //     isNetworkImage: true,
//                     //     width: width,
//                     //     height: height * 0.25,
//                     //     fit: BoxFit.contain,
//                     //   )
//                     // else
//                     //   SvgPicture.asset(
//                     //     AppSvg.exercise_02,
//                     //     fit: BoxFit.cover,
//                     //   ),
//                   ],
//                 );
//               }
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
