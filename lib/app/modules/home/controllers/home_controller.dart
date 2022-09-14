import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/data/api_response.dart';
import 'package:hi_doctor_v2/app/data/response_model.dart';
import 'package:hi_doctor_v2/app/models/doctor.dart';
import 'package:hi_doctor_v2/app/modules/home/data/api_home.dart';

class HomeController extends GetxController {
  RxList<Doctor> doctorList = <Doctor>[].obs;
  late final ApiHomeImpl apiHome;

  // Add firebase messaging
  late final FirebaseMessaging _messaging;

  void registerNotification() async {
    // 1. Initialize the Firebase app
    await Firebase.initializeApp();

    // 2. Instantiate Firebase Messaging
    _messaging = FirebaseMessaging.instance;

    // 3. On iOS, this helps to take the user permissions
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );
    Get.snackbar('Notification', '${settings.authorizationStatus}');
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // Get.snackbar(message.notification!.title!.toString(), message.notification!.body!.toString());
    });
    'User granted permission: ${settings.authorizationStatus}'.debugLog('Permission');
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
      // TODO: handle the received notifications

      FirebaseMessaging.onMessageOpenedApp.listen((event) {
        print(event.notification!.title!.toString());
        print(event.notification!.title!.toString());
      });
      FirebaseMessaging.onBackgroundMessage((message) async {
        print('Backgound notification');
        return null;
      });
    } else {
      print('User declined or has not accepted permission');
    }
  }

  @override
  void onInit() {
    super.onInit();
    apiHome = Get.put(ApiHomeImpl());
    getDoctorList();
    registerNotification();
  }

  void getDoctorList({int page = 1, int limit = 10}) async {
    'Initializing data'.debugLog('HomeController');
    var result = await apiHome.getDoctorList(page: page, limit: limit);
    Map<String, dynamic> response = ApiResponse.getResponse(result);
    ResponseModel2 model = ResponseModel2.fromMap(response);
    var data = model.data as List<dynamic>;
    doctorList.value += data
        .map(
          (e) => Doctor(
            id: e['id'],
            email: e['email'],
            avatar: e['avatar'],
            firstName: e['firstName'],
            lastName: e['lastName'],
            dob: e['dob'],
            age: e['age'],
            phoneNumber: e['phoneNumber'],
            experienceYears: e['experienceYears'],
            gender: e['gender'],
          ),
        )
        .toList();
    update();
  }

  Future<RxList<Doctor>> getDoctors() async {
    return doctorList;
  }
}
