import 'package:desa/data/datasources/remote/api_call_handler.dart';
import 'package:desa/features/fitness/models/fitness_session_model.dart';
import 'package:desa/features/fitness/repositories/fitness_repository.dart';
import 'package:desa/utils/components/snackbar/app_snackbar.dart';
import 'package:desa/utils/constants/enum.dart';
import 'package:desa/utils/extensions/extensions.dart';
import 'package:desa/utils/utils.dart';
import 'package:desa/utils/videoPlayer/app_video_player_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class FitnessSessionController extends GetxController {
  static FitnessSessionController get instance => Get.find();

  // -- Variables
  final apiCallHandler = ApiCallHandler();
  final _repo = FitnessRepository();
  final _session = FitnessSession.empty().obs;
  final currentDescription = <Description>[].obs;
  final _isLoading = false.obs;
  final _sessionErrorMessage = "".obs;
  RxInt selectedStep = 0.obs;
  var showAllSteps = false.obs;
  final loading = false.obs;

  // -- Getters
  FitnessSession get session => _session.value;
  String get sessionErrorMesssage => _sessionErrorMessage.value;
  bool get isLoading => _isLoading.value;

  // -- Reset Methods
  void resetSession() {
    setSelectedStep(0);
    _session.value = FitnessSession.empty();
    _sessionErrorMessage.value = "";
  }

  void toggleStepsVisibility() {
    showAllSteps.value = !showAllSteps.value;
  }

  List<Description> getCurrentDescription() {
    return session.steps?.stepsPrograms?[selectedStep.value].description ?? [];
  }

  // -- Set Methods
  void setSession(Map<String, dynamic> data) {
    final session = FitnessSession.fromJson(data['data']);
    _session.value = session;
  }

  void setLoading(bool val) {
    _isLoading.value = val;
  }

  void setSelectedStep(int index) {
    selectedStep.value = index;
    getCurrentVideoDuration();
    getCurrentDescription();
  }

  // -- Video Player Methods
  void changeVideo(int index) {
    setSelectedStep(index);
    AppVideoPlayerController.instance.play(
      session.steps?.stepsPrograms?[index].video ?? "",
    );
  }

  // -- Auto Play Next Video
  void playNextVideo() {
    final videoList = session.steps?.stepsPrograms;
    // Find the index of the current video
    final currentIndex = selectedStep.value;

    // Check if there is a next video
    if (currentIndex != -1 && currentIndex < videoList!.length - 1) {
      // Get the next video's URL
      final nextVideoUrl = videoList[currentIndex + 1].video;

      // Play the next video
      AppVideoPlayerController.instance.play(nextVideoUrl!);
      setSelectedStep(currentIndex + 1);
    } else {
      // No next video, do nothing
      ("No next video available.").log("playNextVideo()");
    }
  }

  // -- On Back
  void onBackVideoPlayer(BuildContext context) {
    if (Get.isRegistered<AppVideoPlayerController>()) {
      Get.delete<AppVideoPlayerController>();
      Navigator.pop(context);
    } else {
      Navigator.pop(context);
    }
  }

  // -- Get the Video Duration
  String getCurrentVideoDuration() {
    String? duration =
        session.steps?.stepsPrograms?[selectedStep.value].duration ?? "0";
    return Utils.parseDurationToHourMinute(duration ?? "0");
  }

  // -- API Calls
  Future<void> fetchSession(BuildContext context, String id) async {
    try {
      if (id.isEmpty || id == "") {
        _sessionErrorMessage.value = "Invalid Session ID.";
        AppSnackBar.showSnackbar(
          context: context,
          type: SnackbarType.error,
          title: "Error",
          message: _sessionErrorMessage.value,
        );
        return;
      }

      resetSession();
      setLoading(true);

      await apiCallHandler.apiHandler(
        context: context,
        apiCall: () => _repo.session(id),
        onSuccess: (result) => setSession(result),
        errorMessage: _sessionErrorMessage,
        isLoading: loading,
      );

      final vc = Get.put(AppVideoPlayerController());
      vc.init(session.steps?.stepsPrograms?[selectedStep.value].video ?? "");
    } catch (error, stackTrace) {
      error.toString().log("fetchSession()");
      stackTrace.toString().log("fetchSession()");
      _sessionErrorMessage.value = "An error occurred. Please try again later.";
      AppSnackBar.showSnackbar(
        context: context,
        type: SnackbarType.error,
        title: "Error",
        message: _sessionErrorMessage.value,
      );
    } finally {
      setLoading(false);
    }
  }
}
