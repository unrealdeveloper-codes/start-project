import 'package:desa/utils/constants/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerVideoPreviewSheet extends StatelessWidget {
  const ShimmerVideoPreviewSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Column(
      children: [
        Column(
          children: [
            SizedBox(height: height * 0.02),
            Stack(
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey[800]!,
                  highlightColor: Colors.grey[800]!,
                  child: Container(
                    height: height * 0.3,
                    width: width,
                    decoration: BoxDecoration(
                      color: AppColor.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(width * 0.03),
                    ),
                  ),
                ),
                Positioned(
                  right: 5,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: CircleAvatar(
                      radius: width * 0.04,
                      backgroundColor: AppColor.transparent,
                      child: Icon(
                        CupertinoIcons.xmark,
                        color: AppColor.white.withOpacity(0.3),
                        size: width * 0.04,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: height * 0.04),
            Shimmer.fromColors(
              baseColor: Colors.grey[800]!,
              highlightColor: Colors.grey[800]!,
              child: Container(
                height: height * 0.04,
                width: width * 0.4,
                decoration: BoxDecoration(
                  color: AppColor.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(width * 0.014),
                ),
              ),
            ),
            SizedBox(height: height * 0.03),
            Shimmer.fromColors(
              baseColor: Colors.grey[800]!,
              highlightColor: Colors.grey[800]!,
              child: Container(
                height: height * 0.055,
                width: width,
                decoration: BoxDecoration(
                  color: AppColor.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(width * 0.03),
                ),
              ),
            ),
            SizedBox(height: height * 0.03),
            Shimmer.fromColors(
              baseColor: Colors.grey[800]!,
              highlightColor: Colors.grey[800]!,
              child: Container(
                height: height * 0.02,
                width: width,
                decoration: BoxDecoration(
                  color: AppColor.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(width * 0.01),
                ),
              ),
            ),
            SizedBox(height: height * 0.016),
            Align(
              alignment: Alignment.topLeft,
              child: Shimmer.fromColors(
                baseColor: Colors.grey[800]!,
                highlightColor: Colors.grey[800]!,
                child: Container(
                  height: height * 0.02,
                  width: width * 0.7,
                  decoration: BoxDecoration(
                    color: AppColor.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(width * 0.01),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
