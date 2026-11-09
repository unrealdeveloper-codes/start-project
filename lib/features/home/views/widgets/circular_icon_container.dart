import 'package:desa/utils/components/image/app_cache_image.dart';
import 'package:desa/utils/components/image/custome_network_image.dart';
import 'package:desa/utils/constants/app_colors.dart';
import 'package:desa/utils/constants/app_sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CircularIconContainer extends StatelessWidget {
  final String iconPath;
  final Color backgroundColor;

  const CircularIconContainer({
    super.key,
    required this.iconPath,
    this.backgroundColor = Colors.white, // Default background color
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSizer.width * 0.12,
      height: AppSizer.width * 0.12,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColor.primaryColor1,
          width: 1.5,
        ),
      ),
      
      child: ClipRRect(
          borderRadius: BorderRadius.circular(360),
          child: CustomNetworkImage(imageUrl: iconPath,)),
    );
  }
}
