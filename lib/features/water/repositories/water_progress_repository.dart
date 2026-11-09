import 'package:desa/utils/constants/app_urls.dart';
import 'package:desa/utils/constants/enum.dart';

import '../../../data/datasources/remote/network_api_service.dart';

class WaterProgressRepository {
  NetworkApiServices services = NetworkApiServices();

  // Fetch Water Goal
  Future<MapSD> waterGoal() async {
    try {
      return await services.sendHttpRequest(
        url: AppUrls.waterGoal,
        method: HttpMethod.get,
      );
    } catch (e) {
      rethrow;
    }
  }

  // Record Water Intake
  Future<MapSD> recordWater(MapSS body) async {
    try {
      return await services.sendHttpRequest(
        url: AppUrls.recordWater,
        method: HttpMethod.post,
        body: body,
      );
    } catch (e) {
      rethrow;
    }
  }

  // Fetch Water Intake of Day
  Future<MapSD> waterIntake() async {
    try {
      return await services.sendHttpRequest(
        url: AppUrls.waterIntake,
        method: HttpMethod.get,
      );
    } catch (e) {
      rethrow;
    }
  }

  // Fetch Water Intake for a week Graphical
  Future<MapSD> waterIntakeGraphical(MapSS body) async {
    try {
      return await services.sendHttpRequest(
        url: AppUrls.waterIntakeGraph,
        method: HttpMethod.post,
        body: body,
      );
    } catch (e) {
      rethrow;
    }
  }
}
