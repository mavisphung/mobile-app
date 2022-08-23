import 'package:get/get.dart';

import '../../../common/storage/storage.dart';
import '../../../common/util/extensions.dart';
import '../../../common/util/utils.dart';
import '../../../data/auth/api_auth.dart';
import '../../../data/auth/api_auth_impl.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  var isPasswordObscure = true.obs;
  late final ApiAuth _apiAuth;

  Future<void> login(String email, String password) async {
    Utils.unfocus();
    final response = await _apiAuth.postLogin(email, password).futureValue();
    if (response != null && response.isSuccess == true && response.statusCode == 201) {
      await Storage.saveValue(CacheKey.TOKEN.name, response.data['accessToken']);
      await Storage.saveValue(CacheKey.IS_LOGGED.name, true);
      Get.offNamed(Routes.HOME);
      Utils.showTopSnackbar('Login success');
    }
  }

  Future<bool?> loginWithToken() async {
    final accessToken = Storage.getValue<String>(CacheKey.TOKEN.name);
    if (accessToken != null) {
      final response = await _apiAuth.postLoginWithToken(accessToken).futureValue(showLoading: false);

      if (response != null) {
        if (response.isSuccess == true && response.statusCode == 200) {
          return true;
        } else {
          return false;
        }
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
