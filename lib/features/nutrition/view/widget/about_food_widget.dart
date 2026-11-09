// import 'package:desa/features/nutrition/models/about_food_model.dart';
// import 'package:desa/utils/cards/image_title_card.dart';
// import 'package:desa/utils/components/text/app_text.dart';
// import 'package:desa/utils/constants/app_sizer.dart';
// import 'package:desa/utils/resuableScreenStructure/resuable_screen_structure.dart';
// import 'package:flutter/material.dart';

// class AboutFoodWidget extends StatelessWidget {
//   final String title;
//   final List<ImageTitleCardData> items;

//   const AboutFoodWidget({
//     Key? key,
//     required this.title,
//     required this.items,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;

//     return ReusableScreenStructure(
//       title: title,
//       backgroundImage: 'assets/backGroundImages/Approved Foods.png',
//       bodyContent: ListView.builder(
//         physics: const NeverScrollableScrollPhysics(),
//         padding: EdgeInsets.zero,
//         itemCount: items.length,
//         shrinkWrap: true,
//         itemBuilder: (context, index) {
//           final item = items[index];
//           return ImageTitleCard(
//             onTap: item.onTap,
//             heading: item.heading,
//             svg: item.svg,
//             number: item.number,
//           );
//         },
//       ),
//     );
//   }
// }
