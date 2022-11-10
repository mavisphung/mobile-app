import 'dart:convert';

import 'package:get/get.dart';

import '../../../common/constants.dart';
import './api_auth.dart';
import './req_auth_model.dart';

class ApiAuthImpl extends GetConnect with ApiAuth {
  @override
  void onInit() {
    httpClient.baseUrl = Constants.baseUrl;
    httpClient.timeout = Constants.timeout;

    httpClient.addRequestModifier<dynamic>((request) {
      printInfo(
        info: 'REQUEST ║ ${request.method.toUpperCase()}\n'
            'url: ${request.url}\n'
            'Headers: ${request.headers}\n'
            'Body: ${request.files?.toString() ?? ''}\n',
      );
      return request;
    });
    super.onInit();
  }

  @override
  Future<Response> postLogin(String email, String password) {
    return post('/login/', RequestLoginModel(email: email, password: password).toJson());
  }

  @override
  Future<Response> getLoginWithToken(String accessToken) {
    return get(
      '/user/me',
      headers: {
        "Authorization": "Bearer $accessToken",
      },
    );
  }

  @override
  Future<Response> postCheckEmailExisted(String email) {
    return post(
      '/user/existed/',
      json.encode({
        "email": email,
      }),
    );
  }

  @override
  Future<Response> postRegister(RequestRegisterModel reqBody) {
    return post(
      '/register/',
      reqBody.toJson(),
    );
  }

  @override
  Future<Response> postActivateAccount(String email, String code) {
    return post(
      '/user/activate/',
      json.encode({
        "email": email,
        "code": code,
      }),
    );
  }

  @override
  Future<Response> postResendOtp(String email) {
    return post(
      '/user/resend-code/',
      json.encode({
        "email": email,
      }),
    );
  }

  @override
  Future<Response> postGoogleLogin(String accessToken) {
    return post(
      '/social-login/',
      json.encode({
        "platform": SocialPlatform.google,
        "id": accessToken,
      }),
    );
  }
}
