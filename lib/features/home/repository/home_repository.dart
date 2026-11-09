import 'package:desa/data/datasources/remote/network_api_service.dart';
import 'package:desa/utils/constants/app_urls.dart';
import 'package:desa/utils/constants/enum.dart';

class HomeRepository {
  NetworkApiServices services = NetworkApiServices();

  Future<MapSD> getBlogsList() async {
    try {
      return await services.sendHttpRequest(
        url: AppUrls.getBlogCategory,
        method: HttpMethod.get,
      );
    } catch (e) {
      throw e;
    }
  }

  Future<MapSD> getBlogsListByID(String id) async {
    try {
      return await services.sendHttpRequest(
          url: AppUrls.getBlogCategoryListByID, method: HttpMethod.get, id: id);
    } catch (e) {
      throw e;
    }
  }

  Future<MapSD> getSingleBlogsByID(String id) async {
    try {
      return await services.sendHttpRequest(
          url: AppUrls.getSingleBlogById, method: HttpMethod.get, id: id);
    } catch (e) {
      throw e;
    }
  }

  Future<MapSD> getSessionData() async {
    try {
      return await services.sendHttpRequest(
        url: AppUrls.getSessionData,
        method: HttpMethod.get,
      );
    } catch (e) {
      throw e;
    }
  }

  Future<MapSD> getNotification() async {
    try {
      return await services.sendHttpRequest(
        url: AppUrls.getNotification,
        method: HttpMethod.get,
      );
    } catch (e) {
      throw e;
    }
  }
}
