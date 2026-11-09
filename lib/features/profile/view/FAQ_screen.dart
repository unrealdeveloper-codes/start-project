import 'package:desa/features/profile/controllers/FAQ_controller.dart';
import 'package:desa/utils/components/error_display/erroe_dispaly.dart';
import 'package:desa/utils/components/text/app_text.dart';
import 'package:desa/utils/constants/app_colors.dart';
import 'package:desa/utils/constants/app_sizer.dart';
import 'package:desa/utils/resuableScreenStructure/resuable_screen_structure.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;
    final FAQScreenController controller = Get.put(FAQScreenController());
    controller.fetchFAQs();
    return ReusableScreenStructure(
      title: 'Frequently Asked Questions',
      description: 'Quick answers to common questions.',
      bodyContent: Obx(() {
        if (controller.isLoading.value) {
          return buildShimmer(context); // Show shimmer effect while loading
        }
        if (controller.errorMessage.isNotEmpty) {
          return ErrorDisplay(
              onTap: controller.fetchFAQs,
              errorMessage: controller.errorMessage.value);
        }

        if (controller.faqData.value == null ||
            controller.faqData.value!.data!.isEmpty) {
          return ErrorDisplay(
              onTap: controller.fetchFAQs, errorMessage: "No FAQs available.");
          // return Center(child: Text('No FAQs available.'));
        }
        return ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          //  padding: EdgeInsets.symmetric(vertical: AppSizer.vertical10),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.expandedTile.length,
          itemBuilder: (context, index) {
            return Obx(
              () => FAQContainer(
                  AppSizer.width, AppSizer.height, index, controller),
            );
          },
        );
      }),
    );
  }

  Widget buildShimmer(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4, // Placeholder count for shimmer
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: height * 0.01),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[200]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: height * 0.06,
              width: width,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(AppSizer.width * 0.013),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget FAQContainer(double width, double height, int index, var controller) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 0.01),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              controller.toggleTile(index);
            },
            child: Container(
              height: controller.expandedTile[index] ? null : height * 0.06,
              width: width,
              padding: EdgeInsets.symmetric(horizontal: width * 0.015),
              decoration: BoxDecoration(
                color: AppColor.primaryColor2.withOpacity(0.05),
                borderRadius: BorderRadius.circular(width * 0.013),
                border: Border(
                  bottom: BorderSide(
                    color: AppColor.primaryColor1,
                    width: width * 0.005,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: width * 0.72,
                    child: MyManropeText(
                      text: controller.faqData.value!.data![index].question!,
                      color: AppColor.primaryColor2,
                      fontWeight: FontWeight.w900,
                      fontSize: width * 0.034,
                      maxLines: controller.expandedTile[index]
                          ? null
                          : 1, // Adjust maxLines
                    ),
                  ),
                  IconButton(
                    onPressed: null,
                    icon: controller.expandedTile[index]
                        ? Icon(
                            Icons.keyboard_arrow_up,
                            size: width * 0.05,
                          )
                        : Icon(
                            Icons.keyboard_arrow_down,
                            size: width * 0.05,
                          ),
                  )
                ],
              ),
            ),
          ),
          controller.expandedTile[index]
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.03, vertical: height * 0.01),
                      child: SizedBox(
                        width: width * 0.82,
                        child: MyManropeText(
                          text: controller.faqData.value!.data![index].answer!,
                          color: AppColor.primaryColor1,
                          textAlign: TextAlign.start,
                          fontSize: width * 0.034,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                )
              : SizedBox(),
        ],
      ),
    );
  }
}

// class FaqScreen extends StatelessWidget {
//   FaqScreen({super.key});
//
//   FAQScreenController controller = Get.put(FAQScreenController());
//
//   @override
//   Widget build(BuildContext context) {
//     controller.fetchFAQs();
//     return ReusableScreenStructure(
//       title: 'Frequently Asked Questions',
//       description: 'Quick answers to common questions.',
//       bodyContent: ListView.builder(
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(),
//         itemCount: controller.expandedTile.length,
//         itemBuilder: (context, index) {
//           return Obx(
//             () => FAQContainer(
//               AppSizer.width,
//               AppSizer.height,
//               index,
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   Widget FAQContainer(double width, double height, int index) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: height * 0.01),
//       child: Column(
//         children: [
//           Container(
//             height: height * 0.06,
//             width: width,
//             child: Center(
//                 child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Padding(
//                   padding: EdgeInsets.only(left: width * 0.02),
//                   child: SizedBox(
//                     width: width * 0.75,
//                     child: MyManropeText(
//                       text: controller.faqData.value!.data![index].question!,
//                       color: AppColor.primaryColor2,
//                       fontWeight: FontWeight.w900,
//                       fontSize: width * 0.034,
//                       maxLines: 1,
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                     onPressed: () {
//                       controller.toggleTile(index);
//                     },
//                     icon: controller.expandedTile.value[index]
//                         ? Icon(Icons.keyboard_arrow_up)
//                         : Icon(Icons.keyboard_arrow_down))
//               ],
//             )),
//             decoration: BoxDecoration(
//                 color: AppColor.primaryColor2.withOpacity(0.05),
//                 border: Border(
//                     bottom: BorderSide(
//                         color: AppColor.primaryColor1, width: width * 0.005))),
//           ),
//           controller.expandedTile.value[index]
//               ? Padding(
//                   padding: EdgeInsets.symmetric(
//                       horizontal: width * 0.03, vertical: height * 0.01),
//                   child: MyManropeText(
//                     text: controller.faqData.value!.data![index].answer!,
//                     color: AppColor.primaryColor1,
//                     textAlign: TextAlign.start,
//                     fontSize: width * 0.034,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 )
//               : SizedBox()
//         ],
//       ),
//     );
//   }
// }
