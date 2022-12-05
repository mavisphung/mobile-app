import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:hi_doctor_v2/app/common/constants.dart';

class ApiCustom extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = Constants.baseUrl;
    httpClient.timeout = Constants.timeout;
    super.onInit();
  }

  Future<Response> postPresignedUrls(List<XFile> images) {
    Map<String, dynamic> body = {};
    List<Map<String, dynamic>> list = images.map<Map<String, dynamic>>(
      (e) {
        print('======== LENGTHSYNC: ${File(e.path).lengthSync()}');
        double size = File(e.path).lengthSync() / 1024 / 1024;
        Map<String, dynamic> temp = {
          'ext': e.name.split('.')[1],
          'size': size,
        };
        print('======== TEMP: $temp');
        return temp;
      },
    ).toList();
    body.assign(
      'images',
      list,
    );
    print('body: $body');
    String bodyJson = json.encode(body);
    return post(
      '/get-presigned-urls/',
      bodyJson,
    );
  }
}
