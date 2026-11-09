import 'package:chewie/chewie.dart';
import 'package:desa/utils/constants/app_sizer.dart';
import 'package:desa/utils/videoPlayer/app_video_player_controller.dart';
import 'package:desa/utils/components/text/app_text.dart';
import 'package:desa/utils/constants/app_colors.dart';
import 'package:desa/utils/videoPlayer/video_player_back_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VideoPlayerScreen extends StatelessWidget {
  const VideoPlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AppVideoPlayerController.instance;
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Column(
      children: [
        // Video Player
        Obx(() {
          if (controller.errorMessage.value != "") {
            return Stack(
              children: [
                // -- Dummy Video Player
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Container(
                    color: AppColor.grey.withOpacity(0.2),
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: height * 0.01),
                        Icon(
                          Icons.error,
                          color: Colors.red.withOpacity(0.8),
                          size: width * 0.06,
                        ),
                        SizedBox(height: height * 0.01),
                        MyManropeText(
                          text: "Something went wrong",
                          fontWeight: FontWeight.w600,
                          fontSize: AppSizer.fontSize14,
                          color: Colors.red,
                          maxLines: 3,
                        ),
                        SizedBox(height: height * 0.005),
                        SizedBox(
                          width: width * 0.7,
                          child: MyManropeText(
                            text: "Try again later",
                            //  text: controller.errorMessage.value,
                            fontWeight: FontWeight.w600,
                            fontSize: AppSizer.fontSize9,
                            color: Colors.red.withOpacity(0.6),
                            textAlign: TextAlign.center,
                            maxLines: 3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // -- Back Button
                const VideoPlayerBackButton(),
              ],
            );
          }
          return FutureBuilder(
            future: controller.initializeVideoPlayerFuture.value,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Chewie(controller: controller.chewieController),
                );
              } else {
                return const AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.grey,
                    ),
                  ),
                );
              }
            },
          );
        }),
      ],
    );
  }
}
