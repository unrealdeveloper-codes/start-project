import 'package:desa/utils/constants/app_colors.dart';
import 'package:desa/utils/components/text/app_text.dart';
import 'package:desa/features/static/onbordingScreen/views/widget/onBordingWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../controllers/onbording_screen_controller.dart';

class OnboardingScreenView extends StatelessWidget {
  OnboardingScreenView({super.key});

  final PageController pageController = PageController();
  final List<String> headings = [
    'Personalised Health Plans',
    'Track Your Progress',
    'Stay on Track with Reminders',
  ];

  final List<String> descriptions = [
    'Get personalised plans for your meals, medicines, and workouts. Your health starts now!',
    'Monitor your progress with easy-to-read graphs and stay motivated as you reach your health goals.',
    'Stay on track with reminders for your medicines and workouts. We’ll keep you up-to-date.',
  ];

  OnboardingScreenController controller = OnboardingScreenController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: AppColor.appBackgroundColor,
      body: Stack(
        alignment: Alignment.center,
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.onPageUpdateIndicator,
            children: [
              OnBoardingWidget(
                controller: controller,
                image: "assets/onbordingScreen/image.png",
                index: 0,
              ),
              OnBoardingWidget(
                controller: controller,
                image: "assets/onbordingScreen/image-1.png",
                index: 1,
              ),
              OnBoardingWidget(
                controller: controller,
                image: "assets/onbordingScreen/image-2.png",
                index: 2,
              ),
            ],
          ),
          Obx(() => buildOnboardingTextSection(
                headingText: headings[controller.currentIndex.value],
                descriptionText: descriptions[controller.currentIndex.value],
                screenHeight: height,
                screenWidth: width,
              )),
          Align(
            alignment: Alignment.bottomRight,
            child: InkWell(
              onTap: () {
                controller.nextPage(context);
              },
              child: Container(
                margin: EdgeInsets.symmetric(
                    vertical: width * 0.1, horizontal: width * 0.1),
                width: width * 0.11,
                height: width * 0.11,
                decoration: BoxDecoration(
                    color: AppColor.primaryColor1,
                    borderRadius: BorderRadius.circular(width * 0.028)),
                child: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: width * 0.06,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildOnboardingTextSection({
    required String headingText,
    required String descriptionText,
    required double screenHeight,
    required double screenWidth,
  }) {
    return Positioned(
      top: screenHeight * 0.1,
      left: screenWidth * 0.07,
      child: SizedBox(
        width: screenWidth * 0.9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MySofiaSansText(
              text: headingText.toUpperCase(),
              fontSize: screenWidth * 0.1,
              height: screenHeight * 0.00135,
              fontWeight: FontWeight.w800,
            ),

            SizedBox(height: screenHeight * 0.018),
            MyManropeText(
              text: descriptionText,
              color: AppColor.primaryColor1,
              height: screenHeight * 0.002,
              fontWeight: FontWeight.w700,
              fontSize: screenWidth * 0.035,
              maxLines: 2,
            ),
            SizedBox(height: screenHeight * 0.018),
            SmoothPageIndicator(
              controller: controller.pageController,
              count: 3,
              onDotClicked: controller.dotNavigationClick,
              effect: ExpandingDotsEffect(
                dotHeight: screenHeight * 0.01,
                dotWidth: screenWidth * 0.035,
                dotColor: AppColor.primaryColor3,
                activeDotColor: AppColor.primaryColor1,
                spacing: screenWidth * 0.02,
              ),
            )
            // OnBoradingDotNavigation(),
          ],
        ),
      ),
    );
  }
}

class OnBoradingDotNavigation extends StatelessWidget {
  OnBoradingDotNavigation({super.key});

  OnboardingScreenController controller = Get.put(OnboardingScreenController());

  @override
  Widget build(BuildContext context) {
    print("rrrrrr");

    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return SmoothPageIndicator(
      controller: controller.pageController,
      count: 3,
      onDotClicked: controller.dotNavigationClick,
      effect: ExpandingDotsEffect(
        dotHeight: height * 0.01,
        dotWidth: width * 0.035,
        dotColor: AppColor.primaryColor3,
        activeDotColor: AppColor.primaryColor1,
        spacing: width * 0.02,
      ),
    );
  }
}
