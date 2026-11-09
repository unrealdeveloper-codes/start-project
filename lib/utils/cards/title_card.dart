import 'package:desa/utils/components/text/app_text.dart';
import 'package:desa/utils/constants/app_colors.dart';
import 'package:desa/utils/constants/app_sizer.dart';
import 'package:flutter/material.dart';

class TitleCard extends StatelessWidget {
  final String heading;
  final VoidCallback onTap;

  const TitleCard(
      {super.key,
        required this.heading,
        required this.onTap,
        });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizer.horizontal15,
          vertical: AppSizer.vertical8,
        ),
        margin: EdgeInsets.symmetric(
          horizontal: AppSizer.horizontal22,
          vertical: AppSizer.vertical2,
        ),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: AppColor.black.withOpacity(0.1),
              offset: Offset.zero,
              blurRadius: 3.0,
              spreadRadius: 0.0,
            ),
          ],
        ),
        child: Row(
          children: [
            MySofiaSansText(
              text: heading,
              fontSize: AppSizer.fontSize15,
              fontWeight: FontWeight.w800,
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
