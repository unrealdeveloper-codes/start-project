import 'package:desa/utils/components/buttons/customeElevatedButton.dart';
import 'package:desa/utils/components/image/custome_network_image.dart';
import 'package:desa/utils/components/text/app_text.dart';
import 'package:desa/utils/constants/app_sizer.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/app_colors.dart';

class ConsumedMealCardWidget extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String protein;
  final String fats;
  final String carbs;
  final String calories;
  final String quantity;
  final Function() onTap; // Added onTap callback
  final Function() onTapDelete; // Added onTap callback

  const ConsumedMealCardWidget({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.protein,
    required this.fats,
    required this.carbs,
    required this.quantity,
    required this.calories,
    required this.onTap,
    required this.onTapDelete,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.03,
        vertical: height * 0.014,
      ),
      margin: EdgeInsets.symmetric(vertical: AppSizer.vertical1),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColor.black.withOpacity(0.08),
            blurRadius: 6,
          )
        ],
        borderRadius: BorderRadius.circular(width * 0.025),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(width * 0.025),
                child: Center(
                  child: CustomNetworkImage(
                    imageUrl: imageUrl,
                    height: width * 0.09,
                    width: width * 0.09,
                  ),
                ),
              ),
              SizedBox(
                width: width * 0.025,
              ),
              SizedBox(
                width: width * 0.73,
                child: MyManropeText(
                  text: title,
                  color: AppColor.primaryColor1,
                  fontWeight: FontWeight.w900,
                  fontSize: AppSizer.fontSize14,
                  maxLines: 2,
                ),
              ),
              SizedBox(width: width * 0.015),
              // SearchMealDropDown(
              //     items: const ['50 g', '100 g', '150 g', "200 g"],
              //     selectedValue: quantity,
              //     onSelected: onChange),
            ],
          ),
          SizedBox(height: height * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: width * 0.425,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildNutritionInfo(
                        context, "Calories", calories, AppColor.cardGreen),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    _buildNutritionInfo(
                        context, "Fats", fats, AppColor.cardOrange),
                  ],
                ),
              ),
              SizedBox(
                width: width * 0.425,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildNutritionInfo(
                        context, "Protein", protein, AppColor.primaryColor1),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    _buildNutritionInfo(
                        context, "Carbs", carbs, AppColor.cardYellow),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: height * 0.02),

          // Wrap(
          //   runSpacing: height * .014,
          //   children: [
          //     _buildNutritionInfo(
          //         context, "Protein", protein, AppColor.primaryColor1),
          //     SizedBox(
          //       width: width * 0.02,
          //     ),
          //     _buildNutritionInfo(context, "Fats", fats, AppColor.cardOrange),
          //     SizedBox(
          //       width: width * 0.02,
          //     ),
          //     _buildNutritionInfo(context, "Carbs", carbs, AppColor.cardYellow),
          //     SizedBox(
          //       width: width * 0.02,
          //     ),
          //     _buildNutritionInfo(
          //         context, "Calories", calories, AppColor.cardGreen),
          //   ],
          // ),
          SizedBox(
            height: height * 0.04,
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomeButton(
                  text: 'Remove Meal',
                  onPressed: onTapDelete,
                  transparent: true,
                  colour: Colors.white,
                  textColour: AppColor.logOutRed,
                  horizontalPadding: width * 0.085,
                  verticalPadding: 0,
                  borderWidth: 0.5,
                  borderColor: AppColor.greyTextColor,
                  borderRadius: width * 0.01,
                ),
                CustomeButton(
                  text: 'Edit Meal',
                  onPressed: onTap,
                  horizontalPadding: width * 0.125,
                  verticalPadding: 0,
                  borderRadius: width * 0.01,
                ),

                // InkWell(
                //   onTap: onTapDelete,
                //   child: MyManropeText(
                //     text: 'Remove Meal',
                //     color: AppColor.logOutRed,
                //     fontWeight: FontWeight.w900,
                //     fontSize: AppSizer.fontSize12,
                //     textDecoration: TextDecoration.underline,
                //     decorationColor: AppColor.logOutRed,
                //   ),
                // ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildNutritionInfo(
      BuildContext context, String label, String value, Color color) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: width * 0.012,
          height: height * .025,
          margin: const EdgeInsets.only(right: 6),
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(100),
              bottomLeft: Radius.circular(100),
            ),
          ),
        ),
        MyManropeText(
          text: "$label:",
          color: AppColor.greyTextColor,
          fontWeight: FontWeight.w800,
          fontSize: AppSizer.fontSize12,
        ),
        SizedBox(width: width * 0.01),
        Container(
          constraints: BoxConstraints(maxWidth: width * 0.45),
          child: MyManropeText(
            text: value.toString(),
            color: AppColor.greyTextColor,
            fontWeight: FontWeight.w500,
            fontSize: AppSizer.fontSize12,
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}
