import 'package:desa/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class FitnessCategoriesShimmerCard extends StatelessWidget {
  const FitnessCategoriesShimmerCard({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    return Shimmer.fromColors(
      baseColor: AppColor.shimmerBaseColor,
      highlightColor: AppColor.shimmerHighlightColor,
      //  color: AppColor.shimmerContentColor,
      child: Container(
        width: double.infinity,
        height: height * 0.22,
        padding: const EdgeInsets.all(15.0),
        margin: EdgeInsets.only(bottom: height * 0.02),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColor.shimmerContentColor,
        ),
      ),
    );
  }
}
