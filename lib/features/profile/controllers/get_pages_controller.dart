import 'package:desa/data/datasources/remote/network_api_service.dart';
import 'package:desa/features/profile/models/get_pages_model.dart';
import 'package:desa/features/profile/repository/profile_repository.dart';
import 'package:get/get.dart';

class GetPagesController extends GetxController {
  var pagesData = Rx<GetPagesModel?>(null);
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  Future<void> fetchPages() async {
    pagesData.value = null; // Reset FAQ data
    errorMessage.value = ''; // Reset error message
    try {
      isLoading.value = true;

      // Fetch data from the repository
      final MapSD response = await ProfileRepository().getPages({});
      if (response.isNotEmpty) {
        pagesData.value = GetPagesModel.fromJson(response);
      }

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = '${e.toString()}  Please try again later.';
      print('Error fetching FAQs: $e');
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchPages();
  }
}
