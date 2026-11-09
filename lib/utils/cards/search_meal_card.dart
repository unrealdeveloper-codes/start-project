import 'package:desa/features/nutrition/controller/food_recieps_detail_controller.dart';
import 'package:desa/utils/components/buttons/customeElevatedButton.dart';
import 'package:desa/utils/components/customeBottomSheet/custome_bottom_sheet.dart';
import 'package:desa/utils/components/expandableTextWidget/expandableTextWidget.dart';
import 'package:desa/utils/components/image/custome_network_image.dart';
import 'package:desa/utils/components/text/app_text.dart';
import 'package:desa/utils/constants/app_colors.dart';
import 'package:desa/utils/constants/app_sizer.dart';
import 'package:desa/utils/customeDropDown/search_meal_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchMealCard extends StatefulWidget {
  final String title;
  final String imageUrl;
  final String description;
  final String protein;
  final String fats;
  final String carbs;
  final String calories;
  final String? selectedValue;
  final ScrollController? controller;

  // final Function(String selectedValue) onMealTypeChange; // Added onTap callback
  // final Function(String selectedValue) onQuantityChange; // Added onTap callback
  // final Function(int selectedValue) onServingChange; // Added onTap callback
  final Function() onTap; // Added onTap callback
  final Function() addMeal; // Added onTap callback

  const SearchMealCard(
      {super.key,
      required this.title,
      required this.imageUrl,
      required this.description,
      required this.protein,
      required this.fats,
      required this.carbs,
      required this.calories,
      // required this.onMealTypeChange, // Make onTap optional
      // required this.onQuantityChange, // Make onTap optional
      // required this.onServingChange, // Make onTap optional
      this.controller,
      this.selectedValue, // Make onTap optional
      required this.onTap,
      required this.addMeal});

  @override
  _SearchMealCardState createState() => _SearchMealCardState();
}

class _SearchMealCardState extends State<SearchMealCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    String selectedValue = widget.selectedValue ?? '';

    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.04,
        vertical: height * 0.014,
      ),
      margin: EdgeInsets.symmetric(vertical: AppSizer.vertical2),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColor.black.withOpacity(0.08),
            blurRadius: 6,
          )
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: widget.onTap,
            //   onTap: widget.onTap != null ? widget.onTap : null,
            child: Container(
              height: height * 0.04,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(width * 0.025),
                        child: Center(
                          child: CustomNetworkImage(
                            imageUrl: widget.imageUrl,
                            height: width * 0.09,
                            width: width * 0.09,
                          ),
                        ),
                      ),
                      SizedBox(width: width * 0.03),
                      Container(
                        width: width * 0.35,
                        child: MyManropeText(
                          text: widget.title,
                          color: AppColor.primaryColor1,
                          fontWeight: FontWeight.w900,
                          fontSize: AppSizer.fontSize13,
                          maxLines: 2,
                        ),
                      ),
                      // SizedBox(width: width * 0.015),
                      if (widget.onTap != null)
                        SvgPicture.asset(
                          'assets/nutritionIcons/open_reciep_Icon.svg',
                          width: width * 0.032,
                        ),
                    ],
                  ),

                  CustomeButton(
                    text: "Add Meal",
                    textSize: AppSizer.fontSize12,
                    onPressed: widget.addMeal,
                    horizontalPadding: width * 0.05,
                    verticalPadding: 0,
                  )
                  // SearchMealDropDown(
                  //   items: const ['50 g', '100 g', '150 g', "200 g"],
                  //   selectedValue: selectedValue,
                  //   onSelected: (value) {
                  //     setState(() {
                  //       selectedValue = value;
                  //       widget.onChange(value);
                  //     });
                  //   },
                  // )
                ],
              ),
            ),
          ),
          if (widget.description != "") ...[
            SizedBox(height: height * 0.02),
            ExpandableText(description: widget.description),
          ],
          SizedBox(height: height * 0.02),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: width * 0.41,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildNutritionInfo(context, "Calories", widget.calories,
                        AppColor.cardGreen),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    _buildNutritionInfo(
                        context, "Fats", widget.fats, AppColor.cardOrange),
                  ],
                ),
              ),
              SizedBox(
                width: width * 0.41,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildNutritionInfo(context, "Protein", widget.protein,
                        AppColor.primaryColor1),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    _buildNutritionInfo(
                        context, "Carbs", widget.carbs, AppColor.cardYellow),
                  ],
                ),
              ),
            ],
          ),

          // Wrap(
          //   runSpacing: height * .014,
          //   children: [
          //     _buildNutritionInfo(
          //         context, "Protein", widget.protein, AppColor.primaryColor1),
          //     SizedBox(
          //       width: width * 0.02,
          //     ),
          //     _buildNutritionInfo(
          //         context, "Fats", widget.fats, AppColor.cardOrange),
          //     SizedBox(
          //       width: width * 0.02,
          //     ),
          //     _buildNutritionInfo(
          //         context, "Carbs", widget.carbs, AppColor.cardYellow),
          //     SizedBox(
          //       width: width * 0.02,
          //     ),
          //     _buildNutritionInfo(
          //         context, "Calories", widget.calories, AppColor.cardGreen),
          //   ],
          // ),
          // -- Wrap
          // Wrap(
          //   runSpacing: height * .014,
          //   children: [
          //     SizedBox(
          //       width: width * 0.28,
          //       child: _buildNutritionInfo(
          //           context, "Protein", widget.protein, AppColor.primaryColor1),
          //     ),
          //     SizedBox(
          //         width: width * 0.26,
          //         child: _buildNutritionInfo(
          //             context, "Fats", widget.fats, AppColor.cardOrange)),
          //     SizedBox(
          //       width: width * 0.26,
          //       child: _buildNutritionInfo(
          //           context, "Carbs", widget.carbs, AppColor.cardYellow),
          //     ),
          //     _buildNutritionInfo(
          //         context, "Calories", widget.calories, AppColor.cardGreen),
          //   ],
          // ),
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

  void showAddMealBottomSheet(
    BuildContext context,
  ) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return AddMealBottomSheet(
          mealTypes: ['Breakfast', 'Lunch', 'Dinner', 'Snack'],
          quantities: ['1', '2', '3', '4'],
          initialServings: 1,
          onMealTypeSelected: (selectedMeal) {
            print('Selected Meal: $selectedMeal');
          },
          onQuantitySelected: (selectedQuantity) {
            print('Selected Quantity: $selectedQuantity');
          },
          onServingsChanged: (newServings) {
            print('Number of Servings: $newServings');
          },
          onTap: () {},
        );
      },
    );

// Widget _buildNutritionInfo(
//     BuildContext context, String label, String value, Color color) {
//   final height = MediaQuery.sizeOf(context).height;
//   final width = MediaQuery.sizeOf(context).width;
//   return Row(
//     children: [
//       Container(
//         width: width * 0.012,
//         height: height * .025,
//         margin: const EdgeInsets.only(right: 6),
//         decoration: BoxDecoration(
//           color: color,
//           borderRadius: const BorderRadius.only(
//             topLeft: Radius.circular(100),
//             bottomLeft: Radius.circular(100),
//           ),
//         ),
//       ),
//       MyManropeText(
//         text: "$label:",
//         color: AppColor.greyTextColor,
//         fontWeight: FontWeight.w800,
//         fontSize: AppSizer.fontSize12,
//       ),
//       SizedBox(width: width * 0.01),
//       MyManropeText(
//         text: value.toString(),
//         color: AppColor.greyTextColor,
//         fontWeight: FontWeight.w500,
//         fontSize: AppSizer.fontSize12,
//       ),
//     ],
//   );
// }
  }
}
