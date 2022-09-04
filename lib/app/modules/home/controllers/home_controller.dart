import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/data/api_response.dart';
import 'package:hi_doctor_v2/app/models/doctor.dart';
import 'package:hi_doctor_v2/app/models/response.dart';
import 'package:hi_doctor_v2/app/modules/home/data/api_home.dart';

class HomeController extends GetxController {
  RxList<Doctor> doctorList = <Doctor>[].obs;
  late final ApiHomeImpl apiHome;

  @override
  void onInit() {
    super.onInit();
    apiHome = Get.put(ApiHomeImpl());
    getDoctorList();
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
