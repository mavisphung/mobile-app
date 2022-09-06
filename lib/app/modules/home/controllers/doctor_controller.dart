import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/data/api_response.dart';
import 'package:hi_doctor_v2/app/data/response_model.dart';
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

  void getDoctorWithId(int id) async {
    var result = await apiDoctor.getDoctorWithId(id);
    Map<String, dynamic> response = ApiResponse.getResponse(result);
    ResponseModel2 model = ResponseModel2.fromMap(response);
    Map<String, dynamic> data = model.data as Map<String, dynamic>;
    rxDoctor.value = Doctor.fromMap(data);
    update();
  }
}
