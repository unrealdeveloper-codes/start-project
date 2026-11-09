import 'package:desa/features/home/views/widgets/circuler_progress_indicator_widget.dart';
import 'package:desa/utils/components/text/app_text.dart';
import 'package:desa/utils/constants/app_colors.dart';
import 'package:desa/utils/constants/app_sizer.dart';
import 'package:flutter/material.dart';

class DietSummaryContainer extends StatelessWidget {
  final String title;
  final String mainContent;
  final String subtitle;
  final double progress;
  final Color progressColor; // Single color for border, progress, and shadow

  const DietSummaryContainer({
    super.key,
    required this.title,
    required this.mainContent,
    required this.subtitle,
    required this.progress,
    this.progressColor = AppColor.cardGreen,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Container(
      width: width * 0.68,
      height: height * 0.12,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(width * 0.025),
        border: Border(
          left: BorderSide(
            color: progressColor,
            width: width * 0.015, // Thicker left border
          ),
          top: BorderSide(
            color: progressColor,
            width: width * 0.002, // Thinner top border
          ),
          right: BorderSide(
            color: progressColor,
            width: width * 0.002, // Thinner right border
          ),
          bottom: BorderSide(
            color: progressColor,
            width: width * 0.002, // Thinner bottom border
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: AppSizer.vertical5),
            child: SizedBox(
              width: width * 0.3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyManropeText(
                    text: "$title: ",
                    color: AppColor.greyTextColor,
                    fontSize: AppSizer.fontSize13,
                    maxLines: 1,
                  ),
                  MySofiaSansText(
                    text: mainContent,
                    color: AppColor.primaryColor1,
                    fontWeight: FontWeight.w800,
                    fontSize: AppSizer.fontSize26,
                    maxLines: 1,
                  ),
                  MyManropeText(
                    text: "Goals: $subtitle",
                    color: progressColor,
                    fontWeight: FontWeight.w800,
                    fontSize: AppSizer.fontSize11,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: width * 0.18,
            margin: EdgeInsets.only(top: height * 0.027),
            child: CircularProgressGauge(
              progress: progress, // Pass the progress as a decimal (0.0 to 1.0)
              backgroundColor: AppColor.greyTextColor,
              progressColor: progressColor,
              shadowColor: progressColor, // Use progressColor as shadow color
            ),
          ),
        ],
      ),
    );
  }
}

// class DietSummaryContainer extends StatelessWidget {
//   final String title;
//   final String mainContent;
//   final String subtitle;
//   final double progress;
//   final Color borderColor;
//   final Color progressColor;
//   final Color shadowColor;
//
//   const DietSummaryContainer({
//     Key? key,
//     required this.title,
//     required this.mainContent,
//     required this.subtitle,
//     required this.progress,
//     this.borderColor = AppColor.cardGreen,
//     this.progressColor = AppColor.cardGreen,
//     this.shadowColor = Colors.greenAccent,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final width = size.width;
//     final height = size.height;
//
//     return Container(
//       width: width * 0.72,
//       height: height * 0.13,
//       decoration: BoxDecoration(
//
//         borderRadius: BorderRadius.circular(width * 0.025),
//         border: Border(
//           left: BorderSide(
//             color: borderColor,
//             width: width * 0.01, // Thicker left border
//           ),
//           top: BorderSide(
//             color: borderColor,
//             width: width * 0.002, // Thinner top border
//           ),
//           right: BorderSide(
//             color: borderColor,
//             width: width * 0.002, // Thinner right border
//           ),
//           bottom: BorderSide(
//             color: borderColor,
//             width: width * 0.002, // Thinner bottom border
//           ),
//         ),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           Padding(
//             padding: EdgeInsets.symmetric(
//               vertical: AppSizer.vertical5,
//               horizontal: AppSizer.horizontal1,
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 MyManropeText(
//                   text: title,
//                   color: AppColor.greyTextColor,
//                   fontSize: AppSizer.fontSize14,
//                 ),
//                 MySofiaSansText(
//                   text: mainContent,
//                   color: AppColor.primaryColor1,
//                   fontWeight: FontWeight.w800,
//                   fontSize: AppSizer.fontSize28,
//                 ),
//                 MyManropeText(
//                   text: "Goals: ${subtitle}",
//                   color: AppColor.primaryColor2,
//                   fontWeight: FontWeight.w600,
//                   fontSize: AppSizer.fontSize11,
//                 ),
//               ],
//             ),
//           ),
//
//           Container(
//             width: width * 0.26,
//             margin: EdgeInsets.only(top: height * 0.027),
//             child: CircularProgressGauge(
//               progress: progress, // Pass the progress as a decimal (0.0 to 1.0)
//               backgroundColor: AppColor.greyTextColor,
//               progressColor: progressColor,
//               shadowColor: shadowColor,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
