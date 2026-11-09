import 'package:desa/utils/components/image/app_cache_image.dart';
import 'package:desa/utils/components/shimmer/app_shimmer_effect.dart';
import 'package:desa/utils/constants/app_colors.dart';
import 'package:desa/utils/constants/app_sizer.dart';
import 'package:desa/utils/constants/app_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:http/http.dart' as http;

class CustomWidgetFromBackGround extends StatelessWidget {
  final String backgroundImage;
  final VoidCallback? onBack;
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final bool? isNetworkImage;

  const CustomWidgetFromBackGround({
    super.key,
    required this.backgroundImage,
    this.onBack,
    required this.child,
    this.padding,
    this.isNetworkImage,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    return Container(
      color: AppColor.white,
      child: Stack(
        children: [
          isNetworkImage ?? false
              ? FutureBuilder(
                  // Paste your image URL inside the htt.get method as a parameter
                  future: http.get(Uri.parse(backgroundImage)),
                  builder: (BuildContext context,
                      AsyncSnapshot<http.Response> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return Text('Press button to start.');
                      case ConnectionState.active:
                      case ConnectionState.waiting:
                        return Center(child: CircularProgressIndicator());
                      case ConnectionState.done:
                        if (snapshot.hasError)
                          return Text('Error: ${snapshot.error}');
                        // when we get the data from the http call, we give the bodyBytes to Image.memory for showing the image
                        return Image.memory(
                          snapshot.data!.bodyBytes,
                          width: width,
                          height: height,
                          fit: BoxFit.cover,
                        );
                    }
                  },
                )
              // Image.network(
              //     backgroundImage,
              //     width: width,
              //     height: height,
              //     fit: BoxFit.cover,

              //     errorBuilder: (context, error, stackTrace) =>
              //         SvgPicture.asset(
              //       AppSvg.meditationLibraryBg,
              //       fit: BoxFit.cover,
              //     ),
              //   )

              //  AppCacheImage(
              //     image: backgroundImage,
              //     isNetworkImage: true,
              //     width: width,
              //     height: height,
              //     errorWidget: SvgPicture.asset(
              //       AppSvg.meditationLibraryBg,
              //       fit: BoxFit.cover,
              //     ),
              //     // errorWidget: Image.asset(
              //     //   "assets/fitness/calmCorner.png",
              //     //   //   "assets/fitness/exercies_bg.png",
              //     //   width: width,
              //     //   height: height,
              //     // ),
              //     progressIndicatorWidget: Shimmer.fromColors(
              //       baseColor: Colors.grey[200]!,
              //       highlightColor: Colors.grey[300]!,
              //       child: Container(
              //         width: width,
              //         height: height,
              //         color: AppColor.black,
              //       ),
              //     ),
              //   )
              : SvgPicture.asset(
                  backgroundImage,
                  fit: BoxFit.cover,
                ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              systemOverlayStyle: SystemUiOverlayStyle.dark,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  size: width * 0.045,
                ),
                onPressed: () => onBack ?? context.pop(),
              ),
            ),
            body: Padding(
              padding: padding ??
                  EdgeInsets.symmetric(
                    horizontal: AppSizer.horizontal20,
                    //vertical: AppSizer.vertical8,
                  ),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}

class Test extends StatelessWidget {
  final String backgroundImage;
  final VoidCallback? onBack;
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const Test({
    super.key,
    required this.backgroundImage,
    this.onBack,
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return Stack(
      children: [
        // Image.network(
        //   "https://images.rawpixel.com/image_800/cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDIzLTA3L2pvYjE0NDgtYmFja2dyb3VuZC0wNGEteF8xLmpwZw.jpg",
        //   fit: BoxFit.cover,

        // ),
        // SvgPicture.asset(
        //   backgroundImage,
        //   fit: BoxFit.cover,
        // ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new,
                size: width * 0.045,
              ),
              onPressed: () => onBack ?? context.pop(),
            ),
          ),
          body: Padding(
            padding: padding ??
                EdgeInsets.symmetric(
                  horizontal: AppSizer.horizontal20,
                  vertical: AppSizer.vertical8,
                ),
            child: child,
          ),
        ),
      ],
    );
  }
}
