import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/constants.dart';
import '../../../common/storage/storage.dart';
import '../../../models/user_info.dart';
import './api_settings.dart';

class ApiSettingsImpl extends GetConnect with ApiSettings {
  Map<String, String> headers = {
    'Authorization': 'Bearer ${Storage.getValue<String>(CacheKey.TOKEN.name)}',
  };

  @override
  void onInit() {
    httpClient.baseUrl = Constants.baseUrl;
    httpClient.timeout = Constants.timeout;
  }

  Future<Response> getProfile() {
    return get(
      '/user/me/',
      headers: headers,
    );
  }

  @override
  Future<Response> getPresignedUrls(List<XFile> images) {
    Map<String, dynamic> body = {};
    List<Map<String, dynamic>> list = images.map<Map<String, dynamic>>(
      (e) {
        double size = (File(e.path)).lengthSync() / 1024 / 1024;
        Map<String, dynamic> temp = {
          'ext': e.name.split('.')[1],
          'size': size,
        };
        // print(temp);
        return temp;
      },
    ).toList();
    body.assign(
      'images',
      list,
    );
    print('body $body');
    String bodyJson = json.encode(body);
    return post(
      '/get-presigned-urls/',
      bodyJson,
    );
  }

  @override
  Future<Response> updateProfile(UserInfo2 data) {
    return put(
      '/user/me/',
      data.toJson(),
      headers: headers,
    );
  }
}
