import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/models/patient.dart';
import 'package:image_picker/image_picker.dart';

import '../../../models/user_info.dart';

abstract class ApiSettings {
  Future<Response> postPresignedUrls(List<XFile> images);
  Future<Response> putUserProfile(UserInfo2 data);
  Future<Response> getPatientList();
  Future<Response> getPatientProfile(int id);
  Future<Response> postPatientProfile(Patient data);
}
