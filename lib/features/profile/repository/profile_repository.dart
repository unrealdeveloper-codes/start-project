import 'package:desa/data/datasources/remote/network_api_service.dart';
import 'package:desa/utils/constants/app_urls.dart';
import 'package:desa/utils/constants/enum.dart';

class ProfileRepository {
  NetworkApiServices services = NetworkApiServices();

  Future<MapSD> getFAQ(MapSS body) async {
    try {
      return await services.sendHttpRequest(
        url: AppUrls.getFAQ,
        method: HttpMethod.get,
      );
    } catch (e) {
      throw e;
    }
  }

  Future<MapSD> getPages(MapSS body) async {
    try {
      return await services.sendHttpRequest(
        url: AppUrls.getPages,
        method: HttpMethod.get,
      );
    } catch (e) {
      throw e;
    }
  }

// Future<MapSD> getUser() async {
//   try {
//     return await services.sendHttpRequest(
//       url: AppUrls.getUser,
//       method: HttpMethod.get,
//       // useHeaders: true,
//     );
//   } catch (e) {
//     throw e;
//   }
// }
//
// Future<MapSD> updateProfile(MapSS data) async {
//   try {
//     return await services.sendHttpRequest(
//       url: ApiUrls.updateProfile,
//       method: HttpMethod.post,
//       body: data,
//       useHeaders: true,
//     );
//   } catch (e) {
//     throw e;
//   }
// }
//
// Future<MapSD> changePassword(MapSS data) async {
//   try {
//     return await services.sendHttpRequest(
//       url: ApiUrls.updatePassword,
//       method: HttpMethod.post,
//       body: data,
//       useHeaders: true,
//     );
//   } catch (e) {
//     throw e;
//   }
// }
//
// Future<MapSD> signOut(MapSS body) async {
//   try {
//     return await services.sendHttpRequest(
//         url: ApiUrls.signOut,
//         method: HttpMethod.post,
//         useHeaders: true,
//         body: body);
//   } catch (e) {
//     throw e;
//   }
// }

//
// Future getTermsAndCondationOrPrivacyPolicy() async {
//   try {
//     return await services.sendHttpRequest(
//       url: ApiUrls.getTermAndPrivacy,
//       method: HttpMethod.get,
//     );
//   } catch (e) {
//     throw e;
//   }
// }

//
// Future getHelpAndSupport() async {
//   try {
//     return await services.sendHttpRequest(
//       url: ApiUrls.gethelpNAdSupport,
//       method: HttpMethod.get,
//     );
//   } catch (e) {
//     throw e;
//   }
// }
//
// Future deleteProfileImage() async {
//   try {
//     return await services.sendHttpRequest(
//         url: ApiUrls.deleteProfile, method: HttpMethod.get, useHeaders: true);
//   } catch (e) {
//     throw e;
//   }
// }
//
// Future getHelpAndSupportAndPrivacy() async {
//   try {
//     return await services.sendHttpRequest(
//         url: ApiUrls.getHelpAndSupportAndPrivacy,
//         method: HttpMethod.get,
//         useHeaders: true);
//   } catch (e) {
//     throw e;
//   }
// }
//
// Future getHelpAndSupportAndPrivacyAdmin() async {
//   try {
//     return await services.sendHttpRequest(
//       url: ApiUrls.getHelpAndSupportAndPrivacyAdmin,
//       method: HttpMethod.get,
//     );
//   } catch (e) {
//     throw e;
//   }
// }
}
