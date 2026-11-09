import 'package:desa/utils/constants/app_urls.dart';
import 'package:desa/utils/constants/enum.dart';

import '../../../data/datasources/remote/network_api_service.dart';

class AuthRepo {
  NetworkApiServices services = NetworkApiServices();

  // Auth
  Future<MapSD> auth() async {
    try {
      return await services.sendHttpRequest(
        url: AppUrls.auth,
        method: HttpMethod.get,
      );
    } catch (e) {
      rethrow;
    }
  }

  // Login
  Future<MapSD> login(MapSS body) async {
    try {
      return await services.sendHttpRequest(
        url: AppUrls.login,
        method: HttpMethod.post,
        body: body,
        includeHeaders: false,
      );
    } catch (e) {
      rethrow;
    }
  }

  // Change Password
  Future<MapSD> changePassword(MapSS data) async {
    try {
      return await services.sendHttpRequest(
        url: AppUrls.changePassword,
        method: HttpMethod.post,
        body: data,
      );
    } catch (e) {
      rethrow;
    }
  }

  // Reset Password
  Future<MapSD> resetPassword(MapSS data) async {
    try {
      return await services.sendHttpRequest(
        url: AppUrls.resetPassword,
        method: HttpMethod.post,
        body: data,
      );
    } catch (e) {
      rethrow;
    }
  }

  // Logout
  Future<MapSD> logout(MapSS body) async {
    try {
      return await services.sendHttpRequest(
        url: AppUrls.logout,
        method: HttpMethod.post,
        body: body,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<MapSD> refreshToken(MapSS body) async {
    try {
      return await services.sendHttpRequest(
        url: AppUrls.refreshToken,
        method: HttpMethod.post,
        body: body,
      );
    } catch (e) {
      rethrow;
    }
  }
}
