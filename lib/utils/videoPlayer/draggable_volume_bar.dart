import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:volume_controller/volume_controller.dart';

class AppVolumeController extends GetxController {
  var setVolumeValue = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    //! --- Producting Jerking while changing volume ---
    // VolumeController().listener((volume) {
    //   setVolumeValue.value = volume;
    // });

    // Initialize volume value
    VolumeController().getVolume().then((volume) {
      setVolumeValue.value = volume;
    });

    VolumeController().showSystemUI = false;
  }

  @override
  void onClose() {
    VolumeController().removeListener();
    super.onClose();
  }

  void updateVolume(double delta, double height) {
    final newValue = setVolumeValue.value - delta / height;
    setVolumeValue.value = newValue.clamp(0.0, 1.0);
    VolumeController().setVolume(setVolumeValue.value);
  }
}

class DraggableVolumeController extends StatelessWidget {
  final bool show;
  const DraggableVolumeController({super.key, required this.show});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AppVolumeController());

    final double height = MediaQuery.sizeOf(context).height;
    final double width = MediaQuery.sizeOf(context).width;
    final barHeight = height * 0.3;

    void onVerticalDragUpdate(DragUpdateDetails details) {
      controller.updateVolume(details.primaryDelta!, barHeight);
    }

    return Obx(() => AnimatedOpacity(
          opacity: show ? 0.0 : 1.0,
          duration: const Duration(milliseconds: 300),
          child: GestureDetector(
            onVerticalDragUpdate: onVerticalDragUpdate,
            child: Container(
              width: width * 0.2,
              height: height * 0.4,
              color: Colors.transparent,
              child: Column(
                children: [
                  Icon(
                    CupertinoIcons.volume_up,
                    color: Colors.white,
                    size: width * 0.018,
                  ),
                  SizedBox(height: height * 0.03),
                  Container(
                    width: width * 0.006,
                    height: barHeight,
                    decoration: BoxDecoration(
                      color: Colors.grey[600],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        FractionallySizedBox(
                          heightFactor: controller.setVolumeValue.value,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

// class NewDraggableVolumeController extends StatefulWidget {
//   final bool show;
//   const NewDraggableVolumeController({super.key, required this.show});

//   @override
//   _NewDraggableVolumeControllerState createState() =>
//       _NewDraggableVolumeControllerState();
// }

// class _NewDraggableVolumeControllerState
//     extends State<NewDraggableVolumeController> {
//   double _setVolumeValue = 0;

//   @override
//   void initState() {
//     super.initState();
//     // Listen to system volume change
//     // VolumeController().listener((volume) {
//     //   setState(() => _volumeListenerValue = volume);
//     // });

//     VolumeController()
//         .getVolume()
//         .then((volume) => setState(() => _setVolumeValue = volume));

//     VolumeController().showSystemUI = false;
//   }

//   @override
//   void dispose() {
//     VolumeController().removeListener();
//     super.dispose();
//   }

//   void _onVerticalDragUpdate(DragUpdateDetails details) {
//     final newValue = _setVolumeValue - details.primaryDelta! / 200;
//     setState(() {
//       _setVolumeValue = newValue.clamp(0.0, 1.0);
//     });
//     VolumeController().setVolume(_setVolumeValue);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//     var orientation = MediaQuery.of(context).orientation;

//     if (orientation == Orientation.landscape) {
//       return AnimatedOpacity(
//         opacity: widget.show ? 0.0 : 1.0,
//         duration: const Duration(milliseconds: 300),
//         child: GestureDetector(
//           onVerticalDragUpdate: _onVerticalDragUpdate,
//           child: Container(
//             width: width * 0.2,
//             height: height * 0.4,
//             color: Colors.transparent,
//             child: Column(
//               children: [
//                 Icon(
//                   CupertinoIcons.volume_up,
//                   color: Colors.white,
//                   size: width * 0.018,
//                 ),
//                 SizedBox(height: height * 0.03),
//                 Container(
//                   width: width * 0.006,
//                   height: height * 0.3,
//                   decoration: BoxDecoration(
//                     color: Colors.grey[600],
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Stack(
//                     alignment: Alignment.bottomCenter,
//                     children: [
//                       FractionallySizedBox(
//                         heightFactor: _setVolumeValue,
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     } else {
//       return const SizedBox();
//     }
//   }
// }

// class AppVolumeController extends GetxController {
//   var currentValue = 0.5.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     // Initialize the volume controller and set initial value
//     VolumeController().listener((volume) {
//       currentValue.value = volume;
//     });

//     VolumeController().getVolume().then((volume) {
//       currentValue.value = volume;
//     });
//     VolumeController().showSystemUI = false;
//   }

//   @override
//   void onClose() {
//     VolumeController().removeListener();
//     super.onClose();
//   }

//   void setVolume(double value) {
//     currentValue.value = value;
//     VolumeController().setVolume(value);
//   }
// }

// class DraggableVolumeIndicator extends StatelessWidget {
//   final bool show;
//   const DraggableVolumeIndicator({super.key, required this.show});

//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//     final barHeight = height * 0.3;
//     var orientation = MediaQuery.of(context).orientation;
//     final controller = Get.put(AppVolumeController());

//     // if (orientation == Orientation.landscape) {
//     return GestureDetector(
//       onVerticalDragUpdate: (details) {
//         double newValue =
//             controller.currentValue.value - details.primaryDelta! / barHeight;
//         controller.setVolume(newValue.clamp(0.0, 1.0));
//       },
//       child: AnimatedOpacity(
//         opacity: 1.0,
//         duration: const Duration(milliseconds: 300),
//         child: Container(
//           width: width * 0.2,
//           height: barHeight + height * 0.1,
//           color: Colors.transparent,
//           child: Column(
//             children: [
//               Icon(
//                 CupertinoIcons.volume_up,
//                 color: Colors.white,
//                 size: width * 0.018,
//               ),
//               SizedBox(height: height * 0.03),
//               Center(
//                 child: Container(
//                   width: width * 0.006,
//                   height: barHeight,
//                   decoration: BoxDecoration(
//                     color: Colors.grey[600],
//                     borderRadius: BorderRadius.circular(5),
//                   ),
//                   child: Obx(() {
//                     return Stack(
//                       alignment: Alignment.bottomCenter,
//                       children: [
//                         FractionallySizedBox(
//                           heightFactor: controller.currentValue.value,
//                           child: Container(
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(5),
//                             ),
//                           ),
//                         ),
//                       ],
//                     );
//                   }),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//     // } else {
//     //   return const SizedBox();
//     // }
//   }
// }
