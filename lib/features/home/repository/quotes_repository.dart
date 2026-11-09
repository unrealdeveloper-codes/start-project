import 'package:desa/data/datasources/remote/network_api_service.dart';
import 'package:desa/utils/constants/app_urls.dart';
import 'package:desa/utils/constants/enum.dart';

class QuotesRepository {
  NetworkApiServices services = NetworkApiServices();

  Future<MapSD> fetchQuotes() async {
    try {
      return await services.sendHttpRequest(
        url: AppUrls.getQutos,
        method: HttpMethod.get,
      );
    } catch (e) {
      rethrow;
    }
  }
}
