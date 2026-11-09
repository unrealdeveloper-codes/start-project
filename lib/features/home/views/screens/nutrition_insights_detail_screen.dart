import 'package:desa/utils/constants/app_colors.dart';
import 'package:desa/utils/constants/app_sizer.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// class NutritionInsightsDetailScreen extends StatelessWidget {
//   const NutritionInsightsDetailScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final height = size.height;
//     final width = size.width;
//     return Scaffold(
//       backgroundColor: AppColor.appBackgroundColor,
//       body: SafeArea(
//         child: Stack(
//           children: [
//             SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   ClipRRect(
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(width * 0.025),
//                       topRight: Radius.circular(width * 0.025),
//                     ),
//                     child: Image.asset(
//                       'assets/tempicons/Frame 427323274.png',
//                       height: AppSizer.height * 0.3,
//                       width: AppSizer.width,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   // Padding(
//                   //   padding: EdgeInsets.symmetric(
//                   //       horizontal: AppSizer.horizontal20,
//                   //       vertical: AppSizer.vertical15),
//                   //   child: Column(
//                   //     crossAxisAlignment: CrossAxisAlignment.start,
//                   //     children: [
//                   //       MyManropeText(
//                   //         text: 'Oatmeal with Berries',
//                   //         color: AppColor.primaryColor2,
//                   //         fontSize: AppSizer.fontSize18,
//                   //       ),
//                   //       SizedBox(
//                   //         height: height * 0.01,
//                   //       ),
//                   //       MyManropeText(
//                   //         text:
//                   //         'A hearty bowl of oats topped with fresh berries and a drizzle of honey.',
//                   //         color: AppColor.greyTextColor,
//                   //         fontSize: AppSizer.fontSize12,
//                   //         fontWeight: FontWeight.w500,
//                   //       ),
//                   //       SizedBox(
//                   //         height: height * 0.01,
//                   //       ),
//                   //       Divider(),
//                   //       SizedBox(
//                   //         height: height * 0.01,
//                   //       ),
//                   //       MyManropeText(
//                   //         text: 'Nutritional Information (per serving)',
//                   //         color: AppColor.primaryColor2,
//                   //         fontSize: AppSizer.fontSize18,
//                   //       ),
//                   //       SizedBox(
//                   //         height: height * 0.015,
//                   //       ),
//                   //       GridView.builder(
//                   //         physics: const NeverScrollableScrollPhysics(),
//                   //         shrinkWrap: true,
//                   //         gridDelegate:
//                   //         SliverGridDelegateWithFixedCrossAxisCount(
//                   //           crossAxisCount: 2,
//                   //           crossAxisSpacing: width * 0.05,
//                   //           mainAxisSpacing: height * 0.02,
//                   //           childAspectRatio: width / (height * 0.135),
//                   //         ),
//                   //         itemCount: 4,
//                   //         itemBuilder: (context, index) {
//                   //           final item = gridData[
//                   //           index]; // Get the data for the current grid item
//                   //
//                   //           return Container(
//                   //             padding: EdgeInsets.symmetric(
//                   //                 horizontal: AppSizer.horizontal10),
//                   //             decoration:
//                   //             ReusableDecoration.reusableBoxDecoration(
//                   //                 context: context,
//                   //                 color: AppColor.cardBackGroundBlueColor2),
//                   //             child: Row(
//                   //               mainAxisAlignment: MainAxisAlignment.center,
//                   //               children: [
//                   //                 MyManropeText(
//                   //                   text: "${item['title']!}:",
//                   //                   // Title (e.g., Calories, Fat)
//                   //                   color: AppColor.greyTextColor,
//                   //                   fontWeight: FontWeight.w800,
//                   //                 ),
//                   //                 SizedBox(
//                   //                   width: width * 0.01,
//                   //                 ),
//                   //                 MyManropeText(
//                   //                   text: item['value']!,
//                   //                   // Value (e.g., 250 kcal, 10 g)
//                   //                   color: AppColor.greyTextColor,
//                   //                   fontWeight: FontWeight.w500,
//                   //                 ),
//                   //               ],
//                   //             ),
//                   //           );
//                   //         },
//                   //       ),
//                   //       SizedBox(
//                   //         height: height * 0.01,
//                   //       ),
//                   //       Divider(),
//                   //       SizedBox(
//                   //         height: height * 0.015,
//                   //       ),
//                   //       MyManropeText(
//                   //         text: 'Instructions:',
//                   //         color: AppColor.primaryColor2,
//                   //         fontSize: AppSizer.fontSize18,
//                   //       ),
//                   //       SizedBox(
//                   //         height: height * 0.01,
//                   //       ),
//                   //       ListView.builder(
//                   //         itemCount: 5,
//                   //         shrinkWrap: true,
//                   //         physics: NeverScrollableScrollPhysics(),
//                   //         itemBuilder: (context, index) {
//                   //           return Padding(
//                   //             padding: EdgeInsets.symmetric(
//                   //                 horizontal: AppSizer.horizontal10,
//                   //                 vertical: AppSizer.vertical1),
//                   //             child: Row(
//                   //               crossAxisAlignment: CrossAxisAlignment.start,
//                   //               children: [
//                   //                 MyManropeText(
//                   //                   text: "${(index + 1).toString()}.",
//                   //                   fontSize: AppSizer.fontSize15,
//                   //                   color: AppColor.greyTextColor,
//                   //                   fontWeight: FontWeight.w700,
//                   //                 ),
//                   //                 SizedBox(
//                   //                   width: width * 0.025,
//                   //                 ),
//                   //                 SizedBox(
//                   //                   width: width * 0.78,
//                   //                   child: MyManropeText(
//                   //                     text: recipeIngredients[index],
//                   //                     fontSize: AppSizer.fontSize15,
//                   //                     color: AppColor.greyTextColor,
//                   //                     fontWeight: FontWeight.w700,
//                   //                   ),
//                   //                 ),
//                   //               ],
//                   //             ),
//                   //           );
//                   //         },
//                   //       ),
//                   //       SizedBox(
//                   //         height: height * 0.01,
//                   //       ),
//                   //       Divider(),
//                   //       SizedBox(
//                   //         height: height * 0.015,
//                   //       ),
//                   //       MyManropeText(
//                   //         text: 'Instructions:',
//                   //         color: AppColor.primaryColor2,
//                   //         fontSize: AppSizer.fontSize18,
//                   //       ),
//                   //       SizedBox(
//                   //         height: height * 0.01,
//                   //       ),
//                   //       ListView.builder(
//                   //         itemCount: instructions.length,
//                   //         shrinkWrap: true,
//                   //         physics: NeverScrollableScrollPhysics(),
//                   //         itemBuilder: (context, index) {
//                   //           final item = instructions[index];
//                   //
//                   //           return Padding(
//                   //             padding: EdgeInsets.symmetric(
//                   //                 horizontal: AppSizer.horizontal10,
//                   //                 vertical: AppSizer.vertical1),
//                   //             child: Row(
//                   //               crossAxisAlignment: CrossAxisAlignment.start,
//                   //               mainAxisAlignment: MainAxisAlignment.start,
//                   //               children: [
//                   //                 MyManropeText(
//                   //                   text: "${(index + 1).toString()}.",
//                   //                   fontSize: AppSizer.fontSize15,
//                   //                   color: AppColor.greyTextColor,
//                   //                   fontWeight: FontWeight.w700,
//                   //                 ),
//                   //                 SizedBox(
//                   //                   width: width * 0.025,
//                   //                 ),
//                   //                 SizedBox(
//                   //                   width: width * 0.78,
//                   //                   child: Column(
//                   //                     crossAxisAlignment:
//                   //                     CrossAxisAlignment.start,
//                   //                     mainAxisAlignment:
//                   //                     MainAxisAlignment.start,
//                   //                     children: [
//                   //                       MyManropeText(
//                   //                         text: item['title']!,
//                   //                         fontSize: AppSizer.fontSize15,
//                   //                         color: AppColor.greyTextColor,
//                   //                         fontWeight: FontWeight.w700,
//                   //                       ),
//                   //                       MyManropeText(
//                   //                         text: item['description']!,
//                   //                         fontSize: AppSizer.fontSize15,
//                   //                         color: AppColor.greyTextColor,
//                   //                         fontWeight: FontWeight.w500,
//                   //                       ),
//                   //                     ],
//                   //                   ),
//                   //                 ),
//                   //               ],
//                   //             ),
//                   //           );
//                   //         },
//                   //       )
//                   //     ],
//                   //   ),
//                   // )
//                 ],
//               ),
//             ),
//             Align(
//                 alignment: Alignment.topLeft,
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(
//                       vertical: AppSizer.vertical5,
//                       horizontal: AppSizer.horizontal10),
//                   child: IconButton(
//                       onPressed: () {
//                         context.pop();
//                       },
//                       icon: Icon(
//                         Icons.arrow_back_ios,
//                         size: width * 0.05,
//                       )),
//                 ))
//           ],
//         ),
//       ),
//     );
//   }
// }
