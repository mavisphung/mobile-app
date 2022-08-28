import 'package:get/get.dart';

import '../values/strings.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          // Noun
          Strings.appName: 'Hi Doctor',
          Strings.registration: 'Registration',
          Strings.verification: 'Verification',
          Strings.email: 'Email',
          Strings.pasword: 'Password',
          Strings.confirmPasword: 'Confirm password',
          Strings.firstName: 'First name',
          Strings.lastName: 'Last name',
          Strings.address: 'Address',
          Strings.gender: 'Gender',
          Strings.phoneNumber: 'Phone number',
          Strings.male: 'Male',
          Strings.female: 'Female',
          Strings.other: 'Other',
          Strings.home: 'Home',
          Strings.policyAgreementMsg:
              'Creating an account means you\'re agreed with our Terms of Service, Privacy Policy, and our default Notification Settings.',

          // Verb, Adjective
          Strings.ok: 'Ok',
          Strings.yes: 'Yes',
          Strings.no: 'No',
          Strings.back: 'Back',
          Strings.back: 'Back',
          Strings.kContinue: 'Continue',
          Strings.login: 'Login',
          Strings.signIn: 'Sign in',
          Strings.signUp: 'Sign up',
          Strings.verify: 'Verify',
          Strings.alert: 'Alert',
          Strings.registerSuccess: 'Registration success',
          Strings.exitAppAlert: 'Press double back to exit app',
          Strings.policyAgreementAlert: 'Policy agreement Alert',

          // Information Message
          Strings.registerSuccessMsg: 'Register your account successfully.',

          // Alert Message
          Strings.policyAgreementNeedMsg: 'Please make sure you agreed with our policy.',
          Strings.logoutConfirmMsg: 'Are you sure you want to log out?',
          Strings.cantBeEmpty: "can't be empty",
          Strings.fieldCantBeEmpty: 'Field ${Strings.cantBeEmpty.tr}',
          Strings.emailCantBeEmpty: 'Email ${Strings.cantBeEmpty.tr}',
          Strings.enterValidEmail: 'Please enter a valid email',
          Strings.duplicatedEmail: 'Email is duplicated',
          Strings.enterValidPhone: 'Phone number must have 10 numbers',
          Strings.passCantBeEmpty: 'Password ${Strings.cantBeEmpty.tr}',
          Strings.passLengthtMsg: 'Password must has at least 6 characters',
          Strings.confirmPassCantBeEmpty: 'Confirm pasword ${Strings.cantBeEmpty.tr}',
          Strings.confirmPassLengthtMsg: 'Confirm password must has at least 6 characters',
          Strings.confirmPassNotMatchMsg: 'Confirm password is not matched',

          // Error Message
          Strings.unknownErrMsg: 'The system occurs unknown error. Please try later.',
          Strings.systemErrMsg: 'The system has problem. Please try later.',
          Strings.conTimeOutMsg: 'Connection timeout. Please try again later.',
          Strings.noConMsg: 'No connection. Please check your connection or turn on internet.',
          Strings.invalidInputMsg: 'Your input is invalid.',
          Strings.formatErrMsg: 'Format Error message',
          Strings.unauthorizedErrMsg: 'Your action has not authorized yet.',
          Strings.loginFailedMsg: 'Wrong email or password',
          Strings.otpErrorMsg: 'OTP @code is incorect.',
          Strings.otpExpiredMsg: 'Verification code expired',
        },
      };
}
