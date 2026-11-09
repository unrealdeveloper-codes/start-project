import 'package:desa/utils/constants/app_colors.dart';
import 'package:desa/utils/constants/app_sizer.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class FitnessCategoryShimmer extends StatelessWidget {
  const FitnessCategoryShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizer.horizontal20,
        vertical: AppSizer.vertical8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: height * 0.26),
          Shimmer.fromColors(
            baseColor: AppColor.shimmerBaseColor,
            highlightColor: AppColor.shimmerHighlightColor,
            child: Container(
              width: width * 0.6, // Adjust width for heading shimmer
              height: height * 0.07, // Adjust height for heading shimmer
              color: AppColor.shimmerContentColor,
            ),
          ),
          SizedBox(height: height * 0.01),
          Shimmer.fromColors(
            baseColor: AppColor.shimmerBaseColor,
            highlightColor: AppColor.shimmerHighlightColor,
            child: Container(
              width: width * 0.8, // Adjust width for sub-heading shimmer
              height: height * 0.03, // Adjust height for sub-heading shimmer
              color: AppColor.shimmerContentColor,
            ),
          ),
          SizedBox(height: height * 0.05),
          _buildSectionShimmer(width, height),
          SizedBox(height: height * 0.022),
          _buildSectionShimmer(width, height),
        ],
      ),
    );
  }

  Widget _buildSectionShimmer(double width, double height) {
    return Shimmer.fromColors(
      baseColor: AppColor.shimmerBaseColor,
      highlightColor: AppColor.shimmerHighlightColor,
      child: Container(
        height: width * 0.18, // Use square for the icon
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColor.shimmerContentColor,
        ),
      ),
    );
  }
}
