import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:hi_doctor_v2/app/models/patient.dart';
import 'package:hi_doctor_v2/app/models/user_info.dart';

abstract class ApiSettings {
  Future<Response> postPresignedUrls(List<XFile> images);
  Future<Response> putUserProfile(UserInfo2 data);
  Future<Response> getPatientList();
  Future<Response> getPatientProfile(int patientId);
  Future<Response> postPatientProfile(Patient data);
  Future<Response> putPatientProfile(int patientId, Patient data);
}
