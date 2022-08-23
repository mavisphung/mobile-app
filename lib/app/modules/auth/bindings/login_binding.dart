import 'package:get/get.dart';

import '../../../data/auth/api_auth.dart';
import '../../../data/auth/api_auth_impl.dart';
import '../controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );
    Get.lazyPut<ApiAuth>(() => ApiAuthImpl());
  }
}
