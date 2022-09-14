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
          Strings.appointment: 'Appointment',
          Strings.message: 'Message',
          Strings.settings: 'Settings',
          Strings.policyAgreementMsg:
              'Creating an account means you\'re agreed with our Terms of Service, Privacy Policy, and our default Notification Settings.',
          Strings.upcomingAppointment: 'Upcoming appointment',
          Strings.category: 'Categories',
          Strings.latestSearchDoctor: 'Latest search doctors',

          // Verb, Adjective
          Strings.ok: 'Ok',
          Strings.yes: 'Yes',
          Strings.no: 'No',
          Strings.back: 'Back',
          Strings.kContinue: 'Continue',
          Strings.login: 'Login',
          Strings.signIn: 'Sign in',
          Strings.signUp: 'Sign up',
          Strings.verify: 'Verify',
          Strings.alert: 'Alert',
          Strings.registerSuccess: 'Registration success',
          Strings.exitAppAlert: 'Press double back to exit app',
          Strings.seeAll: 'See all',

          // Information Message
          Strings.registerSuccessMsg: 'Register your account successfully.',
          Strings.updateProfileMsg: 'Update your profile successfully.',

          // Alert Message
          Strings.policyAgreementNeedMsg: 'Please make sure you agreed with our policy.',
          Strings.logoutConfirmMsg: 'Are you sure you want to log out?',
          Strings.cantBeEmpty: "can't be empty",
          Strings.fieldCantBeEmpty: 'Field ${Strings.cantBeEmpty.tr}',
          Strings.emailCantBeEmpty: 'Email ${Strings.cantBeEmpty.tr}',
          Strings.enterValidEmail: 'Please enter a valid email',
          Strings.duplicatedEmail: 'Email is duplicated',
          Strings.passCantBeEmpty: 'Password ${Strings.cantBeEmpty.tr}',
          Strings.passLengthtMsg: 'Password must has at least 6 characters',
          Strings.confirmPassCantBeEmpty: 'Confirm pasword ${Strings.cantBeEmpty.tr}',
          Strings.confirmPassLengthtMsg: 'Confirm password must has at least 6 characters',
          Strings.confirmPassNotMatchMsg: 'Confirm password is not matched',
          Strings.enterValidPhone: 'Phone number must have 10 numbers',
          Strings.otpLengthMsg: 'Otp must have 6 digits',

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
        'vi_VN': {
          // Noun
          Strings.appName: 'Hi Doctor',
          Strings.registration: 'Đăng ký',
          Strings.verification: 'Xác nhận',
          Strings.email: 'Địa chỉ email',
          Strings.pasword: 'Mật khẩu',
          Strings.confirmPasword: 'Xác nhận mật khẩu',
          Strings.firstName: 'Tên',
          Strings.lastName: 'Họ',
          Strings.address: 'Địa chỉ',
          Strings.gender: 'Giới tính',
          Strings.phoneNumber: 'Số điện thoại',
          Strings.male: 'Nam',
          Strings.female: 'Nữ',
          Strings.other: 'Khác',
          Strings.home: 'Trang chủ',
          Strings.appointment: 'Cuộc hẹn',
          Strings.message: 'Tin nhắn',
          Strings.settings: 'Cài đặt',
          Strings.policyAgreementMsg:
              'Creating an account means you\'re agreed with our Terms of Service, Privacy Policy, and our default Notification Settings.',
          Strings.upcomingAppointment: 'Upcoming appointment',
          Strings.category: 'Thể loại',
          Strings.latestSearchDoctor: 'Bác sĩ đã xem gần đây',

          // Verb, Adjective
          Strings.ok: 'Đồng ý',
          Strings.yes: 'Có',
          Strings.no: 'Không',
          Strings.back: 'Quay lại',
          Strings.kContinue: 'Tiếp tục',
          Strings.login: 'Đăng nhập',
          Strings.signIn: 'Đăng nhập',
          Strings.signUp: 'Đăng ký',
          Strings.verify: 'Xác nhận',
          Strings.alert: 'Cảnh báo',
          Strings.registerSuccess: 'Đăng ký tài khoản',
          Strings.exitAppAlert: 'Bấm quay lại 2 lần để thoát ứng dụng',
          Strings.seeAll: 'Xem tất cả',

          // Information Message
          Strings.registerSuccessMsg: 'Bạn đã đăng ký tài khoản thành công.',
          Strings.updateProfileMsg: 'Bạn đã cập nhật thông tin tài khoản thành công.',

          // Alert Message
          Strings.policyAgreementNeedMsg: 'Xin hãy chắc chắn bạn đã đồng ý với điều khoản của chúng tôi.',
          Strings.logoutConfirmMsg: 'Bạn có chắc muốn đăng xuất khỏi tài khoản?',
          Strings.cantBeEmpty: "không thể bỏ trống",
          Strings.fieldCantBeEmpty: 'Thông tin ${Strings.cantBeEmpty.tr}',
          Strings.emailCantBeEmpty: 'Email ${Strings.cantBeEmpty.tr}',
          Strings.enterValidEmail: 'Địa chỉ email không hợp lệ',
          Strings.duplicatedEmail: 'Địa chỉ email này đã có tài khoản',
          Strings.passCantBeEmpty: 'Mật khẩu ${Strings.cantBeEmpty.tr}',
          Strings.passLengthtMsg: 'Mật khẩu phải có ít nhất 6 ký tự',
          Strings.confirmPassCantBeEmpty: 'Xin hãy xác nhận lại mật khẩu',
          Strings.confirmPassLengthtMsg: 'Xác nhận mật khẩu phải có ít nhất 6 ký tự',
          Strings.confirmPassNotMatchMsg: 'Xác nhận mật khẩu không khớp',
          Strings.enterValidPhone: 'Số điện thoại phải có 10 số',
          Strings.otpLengthMsg: 'Mã xác thực phải có 6 ký tự',

          // Error Message
          Strings.unknownErrMsg: 'The system occurs unknown error. Please try later.',
          Strings.systemErrMsg: 'The system has problem. Please try later.',
          Strings.conTimeOutMsg: 'Kết nối hết hạn. Xin hãy thử lại sau',
          Strings.noConMsg: 'Không có kết nối mạng. Xin hãy kiểm tra kết nối của bạn.',
          Strings.invalidInputMsg: 'Thông tin bạn nhập không hợp lệ.',
          Strings.formatErrMsg: 'Lỗi định dạng đã xảy ra',
          Strings.unauthorizedErrMsg: 'Your action has not authorized yet.',
          Strings.loginFailedMsg: 'Địa chỉ email hoặc mật khẩu không đúng.',
          Strings.otpErrorMsg: 'Mã xác thực @code không đúng.',
          Strings.otpExpiredMsg: 'Mã xác thực đã hết hạn',
        },
      };
}
