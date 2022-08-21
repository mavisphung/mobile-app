import 'package:get/get.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'login': 'Login',
          'register': 'Register',
          'sign_in': 'Sign In',
          'sign_up': 'Sign Up',
          'home': 'Home',
          'unauthorized': 'Unauthorized',
          'con_time_out_msg': 'Connection timeout. Please try again later.',
          'no_con_msg':
              'No connection. Please check your connection or turn on internet.',
          'unknown_err_msg':
              'The system occurs unknown error. Please try later.',
        },
      };
}
