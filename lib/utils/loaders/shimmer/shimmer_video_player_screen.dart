import 'package:desa/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerVideoPlayerScreen extends StatelessWidget {
  const ShimmerVideoPlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AspectRatio(
          aspectRatio: 16 / 9,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: AppColor.black,
            ),
            child:
                Center(child: CircularProgressIndicator(color: AppColor.white)),
          ),
        ),
        SizedBox(height: height * 0.02),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey[800]!,
                highlightColor: Colors.grey[800]!,
                child: Container(
                  height: height * 0.025,
                  width: width * 0.34,
                  decoration: BoxDecoration(
                    color: AppColor.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(width * 0.01),
                  ),
                ),
              ),
              SizedBox(height: height * 0.01),
              Shimmer.fromColors(
                baseColor: Colors.grey[800]!,
                highlightColor: Colors.grey[800]!,
                child: Container(
                  height: height * 0.025,
                  width: width * 0.8,
                  decoration: BoxDecoration(
                    color: AppColor.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(width * 0.01),
                  ),
                ),
              ),
              SizedBox(height: height * 0.03),
              Shimmer.fromColors(
                baseColor: Colors.grey[800]!,
                highlightColor: Colors.grey[800]!,
                child: Container(
                  height: height * 0.025,
                  width: width * 0.34,
                  decoration: BoxDecoration(
                    color: AppColor.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(width * 0.01),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
