import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/storage/storage.dart';
import 'package:hi_doctor_v2/app/data/auth/api_auth_model.dart';
import 'package:hi_doctor_v2/app/models/user_info.dart';
import 'package:hi_doctor_v2/app/modules/settings/providers/settings_provider.dart';

class SettingsController extends GetxController {
  TextEditingController emailController = TextEditingController();
  final SettingsProvider _provider = Get.put(SettingsProvider());

  @override
  void dispose() {
    emailController.dispose();
    _provider.dispose();
    super.dispose();
  }

  void logout() async {
    await Storage.clearStorage();
  }

  Future<UserInfo2> getUserInfo() async {
    Response response = await _provider.getUserInfo();
    UserInfo2 data = UserInfo2();
    switch (response.statusCode) {
      case 200: // Success
      case 201:
        ResponseModel model = ResponseModel.fromJson(response.body);
        data = UserInfo2.fromMap(model.data);
        break;
      default:
        print('error ${response.statusCode!}');
        break;
    }

    return data;
  }
}
