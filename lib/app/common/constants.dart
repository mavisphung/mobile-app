abstract class Constants {
  static const String baseUrl = 'http://capstone-elb-1141242582.ap-southeast-1.elb.amazonaws.com';
  // static const String baseUrl = 'http://192.168.1.12:8000';
  static const String baseUrl2 = 'capstone-elb-1141242582.ap-southeast-1.elb.amazonaws.com';
  // static const appId = '2379244a079c45098b6d9040bb37aa85';
  static const appId = '1ebd61600977424fba66c122d5c22576';
  static const timeout = Duration(seconds: 30);
  static const successGetStatusCode = 200;
  static const successPostStatusCode = 201;
  static const userType = 'MEMBER';
  static const defaultAvatar = 'https://cuu-be.s3.amazonaws.com/cuu-be/2022/6/28/O2VWFV.png';
  static const info = 'info';
  static const currentPage = 'currentPage';
  static const nextPage = 'nextPage';
  static const previousPage = 'previousPage';
  static const totalItems = 'totalItems';
  static const borderRadius = 20;
  static const textFieldRadius = 15;
  static const padding = 12.5;

  // firebase constants
  static const pathMessageCollection = 'messages';
  static const supervisorId = 'supervisorId';
  static const doctorId = 'doctorId';
  static const lastMessage = 'lastMessage';
  static const lastTimeStamp = 'lastTimeStamp';
  static const senderId = 'senderId';
  static const receiverId = 'receiverId';
  static const content = 'content';
  static const createdAt = 'createdAt';
  static const type = 'type';
}
