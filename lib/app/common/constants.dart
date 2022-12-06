import 'package:vnpay_flutter/vnpay_flutter.dart';

abstract class Constants {
  static const String baseUrl = 'http://capstone-elb-1141242582.ap-southeast-1.elb.amazonaws.com';
  // static const String baseUrl = 'http://192.168.1.12:8000';
  static const String baseUrl2 = 'capstone-elb-1141242582.ap-southeast-1.elb.amazonaws.com';
  // static const appId = '2379244a079c45098b6d9040bb37aa85';
  static const appId = '1ebd61600977424fba66c122d5c22576';
  static const agoraAppId = '2379244a079c45098b6d9040bb37aa85';
  static const timeout = Duration(seconds: 30);
  static const successGetStatusCode = 200;
  static const successPostStatusCode = 201;
  static const userType = 'MEMBER';
  static const defaultAvatar = 'https://cuu-be.s3.amazonaws.com/cuu-be/2022/10/27/668CGR.png';
  static const info = 'info';
  static const currentPage = 'currentPage';
  static const nextPage = 'nextPage';
  static const previousPage = 'previousPage';
  static const totalItems = 'totalItems';
  static const borderRadius = 10;
  static const textFieldRadius = 8;
  static const padding = 12.5;

  // firebase constants
  static const pathMessageCollection = 'messages';
  static const supervisorId = 'supervisorId';
  static const doctorId = 'doctorId';
  static const doctorAccountId = 'doctorAccountId';
  static const lastMessage = 'lastMessage';
  static const lastTimeStamp = 'lastTimeStamp';
  static const senderId = 'senderId';
  static const receiverId = 'receiverId';
  static const content = 'content';
  static const createdAt = 'createdAt';
  static const type = 'type';
}

abstract class SocialPlatform {
  static const String google = 'GOOGLE';
  static const String facebook = 'FACEBOOK';
}

abstract class VNPayConfig {
  static const String url = 'https://sandbox.vnpayment.vn/paymentv2/vpcpay.html';
  static const String version = '2.0.1';
  static const String tmnCode = 'IZC396TJ';
  static const String hashKey = 'CQCQNOCFNKEQYSFXWPOJHOPXWGUJUZYF';
  static const VNPayHashType hashKeyType = VNPayHashType.HMACSHA512;
}

abstract class CancelReason {
  static const String item1 = 'Tôi bận việc đột xuất';
  static const String item2 = 'Tôi cảm thấy bác sĩ không uy tín như lúc đầu';
  static const String item3 = 'Tôi cảm thấy không an toàn';
  static const String item4 = 'Bệnh nhân bận việc đột xuất';
  static const String itemOther = 'Khác';

  static List<String> reasons = [item1, item2, item3, item4, itemOther];
}

abstract class PaymentInfo {
  static const String accountNo = '9704198526191432198';
  static const String name = 'NGUYEN VAN A';
  static const String otp = '123456';
  static const String expiry = '07/15';
  static const String bankName = 'NCB';
}

abstract class NotificationResponse {
  static const String checkInOnlineSucceeded = 'APPOINTMENT_ONLINE_CHECK_IN';
}
