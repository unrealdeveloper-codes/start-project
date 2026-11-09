import 'package:desa/features/home/views/widgets/circular_icon_container.dart';
import 'package:desa/utils/components/text/app_text.dart';
import 'package:desa/utils/constants/app_colors.dart';
import 'package:desa/utils/constants/app_sizer.dart';
import 'package:flutter/material.dart';
class CustomListTile extends StatelessWidget {
  final String iconPath;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  const CustomListTile({
    super.key,
    required this.iconPath,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    return Material(
      color: AppColor.transparent,
      child: InkWell(
        onTap: onTap,
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: width * 0.014),
          leading: CircularIconContainer(
            iconPath: iconPath,
          ),
          title: MySofiaSansText(
            text: title,
            color: AppColor.primaryColor2,
            fontSize: AppSizer.fontSize15,
            fontWeight: FontWeight.w800,
            maxLines: 1,
          ),
          subtitle: MyManropeText(
            text: subtitle,
            color: AppColor.greyTextColor,
            fontSize: AppSizer.fontSize11,
            maxLines: 2,
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: width * 0.035,
          ),
        ),
      ),
    );
  }
}
class ActionListTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final double iconSize;
  const ActionListTile({
    super.key,
    required this.title,
    required this.onTap,
    this.iconSize = 16.0,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: MySofiaSansText(
          text: title,
          color: AppColor.primaryColor1,
          fontSize: AppSizer.fontSize13,
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: iconSize,
        ),
      ),
    );
  }
}