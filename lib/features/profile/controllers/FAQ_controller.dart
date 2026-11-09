import 'package:desa/data/datasources/remote/network_api_service.dart';
import 'package:desa/features/profile/models/FAQ_model.dart';
import 'package:desa/features/profile/repository/profile_repository.dart';
import 'package:get/get.dart';

class FAQScreenController extends GetxController {
  // List to manage the state of the expanded tiles
  var expandedTile = <bool>[].obs;

  var faqData = Rx<FAQModel?>(null);
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  // Method to toggle the expanded state of a tile
  void toggleTile(int index) {
    expandedTile[index] = !expandedTile[index];
  }

  // Fetch FAQ data
  Future<void> fetchFAQs() async {
    faqData.value = null; // Reset FAQ data
    errorMessage.value = ''; // Reset error message
    try {
      isLoading.value = true;

      // Fetch data from the repository
      final MapSD response = await ProfileRepository().getFAQ({});
      if (response.isNotEmpty) {
        faqData.value = FAQModel.fromJson(response);
      }

      // Dynamically update the expandedTile list based on the number of FAQs
      expandedTile.value =
          List<bool>.filled(faqData.value?.data?.length ?? 0, false);

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = 'Failed to fetch FAQs. Please try again later.';
      print('Error fetching FAQs: $e');
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchFAQs();
  }
}
