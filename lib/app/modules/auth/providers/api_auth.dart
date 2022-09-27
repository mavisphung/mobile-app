import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/modules/auth/providers/req_auth_model.dart';

abstract class ApiAuth {
  Future<Response> postLogin(String email, String password);
  Future<Response> getLoginWithToken(String accessToken);
  Future<Response> postCheckEmailExisted(String email);
  Future<Response> postRegister(RequestRegisterModel reqBody);
  Future<Response> postActivateAccount(String email, String code);
  Future<Response> postResendOtp(String email);
}
