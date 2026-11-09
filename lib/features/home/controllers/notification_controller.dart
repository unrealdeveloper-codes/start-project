import 'package:desa/features/home/model/notificationModel.dart';
import 'package:desa/features/home/repository/home_repository.dart';
import 'package:get/get.dart';

class NotificationControllerHome extends GetxController {
  var notificationData = Rx<NotificationModel?>(null);
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  Future<void> featchNotification() async {
    notificationData.value = null; // Reset FAQ data
    errorMessage.value = ''; // Reset error message

    try {
      isLoading.value = true;
      final response = await HomeRepository().getNotification();
      if (response.isNotEmpty) {
        notificationData.value = NotificationModel.fromJson(response);
      }
      // errorMessage.value = ' Please try again later.';

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = '${e.toString()}  Please try again later.';
      print('Error fetchApproveNonApproveFood : $e');
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    featchNotification();
  }
}
