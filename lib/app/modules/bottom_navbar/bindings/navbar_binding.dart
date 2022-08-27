import 'package:get/get.dart';

import '../../home/controllers/home_controller.dart';
import '../../settings/controllers/settings_controller.dart';
import '../controllers/navbar_controller.dart';

class NavBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavBarController>(() => NavBarController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<SettingsController>(() => SettingsController());
    // Get.lazyPut<HistoryController>(() => HistoryController());
  }
}
