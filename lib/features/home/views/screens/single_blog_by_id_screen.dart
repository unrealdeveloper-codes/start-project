import 'package:desa/features/home/controllers/single_blog_by_id_controller.dart';
import 'package:desa/utils/components/appbar/transparent_appBar.dart';
import 'package:desa/utils/components/dateFormater/date_formet.dart';
import 'package:desa/utils/components/error_display/erroe_dispaly.dart';
import 'package:desa/utils/components/image/custome_network_image.dart';
import 'package:desa/utils/components/text/app_text.dart';
import 'package:desa/utils/components/warning_dispaly.dart';
import 'package:desa/utils/constants/app_colors.dart';
import 'package:desa/utils/constants/app_sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class SingleBlogByIdScreen extends StatelessWidget {
  final String id;

  const SingleBlogByIdScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SingleBlogByIdController());
    controller.fetchSingleBlogsById(id);

    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      backgroundColor: AppColor.appBackgroundColor,
      appBar: const TransparentAppBar(),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            // Show shimmer effect while loading
            return _buildShimmerLoading(width, height);
          } else if (controller.errorMessage.isNotEmpty) {
            // Show error message if an error occurs
            return ErrorDisplay(
                onTap: () {
                  controller.fetchSingleBlogsById(id);
                },
                errorMessage: controller.errorMessage.value);
          } else if (controller.singleBlogByIdData.value?.data == null ||
              controller.singleBlogByIdData.value!.data?.createdDate == null) {
            // Show "No Data Found" message when no blog data is available
            return WarningDisplay(
              boxHeight: height * 0.75,
              iconPath: 'assets/homePageIcons/no blog.svg',
              warningMessage: 'No Blog Found !',
              subWarningMessage: 'Stay tuned for upcoming blogs and articles.',
            );
          } else {
            // Render actual blog details
            final blogData = controller.singleBlogByIdData.value!.data!;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(width * 0.025),
                      topRight: Radius.circular(width * 0.025),
                    ),
                    child: CustomNetworkImage(
                      imageUrl: blogData.image ?? '',
                      height: AppSizer.height * 0.3,
                      width: AppSizer.width,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSizer.horizontal10,
                      vertical: AppSizer.vertical8,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.calendar_month,
                                size: AppSizer.width * 0.05),
                            SizedBox(width: AppSizer.width * 0.01),
                            MyManropeText(
                              text: formatDate(blogData.createdDate ?? ''),
                              fontSize: AppSizer.width * 0.03,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                        SizedBox(height: height * 0.01),
                        Html(
                          data: '<pre>${blogData.description ?? ''}</pre>',
                        )
                        //Html(data: blogData.description ?? ''),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        }),
      ),
    );
  }

  Widget _buildShimmerLoading(double width, double height) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 1,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                height: AppSizer.height * 0.3,
                width: AppSizer.width,
                color: Colors.grey[300],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizer.horizontal10,
                vertical: AppSizer.vertical8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          height: height * 0.03,
                          width: width * 0.3,
                          color: Colors.grey[300],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.02),
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: height * 0.05,
                      width: width * 0.8,
                      color: Colors.grey[300],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

// class SingleBlogByIdScreen extends StatelessWidget {
//   final String id;
//   const SingleBlogByIdScreen({super.key, required this.id});
//   @override
//   Widget build(BuildContext context) {
//     SingleBlogByIdController controller = Get.put(SingleBlogByIdController());
//     controller.fetchSingleBlogsById(id);
//     final size = MediaQuery.of(context).size;
//     final height = size.height;
//     final width = size.width;
//     return Scaffold(
//       backgroundColor: AppColor.appBackgroundColor,
//       body: SafeArea(
//         child: Stack(
//           children: [
//             SingleChildScrollView(
//               child: Obx(()=>Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   ClipRRect(
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(width * 0.025),
//                         topRight: Radius.circular(width * 0.025),
//                       ),
//                       child:CustomNetworkImage
//                         (imageUrl: controller.singleBlogByIdData.value!.data![0].image!,       height: AppSizer.height * 0.3,
//                         width: AppSizer.width,
//                         fit: BoxFit.cover,)
//
//                     // child: Image.asset(
//                     //   'assets/tempicons/Frame 427323274.png',
//                     //   height: AppSizer.height * 0.3,
//                     //   width: AppSizer.width,
//                     //   fit: BoxFit.cover,
//                     // ),
//                   ),
//                   Row(children: [
//                     Icon(Icons.calendar_today_outlined,size: width*0.05,),
//                     SizedBox(width: width*0.02,),
//                     MyManropeText(text: controller.singleBlogByIdData.value!.data![0].createdDate!)
//                   ],),
//                   SizedBox(height: height*0.02,),
//                   Html(data: controller.singleBlogByIdData.value!.data![0].description!)
//
//                 ],
//               ),)
//             ),
//             Align(
//                 alignment: Alignment.topLeft,
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(
//                       vertical: AppSizer.vertical5,
//                       horizontal: AppSizer.horizontal10),
//                   child: IconButton(
//                       onPressed: () {
//                         context.pop();
//                       },
//                       icon: Icon(
//                         Icons.arrow_back_ios,
//                         size: width * 0.05,
//                       )),
//                 ))
//           ],
//         ),
//       ),
//     );
//   }
// }
