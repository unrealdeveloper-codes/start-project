import 'package:desa/features/home/views/widgets/circular_icon_container.dart';
import 'package:desa/utils/components/text/app_text.dart';
import 'package:desa/utils/constants/app_colors.dart';
import 'package:desa/utils/constants/app_sizer.dart';
import 'package:desa/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final String iconPath;
  final String title;
  final String description;

  const InfoCard({
    super.key,
    required this.iconPath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: width * 0.022),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(width * 0.025),
        border: Border.all(
          width: 0.5,
          color: AppColor.primaryColor4,
        ),
      ),
      child: SizedBox(
        width: width * 0.001,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularIconContainer(
              iconPath: iconPath,
              backgroundColor: AppColor.cardBackGroundBlueColor,
            ),
            SizedBox(height: height * 0.01),
            SizedBox(
              width: width * 0.3,
              child: MySofiaSansText(
                text: title.appCapitalize,
                fontSize: AppSizer.fontSize15,
                fontWeight: FontWeight.w800,
                maxLines: 1,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: height * 0.001),
            SizedBox(
              width: width * 0.35,
              child: MyManropeText(
                text: description.appCapitalize,
                fontWeight: FontWeight.w600,
                color: AppColor.greyTextColor,
                fontSize: AppSizer.fontSize10,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
