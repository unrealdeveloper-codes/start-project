// import 'package:accordion/accordion.dart';
// import 'package:accordion/controllers.dart';
// import 'package:desa/utils/constants/app_colors.dart';
// import 'package:flutter/material.dart';


// /// This class defines the variables used in the [faq_screen],
// /// and is typically used to hold data that is passed between different parts of the application.
// class FaqModel {
//   /// This method is used to create the structure of the FAQ screen.
//   static Widget accordion(
//     headerStyle,
//     loremIpsum,
//     contentStyle,
//     headingText,
//     contentText,
//     verticalpadding,
//   ) {
//     return Container(
//       decoration: const BoxDecoration(
//         color: Colors.blue,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(10),
//           topRight: Radius.circular(10),
//         ),
//         border: Border(
//           bottom: BorderSide(
//             color: Colors.red,
//             width: 2,
//             style: BorderStyle.solid,
//           ),
//         ),
//       ),
//       child: Accordion(
//         disableScrolling: true,
//         paddingBetweenClosedSections: 0,
//         paddingBetweenOpenSections: 10,
//         paddingListBottom: 10,
//         paddingListHorizontal: 10,
//         paddingListTop: 0,
//         headerBorderWidth: 1,
//         headerBorderColorOpened: Colors.transparent,
//         headerBackgroundColor: AppColor.textFieldBg,
//         contentBorderRadius: 0,
//         contentVerticalPadding: 0,
//         contentHorizontalPadding: 0,
//         contentBorderWidth: 0,
//         contentBorderColor: AppColor.textFieldBg,
//         contentBackgroundColor: AppColor.textFieldBg,
//         scaleWhenAnimating: true,
//         openAndCloseAnimation: true,
//         headerPadding: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
//         sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
//         sectionClosingHapticFeedback: SectionHapticFeedback.light,
//         children: [
//           AccordionSection(
//             scrollIntoViewOfItems: ScrollIntoViewOfItems.none,
//             isOpen: false,
//             contentBorderRadius: 0,
//             headerBorderWidth: 0,
//             header: Text(headingText, style: headerStyle),
//             content: Text(contentText, style: contentStyle),
//             contentHorizontalPadding: 10,
//             contentVerticalPadding: 10,
//             contentBorderWidth: 0,
//             contentBorderColor: AppColor.textFieldBg,
//             contentBackgroundColor: AppColor.textFieldBg,
//             rightIcon: const Icon(
//               Icons.keyboard_arrow_down,
//               color: Colors.white,
//               size: 35,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
