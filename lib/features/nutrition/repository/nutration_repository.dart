import 'package:desa/data/datasources/remote/network_api_service.dart';
import 'package:desa/utils/constants/app_urls.dart';
import 'package:desa/utils/constants/enum.dart';

class NutritionRepository {
  NetworkApiServices services = NetworkApiServices();

  Future<MapSD> getNutritionAllPrograms() async {
    try {
      return await services.sendHttpRequest(
        url: AppUrls.getNutationAllPrograms,
        method: HttpMethod.get,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<MapSD> getNutritionProgram(String id) async {
    try {
      return await services.sendHttpRequest(
          url: AppUrls.getNutritionProgram, method: HttpMethod.get, id: id);
    } catch (e) {
      rethrow;
    }
  }

  Future<MapSD> getApproveNonApproveFood(MapSS body) async {
    try {
      return await services.sendHttpRequest(
          url: AppUrls.getApproveNonApproveFood,
          method: HttpMethod.post,
          body: body);
    } catch (e) {
      rethrow;
    }
  }

  Future<MapSD> getFoodRecipesDetail(String id) async {
    try {
      return await services.sendHttpRequest(
          url: AppUrls.getRecipesFoodDetail, method: HttpMethod.get, id: id);
    } catch (e) {
      rethrow;
    }
  }

  Future<MapSD> getFoodDetailData(String id, MapSS body) async {
    try {
      return await services.sendHttpRequest(
        url: AppUrls.getFoodDetailData,
        method: HttpMethod.post,
        id: id,
        body: body,
      );
    } catch (e) {
      rethrow;
    }
  }

  // Future<MapSD> getNonApproveFood(String id) async {
  //   try {
  //     return await services.sendHttpRequest(
  //         url: AppUrls.getNonApproveFood,
  //         method: HttpMethod.get,
  //         id: id
  //     );
  //   } catch (e) {
  //     throw e;
  //   }
  // }

  Future<MapSD> getDietMealPlanData(String id) async {
    try {
      return await services.sendHttpRequest(
          url: AppUrls.getDietMealPlanData, method: HttpMethod.get, id: id);
    } catch (e) {
      rethrow;
    }
  }

  Future<MapSD> getWeakDietMeal(String id, MapSS body) async {
    try {
      return await services.sendHttpRequest(
          url: AppUrls.getWeakDietMealData,
          method: HttpMethod.post,
          id: id,
          body: body);
    } catch (e) {
      rethrow;
    }
  }

  Future<MapSD> getFoodListPlanData(String id, MapSS body) async {
    try {
      return await services.sendHttpRequest(
          url: AppUrls.getFoodListPlanData,
          method: HttpMethod.post,
          id: id,
          body: body);
    } catch (e) {
      rethrow;
    }
  }

  Future<MapSD> searchMeal(MapSS query) async {
    try {
      return await services.sendHttpRequest(
          url: AppUrls.searchMealFromNutration,
          method: HttpMethod.get,
          queryParams: query);
    } catch (e) {
      rethrow;
    }
  }
}
