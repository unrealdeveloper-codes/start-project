import 'package:desa/features/home/controllers/discover_more_controller.dart';
import 'package:desa/utils/components/dateFormater/date_formet.dart';
import 'package:desa/utils/components/error_display/erroe_dispaly.dart';
import 'package:desa/utils/components/expandableTextWidget/expandableTextWidget.dart';
import 'package:desa/utils/components/headings/heading_subheading_widget.dart';
import 'package:desa/utils/components/image/custome_network_image.dart';
import 'package:desa/utils/components/text/app_text.dart';
import 'package:desa/utils/components/warning_dispaly.dart';
import 'package:desa/utils/constants/app_colors.dart';
import 'package:desa/utils/constants/app_sizer.dart';
import 'package:desa/utils/constants/resuable_box_decoration.dart';
import 'package:desa/utils/extensions/extensions.dart';
import 'package:desa/utils/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../utils/components/appbar/transparent_appBar.dart';

class DiscoverMoreScreen extends StatelessWidget {
  final String id;

  const DiscoverMoreScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DiscoverMoreController());
    controller.fetchBlogsCategoryListById(id);
    return Scaffold(
      backgroundColor: AppColor.appBackgroundColor,
      appBar: const TransparentAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: AppSizer.vertical6,
            horizontal: AppSizer.horizontal20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                if (controller.isLoading.value) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: AppSizer.height * 0.03,
                          width: AppSizer.width * 0.5,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius:
                                  BorderRadius.circular(AppRes.width * 0.01)),
                        ),
                        SizedBox(height: AppSizer.height * 0.01),
                        Container(
                          height: AppSizer.height * 0.02,
                          width: AppSizer.width * 0.8,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius:
                                  BorderRadius.circular(AppRes.width * 0.01)),
                        ),
                      ],
                    ),
                  );
                }

                if (controller.errorMessage.isNotEmpty) {
                  return SizedBox(
                    height: AppRes.height * 0.05,
                  );
                }

                return HeadingSubheadingWidget(
                  heading: controller.blogCategoryListByID.value?.data
                          ?.categoryTitle?.appCapitalize ??
                      '',
                  subHeading: controller.blogCategoryListByID.value?.data
                          ?.categoryDescription?.appCapitalize ??
                      '',
                );
              }),
              SizedBox(height: AppSizer.height * 0.012),
              Obx(() {
                if (controller.isLoading.value) {
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 5,
                    // Display shimmer for 5 items as a placeholder
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              vertical: AppSizer.vertical5),
                          height: AppSizer.height * 0.28,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius:
                                BorderRadius.circular(AppSizer.width * 0.025),
                          ),
                        ),
                      );
                    },
                  );
                }

                if (controller.errorMessage.isNotEmpty) {
                  return ErrorDisplay(
                      onTap: () {
                        controller.fetchBlogsCategoryListById(id);
                      },
                      errorMessage: controller.errorMessage
                          .value); // Return empty widget when there's an error
                }

                final blogs =
                    controller.blogCategoryListByID.value?.data?.blogs ?? [];
                if (blogs.isEmpty) {
                  return const WarningDisplay(
                    iconPath: 'assets/homePageIcons/no blog.svg',
                    warningMessage: 'No Blog Found !',
                    subWarningMessage:
                        'Stay tuned for upcoming blogs and articles.',
                  );
                }

                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: blogs.length,
                  itemBuilder: (context, index) {
                    final blog = blogs[index];
                    return InkWell(
                      onTap: () {
                        context.push(
                          AppRoutes.SINGLE_BLOG_BY_ID_SCREEN,
                          extra: {
                            'id': controller.blogCategoryListByID.value!.data!
                                .blogs![index].id
                                .toString()
                          }, // Pass the id as an extra argument
                        );
                        // context.push(AppRoutes.SINGLE_BLOG_BY_ID_SCREEN);
                      },
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(vertical: AppSizer.vertical5),
                        decoration: ReusableDecoration.reusableBoxDecoration(
                            context: context),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft:
                                    Radius.circular(AppSizer.width * 0.025),
                                topRight:
                                    Radius.circular(AppSizer.width * 0.025),
                              ),
                              child: CustomNetworkImage(
                                imageUrl: blog.image ?? '',
                                height: AppSizer.height * 0.19,
                                width: AppSizer.width,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: AppSizer.vertical8,
                                horizontal: AppSizer.horizontal10,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MySofiaSansText(
                                    text: blog.title?.appCapitalize ?? '',
                                    fontSize: AppSizer.width * 0.04,
                                  ),
                                  SizedBox(height: AppSizer.height * 0.003),
                                  // ExpandableText(description: blog.description??''),
                                  MyManropeText(
                                    text: blog.description?.appCapitalize ?? '',
                                    fontSize: AppSizer.width * 0.03,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  SizedBox(height: AppSizer.height * 0.01),
                                  Row(
                                    children: [
                                      Icon(Icons.calendar_month,
                                          size: AppSizer.width * 0.05),
                                      SizedBox(width: AppSizer.width * 0.02),
                                      MyManropeText(
                                        text:
                                            formatDate(blog.createdDate ?? ''),
                                        fontSize: AppSizer.width * 0.03,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
