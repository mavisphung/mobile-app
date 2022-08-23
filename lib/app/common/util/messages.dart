import 'package:get/get.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'login': 'Login',
          'registration': 'Registration',
          'sign_in': 'Sign In',
          'sign_up': 'Sign Up',
          'alert': 'Alert',
          'close_app_alert': 'Close app alert',
          'policy_agree_alert': 'Policy agreement Alert',
          'home': 'Home',
          'unauthorized': 'Unauthorized',
          'exit_app_msg': 'Do you want to close the app?',
          'con_time_out_msg': 'Connection timeout. Please try again later.',
          'no_con_msg':
              'No connection. Please check your connection or turn on internet.',
          'unknown_err_msg':
              'The system occurs unknown error. Please try later.',
          'login_failed_msg': 'Wrong email or password',
          'invalid_input_msg': 'Your input is invalid.',
          'format_err_msg': 'Format Error message',
          'unauthorized_err_msg': 'Your action has not authorized yet.',
          'system_err_msg': 'The system has problem. Please try later.',
          'policy_agree_need_msg':
              'Please make sure you agreed with our policy.',
          'policy_agree_msg':
              'Creating an account means you\'re agreed with our Terms of Service, Privacy Policy, and our default Notification Settings.',
          'register_success': 'Registration success',
          'register_success_msg': 'Register your account successfully.',
          'otp_incorrect_msg': 'OTP @code is incorect.',
        },
      };
}
