import 'package:desa/utils/components/text/app_text.dart';
import 'package:desa/utils/constants/app_colors.dart';
import 'package:desa/utils/constants/app_sizer.dart';
import 'package:desa/utils/constants/resuable_box_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageTitleSubtitleCard extends StatelessWidget {
  final String? svg;
  final String heading;
  final String subHeading;
  final VoidCallback onTap;

  const ImageTitleSubtitleCard({
    super.key,
    this.svg,
    required this.heading,
    required this.subHeading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizer.horizontal15,
          vertical: AppSizer.vertical6,
        ),
        margin: EdgeInsets.symmetric(vertical: AppSizer.vertical5),
        //  decoration: ReusableDecoration.reusableBoxDecoration(context: context),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: AppColor.black.withOpacity(0.1),
              offset: Offset.zero,
              blurRadius: 4.0,
              spreadRadius: 0.5,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (svg != null)
              SvgPicture.asset(
                svg!,
                width: width * 0.08,
                height: height * 0.04,
              ),
            if (svg != null) SizedBox(width: width * 0.04),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: width * 0.65,
                  child: MySofiaSansText(
                    text: heading,
                    fontSize: AppSizer.fontSize14,
                    fontWeight: FontWeight.w900,
                    maxLines: 2,
                  ),
                ),
                SizedBox(height: height * 0.0025),
                svg == null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            'assets/nutritionIcons/fire-line.svg',
                            height: height * 0.02,
                            width: width * 0.02,
                          ),
                          SizedBox(
                            width: width * 0.005,
                          ),
                          SizedBox(
                            width: width * 0.72,
                            child: MyManropeText(
                              text: subHeading,
                              color: AppColor.greyTextColor,
                              height: width * 0.004,
                              fontWeight: FontWeight.w700,
                              fontSize: AppSizer.fontSize10,
                              maxLines: 2,
                            ),
                          ),
                        ],
                      )
                    : SizedBox(
                        width: width * 0.6,
                        child: MyManropeText(
                          text: subHeading,
                          color: AppColor.greyTextColor,
                          height: width * 0.004,
                          fontWeight: FontWeight.w700,
                          fontSize: AppSizer.fontSize10,
                          maxLines: 2,
                        ),
                      ),
              ],
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
}
