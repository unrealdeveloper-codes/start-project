import 'package:desa/utils/constants/app_urls.dart';
import 'package:desa/utils/constants/enum.dart';

import '../../../data/datasources/remote/network_api_service.dart';

class IntroductionRepository {
  NetworkApiServices services = NetworkApiServices();

  // Get Introduction
  Future<MapSD> introduction(String id) async {
    try {
      return await services.sendHttpRequest(
        url: AppUrls.introduction,
        method: HttpMethod.get,
        id: id,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<MapSD> getIntroductionFromNutrition(String id) async {
    try {
      return await services.sendHttpRequest(
          url: AppUrls.getIntroductionFromNutrition,
          method: HttpMethod.get,
          id: id);
    } catch (e) {
      throw e;
    }
  }
}
