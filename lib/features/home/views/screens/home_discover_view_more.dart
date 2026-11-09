import 'package:desa/features/home/controllers/home_controller.dart';
import 'package:desa/features/home/views/widgets/Info_card.dart';
import 'package:desa/utils/components/error_display/erroe_dispaly.dart';
import 'package:desa/utils/components/headings/heading_subheading_widget.dart';
import 'package:desa/utils/components/text/app_text.dart';
import 'package:desa/utils/components/warning_dispaly.dart';
import 'package:desa/utils/constants/app_colors.dart';
import 'package:desa/utils/constants/app_strings.dart';
import 'package:desa/utils/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../utils/components/appbar/transparent_appBar.dart';

class HomeDiscoverViewMore extends StatelessWidget {
  const HomeDiscoverViewMore({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final controller = HomeController.instance;
    return Scaffold(
      backgroundColor: AppColor.appBackgroundColor,
      appBar: const TransparentAppBar(),
      body: Obx(
        () {
          return Column(
            children: [
              const HeadingSubheadingWidget(
                heading: AppStrings.discoverMoreTitle,
                subHeading: AppStrings.discoverMoreSubtitle,
              ),
              SizedBox(height: height * 0.03),
              if (controller.isLoading.value)
                // Show shimmer effect while loading
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.04, vertical: height * 0.01),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: width * 0.045,
                    mainAxisSpacing: height * 0.02,
                    childAspectRatio: width / (height * 0.445),
                  ),
                  itemCount: 4,
                  // Number of shimmer placeholders
                  itemBuilder: (context, index) {
                    return Shimmer.fromColors(
                      baseColor: AppColor.shimmerBaseColor,
                      highlightColor: AppColor.shimmerHighlightColor,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColor.shimmerContentColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        margin: EdgeInsets.symmetric(horizontal: width * 0.01),
                      ),
                    );
                  },
                )
              else if (controller.errorMessage.isNotEmpty)
                // Show error message if there's an error
                ErrorDisplay(
                  onTap: controller.fetchBlogsCategoryList,
                  errorMessage: controller.errorMessage.value,
                  boxHeight: height * 0.65,
                )
              else if (controller.blogCategoryList.value?.data == null ||
                  controller.blogCategoryList.value!.data!.isEmpty)
                // Show "No Data" message when the list is empty
                WarningDisplay(
                  boxHeight: height * 0.65,
                  iconPath: 'assets/homePageIcons/no blog.svg',
                  warningMessage: 'No Blog Found !',
                  subWarningMessage:
                      'Stay tuned for upcoming blogs and articles.',
                )
              else
                // Show actual grid when data is loaded
                //     List categoryList = controller.blogCategoryList.value!.data!;
                //List? categoryList = controller.blogCategoryList.value?.data;
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () => controller.fetchBlogsCategoryList(),
                    child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      //    shrinkWrap: true,
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.04, vertical: height * 0.01),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: width * 0.045,
                        mainAxisSpacing: height * 0.02,
                        childAspectRatio: width / (height * 0.445),
                      ),
                      itemCount:
                          controller.blogCategoryList.value?.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        final category =
                            controller.blogCategoryList.value!.data![index];
                        return InkWell(
                          onTap: () {
                            context.push(
                              AppRoutes.DISCOVER_MORE_SCREEN,
                              extra: {'id': category.id.toString()},
                            );
                          },
                          child: InfoCard(
                            iconPath: category.image!,
                            title: category.title!,
                            description: category.description!,
                          ),
                        );
                      },
                    ),
                  ),
                )
            ],
          );
        },
      ),
    );
  }
}
