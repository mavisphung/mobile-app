import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/modules/home/data/api_home.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<ApiHomeImpl>(() => ApiHomeImpl());
  }
}
