import 'package:desa/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class FitnessSessionsShimmer extends StatelessWidget {
  const FitnessSessionsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: height * 0.02),
        Shimmer.fromColors(
          baseColor: AppColor.shimmerBaseColor,
          highlightColor: AppColor.shimmerHighlightColor,
          child: Container(
            width: width * 0.8, // Placeholder for the title
            height: height * 0.05,
            color: AppColor.shimmerContentColor,
          ),
        ),
        SizedBox(height: height * 0.04),
        Expanded(
          child: ListView.builder(
            itemCount: 7,
            itemBuilder: (context, index) {
              return _buildSectionShimmer(height, width);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSectionShimmer(double height, double width) {
    return Shimmer.fromColors(
      baseColor: AppColor.shimmerBaseColor,
      highlightColor: AppColor.shimmerHighlightColor,
      //  color: AppColor.shimmerContentColor,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: height * 0.045,
        ),
        margin: EdgeInsets.only(bottom: 10.0),
        decoration: BoxDecoration(
          color: AppColor.shimmerContentColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: Offset.zero,
              blurRadius: 3.0,
            ),
          ],
        ),
      ),
    );
  }
}
