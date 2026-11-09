import 'package:desa/features/nutrition/view/widget/day_diet_card.dart';
import 'package:desa/utils/components/appbar/transparent_appBar.dart';
import 'package:desa/utils/components/text/app_text.dart';
import 'package:desa/utils/constants/app_colors.dart';
import 'package:desa/utils/constants/app_sizer.dart';
import 'package:desa/utils/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DayDietMealPlanScreen extends StatelessWidget {
  final String id;
  final String weak;
  final String day;

  DayDietMealPlanScreen({
    super.key,
    required this.id,
    required this.weak,
    required this.day,
  });

  final List<Map<String, String>> dayDietList = [
    {
      'iconPath': 'assets/nutritionIcons/breakfastIcon.svg',
      'title': 'Breakfast',
    },
    {
      'iconPath': 'assets/nutritionIcons/lunchIcon.svg',
      'title': 'Lunch',
    },
    {
      'iconPath': 'assets/nutritionIcons/snacksIcon.svg',
      'title': 'Snacks',
    },
    {
      'iconPath': 'assets/nutritionIcons/dinnerIcon.svg',
      'title': 'Dinner',
    },
  ];

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: AppColor.appBackgroundColor,
      appBar: const TransparentAppBar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizer.horizontal15,
            vertical: AppSizer.vertical10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyManropeText(
                text: "Let’s Configure Your Diet",
                fontSize: AppSizer.fontSize22,
                fontWeight: FontWeight.w900,
                maxLines: 2,
              ),
              SizedBox(
                height: height * 0.035,
              ),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: width * 0.045,
                  mainAxisSpacing: height * 0.02,
                  childAspectRatio: width / (height * 0.32),
                ),
                itemCount: 4,
                itemBuilder: (context, index) {
                  final dayDiet = dayDietList[index];
                  return InkWell(
                    onTap: () {
                      context.push(
                        AppRoutes.FOOD_LIST_PLAN_SCREEN,
                        extra: {
                          'id': id,
                          'weak': weak,
                          'day': day,
                          'mealType': dayDiet['title']
                        },
                      );
                    },
                    child: DayDietCard(
                      iconPath: dayDiet['iconPath']!,
                      title: dayDiet['title']!,
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
