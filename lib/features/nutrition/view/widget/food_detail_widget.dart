import 'package:desa/features/nutrition/models/food_detail_model.dart';
import 'package:desa/utils/components/appbar/transparent_appBar.dart';
import 'package:desa/utils/components/expandableTextWidget/expandableTextWidget.dart';
import 'package:desa/utils/components/text/app_text.dart';
import 'package:desa/utils/constants/app_colors.dart';
import 'package:desa/utils/constants/app_sizer.dart';
import 'package:flutter/material.dart';

class FoodDetailWidget extends StatelessWidget {
  final String title;
  final String description;
  final List<Chart> listOfFood;
  final bool isApproved; // Determines if the table shows both columns
  const FoodDetailWidget({
    super.key,
    required this.title,
    required this.description,
    required this.listOfFood,
    this.isApproved = true,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title and Description
          MyManropeText(
            text: title,
            fontSize: AppSizer.fontSize22,
            fontWeight: FontWeight.w900,
            maxLines: 2,
          ),
          // SizedBox(height: height * 0.005),
          // ExpandableText(description: description),
          SizedBox(height: height * 0.03),
          Table(
            border: TableBorder(
              top: const BorderSide(color: AppColor.primaryColor1, width: 1.5),
              bottom:
                  const BorderSide(color: AppColor.primaryColor1, width: 1.5),
              left: const BorderSide(color: AppColor.primaryColor1, width: 1.5),
              right:
                  const BorderSide(color: AppColor.primaryColor1, width: 1.5),
              horizontalInside: BorderSide(
                color: AppColor.primaryColor1.withOpacity(0.9),
                width: 1.5,
              ),
              verticalInside: BorderSide(
                color: AppColor.primaryColor1.withOpacity(0.9),
                width: 1.5,
              ),
            ),
            columnWidths: {
              0: const FlexColumnWidth(2),
              if (isApproved) 1: const FlexColumnWidth(1),
              // Add column width only if approved
            },
            children: [
              // Header Row
              TableRow(
                decoration: const BoxDecoration(color: AppColor.primaryColor1),
                children: [
                  Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: AppSizer.vertical2,
                        horizontal: AppSizer.horizontal20,
                      ),
                      child: MySofiaSansText(
                        text: 'Name',
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: AppSizer.fontSize14,
                      )),
                  if (isApproved)
                    Center(
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: AppSizer.vertical2),
                        child: MySofiaSansText(
                          text: 'Quantity',
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: AppSizer.fontSize14,
                        ),
                      ),
                    ),
                ],
              ),
              // Data Rows
              ...listOfFood.map((food) {
                return TableRow(
                  decoration: BoxDecoration(
                    color: AppColor.primaryColor4.withOpacity(0.6),
                  ),
                  children: [
                    Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: AppSizer.vertical6,
                            horizontal: AppSizer.horizontal20),
                        child: MyManropeText(
                          text: food.foodName ?? "Null",
                          color: AppColor.primaryColor5,
                          fontSize: AppSizer.fontSize12,
                          maxLines: 100,
                        )

                        // child: isApproved
                        //     ? Center(
                        //         child: MyManropeText(
                        //           text: food.foodName ?? "Null",
                        //           color: AppColor.primaryColor5,
                        //           fontSize: AppSizer.fontSize12,
                        //         ),
                        //       )
                        //     : Align(
                        //         alignment: Alignment.centerLeft,
                        //         child: MyManropeText(
                        //           text: food.quantity ?? "0",
                        //           color: AppColor.primaryColor5,
                        //           fontSize: AppSizer.fontSize12,
                        //         ),
                        //       ),
                        ),
                    if (isApproved)
                      Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: AppSizer.vertical6),
                          child: MyManropeText(
                            text: food.quantity ?? '',
                            color: AppColor.primaryColor5,
                            fontSize: AppSizer.fontSize12,
                          ),
                        ),
                      ),
                  ],
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}
