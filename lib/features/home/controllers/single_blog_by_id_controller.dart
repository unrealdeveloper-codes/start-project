import 'package:desa/data/datasources/remote/network_api_service.dart';
import 'package:desa/features/home/model/single_blog_by_id_model.dart';
import 'package:desa/features/home/repository/home_repository.dart';
import 'package:get/get.dart';

class SingleBlogByIdController extends GetxController {
  var singleBlogByIdData = Rx<SingleBlogByIDModel?>(null);
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  Future<void> fetchSingleBlogsById(String id) async {
    singleBlogByIdData.value = null; // Reset FAQ data
    errorMessage.value = ''; // Reset error message
    try {
      isLoading.value = true;

      final MapSD response = await HomeRepository().getSingleBlogsByID(id);
      if (response.isNotEmpty) {
        singleBlogByIdData.value = SingleBlogByIDModel.fromJson(response);
      }

      print(singleBlogByIdData.value);
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;

      errorMessage.value = '${e.toString()}  Please try again later.';
      print('Error fetching FAQs: $e');
    }
  }
}
