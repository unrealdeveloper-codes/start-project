import 'package:desa/utils/constants/app_urls.dart';
import 'package:desa/utils/constants/enum.dart';

import '../../../data/datasources/remote/network_api_service.dart';

class FitnessRepository {
  NetworkApiServices services = NetworkApiServices();

  // Get Categories
  Future<MapSD> categories() async {
    try {
      return await services.sendHttpRequest(
        url: AppUrls.fitnessCategories,
        method: HttpMethod.get,
      );
    } catch (e) {
      rethrow;
    }
  }

  // Get Category
  Future<MapSD> category(String id) async {
    try {
      // final url =
      //     await services.buildUri(AppUrls.fitnessCategory, null, id: id);
      // return await services.sendHttpRequest(
      //   url: url,
      //   method: HttpMethod.get,
      // );
      // final url =
      //     await services.buildUri(AppUrls.fitnessCategory, null, id: id);
      return await services.sendHttpRequest(
        url: AppUrls.fitnessCategory,
        method: HttpMethod.get,
        id: id,
      );
    } catch (e) {
      rethrow;
    }
  }

  // Get Sessions
  Future<MapSD> sessions(String id) async {
    try {
      // final url =
      //     await services.buildUri(AppUrls.fitnessSessions, null, id: id);
      return await services.sendHttpRequest(
        url: AppUrls.fitnessSessions,
        method: HttpMethod.get,
        id: id,
      );
    } catch (e) {
      rethrow;
    }
  }

  // Get Session
  Future<MapSD> session(String id) async {
    try {
      //final url = await services.buildUri(AppUrls.fitnessSession, null, id: id);
      return await services.sendHttpRequest(
        url: AppUrls.fitnessSession,
        method: HttpMethod.get,
        id: id,
      );
    } catch (e) {
      rethrow;
    }
  }
}
