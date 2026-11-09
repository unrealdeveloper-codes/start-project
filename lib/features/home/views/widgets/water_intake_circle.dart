import 'package:desa/utils/components/text/app_text.dart';
import 'package:desa/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WaterIntakeCircle extends StatelessWidget {
  final String waterAmount; // Text for the water amount (e.g., '100 ml')
  final bool isSelected; // Determines if the icon is filled or not

  const WaterIntakeCircle({
    super.key,
    required this.waterAmount,
    required this.isSelected,
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
        : 'assets/homePageIcons/waterdrop.svg';
    final Color textColor = isSelected ? Colors.blueAccent : Colors.grey;

    return Container(
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
            height: width * 0.05, // Adjust proportionally for the icon size
            width: width * 0.05, // Ensures the icon has a square aspect
            fit: BoxFit
                .contain, // Keeps SVG within bounds and scales proportionally
          ),
          MyManropeText(
            text: waterAmount,
            fontSize: width * 0.02,
          ),
        ],
      ),
    );
  }
}
