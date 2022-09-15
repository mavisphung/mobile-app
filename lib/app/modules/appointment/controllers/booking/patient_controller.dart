import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:hi_doctor_v2/app/modules/appointment/providers/api_book_appointment.dart';
import 'package:hi_doctor_v2/app/modules/appointment/providers/req_appointment_model.dart';

class PatientController extends GetxController {
  final problemController = TextEditingController();
  final rxDob = Strings.dob.tr.obs;
  late final ApiBookAppointmentImpl _apiBookAppointment;

  // String get dob => _rxDob.value;
  // final DateFormat _dateFormatter = DateFormat('yyyy-MM-dd');

  // set dob(String value) {
  //   _rxDob.value = value;
  // }

  void createAppointment(ReqAppointmentModel reqModel) async {
    final response = await _apiBookAppointment.postAppointment(reqModel).futureValue();
    if (response != null) {
      if (response.isSuccess == true && response.statusCode == Constants.successGetStatusCode) {
        print('===== BOOK SUCCESSFULLY =========');
        return;
      }
    }
    print('===== BOOK FAILED =========');
  }

  @override
  void dispose() {
    problemController.dispose();
    super.dispose();
  }

  @override
  void onInit() {
    _apiBookAppointment = Get.put(ApiBookAppointmentImpl());
    super.onInit();
  }
}
