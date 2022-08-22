import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/modules/bottom_navbar/controllers/navbar_controller.dart';
import 'package:hi_doctor_v2/app/modules/home/controllers/home_controller.dart';
import 'package:hi_doctor_v2/app/modules/settings/controllers/settings_controller.dart';

class NavBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavBarController>(() => NavBarController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<SettingsController>(() => SettingsController());
    // Get.lazyPut<HistoryController>(() => HistoryController());
  }
}
