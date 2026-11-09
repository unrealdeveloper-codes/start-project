import 'package:desa/data/datasources/remote/network_api_service.dart';
import 'package:desa/utils/constants/app_urls.dart';
import 'package:desa/utils/constants/enum.dart';

class NotificationRepository {
  NetworkApiServices services = NetworkApiServices();

  Future<MapSD> toggle() async {
    try {
      return await services.sendHttpRequest(
        url: AppUrls.notificationToggle,
        method: HttpMethod.get,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<MapSD> fetchNotifications() async {
    try {
      return await services.sendHttpRequest(
        url: AppUrls.fetchNotifications,
        method: HttpMethod.get,
      );
    } catch (e) {
      rethrow;
    }
  }
}
