import 'package:get/get.dart';

class PackageController extends GetxController {
  RxInt rxDurationId = (-1).obs;
  RxInt rxDuration = 0.obs;

  int get duration => rxDuration.value;

  set duration(int value) {
    rxDuration.value = value;
    update();
  }

  RxInt rxServiceId = 0.obs;

  int get serviceId => rxServiceId.value;

  set serviceId(int serviceId) {
    rxServiceId.value = serviceId;
    update();
  }

  int get durationId => rxDurationId.value;

  void setDurationId(int value) {
    rxDurationId.value = value;
    update();
  }

  @override
  void dispose() {
    rxDurationId.close();
    rxServiceId.close();
    super.dispose();
  }
}
