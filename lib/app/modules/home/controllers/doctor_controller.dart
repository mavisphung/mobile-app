import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/util/extensions.dart';

import 'package:hi_doctor_v2/app/models/doctor.dart';
import 'package:hi_doctor_v2/app/modules/home/data/api_doctor.dart';

class DoctorController extends GetxController {
  final ApiDoctorImpl apiDoctor = Get.put(ApiDoctorImpl());
  Rx<Doctor> rxDoctor = Doctor().obs;
  RxBool isFavorite = false.obs;

  Doctor get doctor => rxDoctor.value;

  void setFavorite(bool value) {
    isFavorite.value = value;
    update();
  }

  @override
  void dispose() {
    apiDoctor.dispose();
    rxDoctor.close();
    isFavorite.close();
    super.dispose();
  }

  Future<bool> getDoctorWithId(int id) async {
    var response = await apiDoctor.getDoctorWithId(id).futureValue();

    if (response != null && response.isSuccess == true) {
      rxDoctor.value = Doctor.fromMap(response.data);
      response.data.toString().debugLog('Doctor');
      return true;
    }

    return false;
  }
}
