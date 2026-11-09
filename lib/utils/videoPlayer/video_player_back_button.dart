import 'package:desa/features/fitness/controllers/fitness_session_controller.dart';
import 'package:desa/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

class VideoPlayerBackButton extends StatelessWidget {
  const VideoPlayerBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final controller = FitnessSessionController.instance;
    return Align(
      alignment: Alignment.topLeft,
      child: InkWell(
        onTap: () => controller.onBackVideoPlayer(context),
        child: Container(
          height: height * 0.035,
          margin: EdgeInsets.only(
            left: width * 0.03,
            top: height * 0.025,
          ),
          decoration: BoxDecoration(
            color: AppColor.black.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: EdgeInsets.symmetric(horizontal: width * 0.04),
          child: Icon(
            Icons.arrow_back_ios,
            color: AppColor.white,
            size: width * 0.045,
          ),
        ),
      ),
    );
  }
}
