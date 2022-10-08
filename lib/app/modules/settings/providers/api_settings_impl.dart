import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/storage/storage.dart';
import 'package:hi_doctor_v2/app/models/patient.dart';
import 'package:hi_doctor_v2/app/models/user_info.dart';
import 'package:hi_doctor_v2/app/modules/settings/providers/api_settings.dart';
import 'package:image_picker/image_picker.dart';

class ApiSettingsImpl extends GetConnect with ApiSettings {
  final Map<String, String> headers = {
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

  @override
  Future<Response> putUserProfile(UserInfo2 data) {
    return put(
      '/user/me/',
      data.toJson(),
      headers: headers,
    );
  }

  @override
  Future<Response> getPatientList({int page = 1, int limit = 10}) {
    return get(
      '/user/patients/data/',
      headers: headers,
      query: {
        'page': page.toString(),
        'limit': limit.toString(),
      },
    );
  }

  @override
  Future<Response> getPatientProfile(int patientId) {
    return get(
      '/user/patients/$patientId',
      headers: headers,
    );
  }

  @override
  Future<Response> postPatientProfile(Patient data) {
    return post(
      '/user/patients/',
      data.toJson(),
      headers: headers,
    );
  }

  @override
  Future<Response> putPatientProfile(
    int patientId,
    Patient data,
  ) {
    return put(
      '/user/patients/$patientId',
      data.toJson(),
      headers: headers,
    );
  }
}
