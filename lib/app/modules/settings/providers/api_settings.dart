import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../models/user_info.dart';

abstract class ApiSettings {
  Future<Response> getPresignedUrls(List<XFile> images);
  Future<Response> updateProfile(UserInfo2 data);
}
