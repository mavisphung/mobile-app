import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../models/user_info.dart';

abstract class ApiSettings {
  // static ApiSettings get apiObj => Get.find();

  Future<Response> getPresignedUrls(List<XFile> image);
  Future<Response> updateProfile(UserInfo2 data);
}
