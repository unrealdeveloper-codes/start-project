import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screen_brightness/screen_brightness.dart';

class DraggableBrightnessIndicator extends StatelessWidget {
  final bool show;
  const DraggableBrightnessIndicator({
    super.key,
    required this.show,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final barHeight = height * 0.3;
    var orientation = MediaQuery.of(context).orientation;
    final controller = Get.put(BrightnessController());

    if (orientation == Orientation.landscape) {
      return GestureDetector(
        onVerticalDragUpdate: (details) {
          double newValue = controller.currentBrightness.value -
              details.primaryDelta! / barHeight;
          controller.setBrightness(newValue.clamp(0.0, 1.0));
        },
        child: AnimatedOpacity(
          opacity: show ? 0.0 : 1.0,
          duration: const Duration(milliseconds: 300),
          child: Container(
            width: width * 0.2, // Expand the width of the gesture detector
            height: barHeight + height * 0.1,
            color: Colors.transparent,
            child: Column(
              children: [
                Icon(
                  CupertinoIcons.sun_max_fill,
                  color: Colors.white,
                  size: width * 0.018,
                ),
                SizedBox(height: height * 0.03),
                Center(
                  child: Container(
                    width: width * 0.006,
                    height: barHeight,
                    decoration: BoxDecoration(
                      color: Colors.grey[600],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Obx(() {
                      return Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          FractionallySizedBox(
                            heightFactor: controller.currentBrightness.value,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}

class BrightnessController extends GetxController {
  var currentBrightness = 0.5.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize the brightness controller and set initial value
    ScreenBrightness().current.then((brightness) {
      currentBrightness.value = brightness;
    });
  }

  void setBrightness(double value) {
    currentBrightness.value = value;
    ScreenBrightness().setScreenBrightness(value);
  }
}
