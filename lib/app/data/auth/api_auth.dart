import 'package:get/get.dart';

abstract class ApiAuth {
  // static ApiAuth get apiObj => Get.find();

  Future<Response> postLogin(String email, String password);
  Future<Response> postLoginWithToken(String accessToken);
  Future<Response> postCheckEmailExisted(String email);
  Future<Response> postRegister(
    String email,
    String password,
    String confirmPassword,
    String firstName,
    String lastName,
    String phoneNumber,
    String address,
    String gender,
  );
  Future<Response> postActivateAccount(String email, String code);
  Future<Response> postResendOtp(String email);
}
