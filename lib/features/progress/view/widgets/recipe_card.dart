// import 'package:desa/utils/components/dropdown/recipe_dropdown.dart';
// import 'package:desa/utils/components/text/app_text.dart';
// import 'package:desa/utils/constants/app_colors.dart';
// import 'package:desa/utils/constants/app_sizer.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class RecipeCard extends StatefulWidget {
//   final String title;
//   final String imageUrl;
//   final String description;
//   final String protein;
//   final String fats;
//   final String carbs;
//   final String calories;

//   const RecipeCard({
//     super.key,
//     required this.title,
//     required this.imageUrl,
//     required this.description,
//     required this.protein,
//     required this.fats,
//     required this.carbs,
//     required this.calories,
//   });

//   @override
//   _RecipeCardState createState() => _RecipeCardState();
// }

// class _RecipeCardState extends State<RecipeCard> {
//   bool isExpanded = false;
//   String? selectedValue;
//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.sizeOf(context).height;
//     final width = MediaQuery.sizeOf(context).width;
//     return Container(
//       padding: EdgeInsets.symmetric(
//         horizontal: width * 0.04,
//         vertical: height * 0.014,
//       ),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: AppColor.black.withOpacity(0.08),
//             blurRadius: 6,
//           )
//         ],
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(8),
//                 child: Container(
//                   height: width * 0.11,
//                   width: width * 0.11,
//                   color: AppColor.grey,
//                 ),
//               ),
//               SizedBox(width: width * 0.03),
//               Expanded(
//                 child: MyManropeText(
//                   text: widget.title,
//                   color: AppColor.primaryColor1,
//                   fontWeight: FontWeight.w900,
//                   fontSize: AppSizer.fontSize14,
//                   maxLines: 1,
//                 ),
//               ),
//               RecipeQuantityDropDown(
//                 items: const ['50 g', '100 g', '150 g', "200 g"],
//                 selectedValue: selectedValue,
//                 onSelected: (value) {
//                   setState(() {
//                     selectedValue = value;
//                   });
//                 },
//               ),
//             ],
//           ),
//           SizedBox(height: height * 0.02),
//           SizedBox(
//             width: width * 0.8,
//             child: RichText(
//               text: TextSpan(
//                 children: [
//                   TextSpan(
//                     text: isExpanded
//                         ? widget.description
//                         : '${widget.description.substring(0, 120)}...', // Adjust for your desired cutoff length
//                     style: GoogleFonts.manrope(
//                       color: AppColor.bodyTextColor,
//                       height: width * 0.0042,
//                       fontWeight: FontWeight.w500,
//                       fontSize: AppSizer.fontSize14,
//                     ),
//                   ),
//                   WidgetSpan(
//                     child: GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           isExpanded = !isExpanded;
//                         });
//                       },
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 4.0, top: 2),
//                         child: Text(
//                           isExpanded ? " Show less" : " View more",
//                           style: GoogleFonts.manrope(
//                             color: AppColor.primaryColor1,
//                             fontWeight: FontWeight.w900,
//                             fontSize: AppSizer.fontSize13,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               maxLines: isExpanded ? 1000 : 3,
//               overflow: TextOverflow.ellipsis,
//             ),
//           ),

//           SizedBox(height: height * 0.024),
//           // -- Wrap
//           Wrap(
//             runSpacing: height * .014,
//             children: [
//               SizedBox(
//                 width: width * 0.28,
//                 child: _buildNutritionInfo(
//                     context, "Protein", widget.protein, AppColor.primaryColor1),
//               ),
//               SizedBox(
//                   width: width * 0.26,
//                   child: _buildNutritionInfo(
//                       context, "Fats", widget.fats, AppColor.fat)),
//               SizedBox(
//                 width: width * 0.26,
//                 child: _buildNutritionInfo(
//                     context, "Carbs", widget.carbs, AppColor.cabs),
//               ),
//               _buildNutritionInfo(
//                   context, "Calories", widget.calories, AppColor.calories),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildNutritionInfo(
//       BuildContext context, String label, String value, Color color) {
//     final height = MediaQuery.sizeOf(context).height;
//     final width = MediaQuery.sizeOf(context).width;
//     return Row(
//       children: [
//         Container(
//           width: width * 0.012,
//           height: height * .025,
//           margin: const EdgeInsets.only(right: 6),
//           decoration: BoxDecoration(
//             color: color,
//             borderRadius: const BorderRadius.only(
//               topLeft: Radius.circular(100),
//               bottomLeft: Radius.circular(100),
//             ),
//           ),
//         ),
//         MyManropeText(
//           text: "$label:",
//           color: AppColor.bodyTextColor,
//           fontWeight: FontWeight.w800,
//           fontSize: AppSizer.fontSize12,
//         ),
//         SizedBox(width: width * 0.01),
//         MyManropeText(
//           text: value.toString(),
//           color: AppColor.bodyTextColor,
//           fontWeight: FontWeight.w500,
//           fontSize: AppSizer.fontSize12,
//         ),
//       ],
//     );
//   }
// }
