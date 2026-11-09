import 'dart:async';

import 'package:chewie/chewie.dart';
import 'package:desa/features/fitness/controllers/fitness_session_controller.dart';
import 'package:desa/utils/videoPlayer/custom_video_player_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../../utils/extensions/extensions.dart';
// -- Network Videos
// "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
// "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4"

class AppVideoPlayerController extends GetxController {
  static AppVideoPlayerController get instance => Get.find();

  // -- Variables
  Rx<Future<void>> initializeVideoPlayerFuture = Future.value().obs;
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  RxString videoUrl = "".obs;
  RxString errorMessage = "".obs;
  bool _isChewieInitialized = false;

  // -- Getters
  ChewieController get chewieController => _chewieController;

  @override
  void onClose() {
    pauseVideo();
    _videoPlayerController.removeListener(_videoPlayerListener);
    _videoPlayerController.dispose();
    // Dispose ChewieController only if it is initialized
    if (_isChewieInitialized) {
      _chewieController.dispose();
    }

    super.onClose();
  }

  // --- Helper Functions
  void init(String url) {
    videoUrl.value = url;
    initializeVideoPlayer();
  }

  void play(String url) {
    errorMessage.value = "";
    videoUrl.value = url;

    // Dispose of the previous controller if initialized
    if (_videoPlayerController.value.isInitialized) {
      _videoPlayerController.dispose();
    }

    // Show loading state
    initializeVideoPlayer();
  }

  void pauseVideo() {
    if (_videoPlayerController.value.isInitialized) {
      _videoPlayerController.pause();
    }
  }

  void initializeVideoPlayer() {
    _videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(videoUrl.value));
    initializeVideoPlayerFuture.value =
        _videoPlayerController.initialize().then((_) {
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        allowedScreenSleep: false,
        autoPlay: true,
        looping: false,
        zoomAndPan: true,
        customControls: CustomController(
          backgroundColor: Colors.white.withOpacity(0.2),
          iconColor: Colors.white,
        ),
        errorBuilder: (context, error) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(Icons.error),
              Text(error),
            ],
          ),
        ),
      );

      // Mark ChewieController as initialized
      _isChewieInitialized = true;

      _videoPlayerController.addListener(_videoPlayerListener);

      update();
    }).onError((error, stackTrace) {
      errorMessage.value = error.toString();
      ("$error $stackTrace").log("Video Player Controller");
    });
  }

  void _videoPlayerListener() {
    if (_videoPlayerController.value.isPlaying) {
      ("Video is playing").log();
    } else if (_videoPlayerController.value.isCompleted) {
      ("Video has ended").log();
      FitnessSessionController.instance.playNextVideo();
    } else if (_videoPlayerController.value.isBuffering) {
      //  print("Video is buffering");
    } else {
      //  print("Video is paused");
    }
  }
}
