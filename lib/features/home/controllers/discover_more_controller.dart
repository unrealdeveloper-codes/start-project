import 'package:desa/data/datasources/remote/network_api_service.dart';
import 'package:desa/features/home/model/blogs_category_list_by_id_model.dart';
import 'package:desa/features/home/repository/home_repository.dart';
import 'package:get/get.dart';

class DiscoverMoreController extends GetxController {
  var blogCategoryListByID = Rx<BlogsCategoryListByIDModel?>(null);
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  Future<void> fetchBlogsCategoryListById(String id) async {
    blogCategoryListByID.value = null; // Reset FAQ data
    errorMessage.value = ''; // Reset error message
    try {
      isLoading.value = true;

      final MapSD response = await HomeRepository().getBlogsListByID(id);
      if (response.isNotEmpty) {
        blogCategoryListByID.value =
            BlogsCategoryListByIDModel.fromJson(response);
      }

      print(blogCategoryListByID.value);
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = '${e.toString()}  Please try again later.';
      print('Error fetching FAQs: $e');
    }
  }
}
