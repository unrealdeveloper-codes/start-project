import 'package:desa/utils/components/image/custome_network_image.dart';
import 'package:desa/utils/components/text/app_text.dart';
import 'package:desa/utils/constants/app_sizer.dart';
import 'package:desa/utils/constants/resuable_box_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageTitleCard extends StatelessWidget {
  final String svg;
  final String heading;
  final VoidCallback onTap;
  final String? number;

  const ImageTitleCard({
    super.key,
    required this.svg,
    required this.heading,
    required this.onTap,
    this.number,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizer.horizontal15,
          vertical: AppSizer.vertical8,
        ),
        margin: EdgeInsets.symmetric(
          vertical: AppSizer.vertical2,
        ),
        decoration: ReusableDecoration.reusableBoxDecoration(context: context),
        child: Row(
          children: [
            Stack(
              children: [
                _buildImage(width),
                Positioned(
                  top: AppSizer.height * 0.006,
                  left: (number?.length ?? 0) > 1 ? width * .01 : width * .018,
                  child: MyManropeText(
                    text: number ?? "",
                    color: Colors.white,
                    fontSize: AppSizer.fontSize12,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            SizedBox(width: width * 0.04),
            SizedBox(
              width: width * 0.65,
              child: MySofiaSansText(
                text: heading,
                fontSize: AppSizer.fontSize15,
                fontWeight: FontWeight.w800,
                maxLines: 1,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios_sharp,
              size: width * 0.03,
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the image widget based on whether the input is a URL or SVG
  Widget _buildImage(double width) {
    if (Uri.tryParse(svg)?.hasAbsolutePath ?? false) {
      // If the image is a URL, use CustomNetworkImage
      return ClipRRect(
        borderRadius: BorderRadius.circular(width * 0.015),
        child: CustomNetworkImage(
          imageUrl: svg,
          height: AppSizer.height * 0.032,
          width: width * 0.05,
        ),
      );
    } else {
      // If the image is SVG, use SvgPicture.asset
      return SvgPicture.asset(
        svg,
        width: width * 0.05,
        height: AppSizer.height * 0.032,
      );
    }
  }
}

// class ImageTitleCard extends StatelessWidget {
//   final String svg;
//   final String heading;
//   final VoidCallback onTap;
//   final String? number;
//
//   const ImageTitleCard(
//       {super.key,
//       required this.svg,
//       required this.heading,
//       required this.onTap,
//       this.number});
//
//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     print(number);
//     print("}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}");
//     print(svg);
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: EdgeInsets.symmetric(
//           horizontal: AppSizer.horizontal15,
//           vertical: AppSizer.vertical8,
//         ),
//         margin: EdgeInsets.symmetric(
//           vertical: AppSizer.vertical2,
//         ),
//
//         decoration: ReusableDecoration.reusableBoxDecoration(context: context),
//
//         // decoration: BoxDecoration(
//         //   color: AppColor.white,
//         //   borderRadius: BorderRadius.circular(8),
//         //   boxShadow: [
//         //     BoxShadow(
//         //       color: AppColor.black.withOpacity(0.1),
//         //       offset: Offset.zero,
//         //       blurRadius: 3.0,
//         //       spreadRadius: 0.0,
//         //     ),
//         //   ],
//         // ),
//         child: Row(
//           children: [
//             number != null
//                 ? Container(
//                     // color: Colors.red,
//                     //     width: width*0.069,
//                     //     height: AppSizer.height*0.032,
//                     child: Stack(
//                       children: [
//                         CustomNetworkImage(
//                           imageUrl: svg,
//                           height: 100,
//                           width: 100,
//                         ),
//                         // SvgPicture.asset(
//                         //   svg,
//                         //   width: width * 0.05,
//                         //   height: AppSizer.height * 0.032,
//                         // ),
//                         Positioned(
//                           top: AppSizer.height * 0.006,
//                           left: width * .01,
//                           child: MyManropeText(
//                             text: number!,
//                             color: Colors.white,
//                             fontSize: AppSizer.fontSize12,
//                           ),
//                         ),
//                       ],
//                     ),
//                   )
//                 : CustomNetworkImage(
//                     imageUrl: svg,
//                     width: width * 0.05,
//                     height: AppSizer.height * 0.032,
//                   ),
//
//             // SvgPicture.asset(
//             //         svg,
//             //         width: width * 0.05,
//             //         height: AppSizer.height * 0.032,
//             //       ),
//             SizedBox(width: width * 0.04),
//             MySofiaSansText(
//               text: heading,
//               fontSize: AppSizer.fontSize15,
//               fontWeight: FontWeight.w800,
//             ),
//             const Spacer(),
//             Icon(
//               Icons.arrow_forward_ios_sharp,
//               size: width * 0.03,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
