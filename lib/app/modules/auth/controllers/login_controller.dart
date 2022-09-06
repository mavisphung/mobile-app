import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/constants.dart';

import '../../../common/storage/storage.dart';
import '../../../common/util/extensions.dart';
import '../../../common/util/status.dart';
import '../../../common/util/utils.dart';
import '../../../routes/app_pages.dart';
import '../providers/api_auth.dart';
import '../providers/api_auth_impl.dart';

class LoginController extends GetxController {
  final loginStatus = Status.init.obs;
  late final ApiAuth _apiAuth;

  Future<void> login(String email, String password) async {
    Utils.unfocus();
    loginStatus.value = Status.loading;
    final response = await _apiAuth.postLogin(email, password).futureValue();
    if (response != null && response.isSuccess == true && response.statusCode == Constants.successPostStatusCode) {
      await Storage.saveValue(CacheKey.TOKEN.name, response.data['accessToken']);
      await Storage.saveValue(CacheKey.IS_LOGGED.name, true);

      final userInfo = {
        'id': response.data['id'],
        'email': response.data['email'],
        'firstName': response.data['firstName'],
        'lastName': response.data['lastName'],
        'address': response.data['address'],
        'phoneNumber': response.data['phoneNumber'],
        'gender': response.data['gender'],
        'avatar': response.data['avatar'] ?? Constants.defaultAvatar,
      };
      await Storage.saveValue(CacheKey.USER_INFO.name, userInfo);

      Get.offNamed(Routes.NAVBAR);
      loginStatus.value = Status.success;
      return;
    }
    loginStatus.value = Status.fail;
  }

  Future<bool?> loginWithToken() async {
    final accessToken = Storage.getValue<String>(CacheKey.TOKEN.name);
    if (accessToken == null) return false;

    final response = await _apiAuth.getLoginWithToken(accessToken).futureValue();

    if (response != null) {
      if (response.isSuccess == true && response.statusCode == Constants.successGetStatusCode) {
        final userInfo = {
          'id': response.data['id'],
          'email': response.data['email'],
          'firstName': response.data['firstName'],
          'lastName': response.data['lastName'],
          'address': response.data['address'],
          'phoneNumber': response.data['phoneNumber'],
          'gender': response.data['gender'],
          'avatar': response.data['avatar'] ?? Constants.defaultAvatar,
        };
        await Storage.saveValue(CacheKey.USER_INFO.name, userInfo);
        return true;
      } else {
        return false;
      }
    }
    return null;
  }

  @override
  void onInit() {
    _apiAuth = Get.put(ApiAuthImpl());
    super.onInit();
  }
}
