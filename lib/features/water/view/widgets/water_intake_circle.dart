import 'package:desa/utils/components/text/app_text.dart';
import 'package:desa/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WaterIntakeCircle extends StatelessWidget {
  final String waterAmount;
  final bool isSelected;
  final VoidCallback onTap;

  const WaterIntakeCircle({
    super.key,
    required this.waterAmount,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final Color backgroundColor =
        isSelected ? AppColor.cardBackGroundBlueColor : Colors.white;
    final Color borderColor =
        isSelected ? AppColor.primaryColor1 : Colors.grey.withOpacity(0.5);
    final String iconPath = isSelected
        ? 'assets/homePageIcons/fillWaterDrop.svg'
        : "assets/homePageIcons/waterdrop.svg";

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width * 0.12, // Diameter of the circle
        height: width * 0.12, // Diameter of the circle
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
          border: Border.all(
            color: borderColor, // Conditional border color
            width: 1.3, // Border width
          ),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconPath,
              height: width * 0.05,
              width: width * 0.05,
              fit: BoxFit.contain,
            ),
            SizedBox(height: width * 0.006),
            MyManropeText(
              text: "$waterAmount ml",
              fontSize: width * 0.02,
            ),
          ],
        ),
      ),
    );
  }
}
