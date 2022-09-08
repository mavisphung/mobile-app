import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:intl/intl.dart';

class PatientController extends GetxController {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController problemController = TextEditingController();
  Rx<DateTime> _rxDob = DateTime.now().obs;

  DateTime get dob => _rxDob.value;
  final DateFormat _dateFormatter = DateFormat('yyyy-MM-dd');

  set dob(DateTime value) {
    _rxDob.value = value;
  }

  final Rx<Gender> _rxGender = Gender.init.obs;

  Gender get gender => _rxGender.value;

  set gender(Gender value) {
    _rxGender.value = value;
    update();
  }

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    problemController.dispose();
    _rxGender.close();
    super.dispose();
  }
}
