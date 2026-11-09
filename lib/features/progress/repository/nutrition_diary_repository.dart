import 'package:desa/data/datasources/remote/network_api_service.dart';
import 'package:desa/utils/constants/app_urls.dart';
import 'package:desa/utils/constants/enum.dart';

class NutritionDiaryRepository {
  NetworkApiServices services = NetworkApiServices();

  Future<MapSD> getSearchMeal(MapSS query) async {
    try {
      return await services.sendHttpRequest(
          url: AppUrls.searchMealFromProgress,
          method: HttpMethod.get,
          queryParams: query);
    } catch (e) {
      throw e;
    }
  }

  Future<MapSD> getConsumedMealData() async {
    try {
      return await services.sendHttpRequest(
        url: AppUrls.getConsumedMeal,
        method: HttpMethod.get,
      );
    } catch (e) {
      throw e;
    }
  }

  Future<MapSD> deleteConsumedMeal(String id) async {
    try {
      return await services.sendHttpRequest(
          url: AppUrls.deleteConsumedMeal, method: HttpMethod.delete, id: id);
    } catch (e) {
      throw e;
    }
  }

  Future<MapSD> getDietSummaryData(MapSS body) async {
    try {
      return await services.sendHttpRequest(
          url: AppUrls.getDietSummaryData, method: HttpMethod.post, body: body);
    } catch (e) {
      throw e;
    }
  }

  Future<MapSD> addMeal(MapSS body) async {
    try {
      return await services.sendHttpRequest(
          url: AppUrls.addMeal, method: HttpMethod.post, body: body);
    } catch (e) {
      throw e;
    }
  }

  Future<MapSD> editMeal(MapSS body, String id) async {
    try {
      return await services.sendHttpRequest(
          id: id, url: AppUrls.editMeal, method: HttpMethod.put, body: body);
    } catch (e) {
      throw e;
    }
  }
}
