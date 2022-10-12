import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/storage/box.dart';
import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/data/api_response.dart';
import 'package:hi_doctor_v2/app/data/response_model.dart';
import 'package:hi_doctor_v2/app/models/doctor.dart';
import 'package:hi_doctor_v2/app/models/specialist.dart';
import 'package:hi_doctor_v2/app/models/user_info.dart';
import 'package:hi_doctor_v2/app/modules/home/data/api_home.dart';

class HomeController extends GetxController {
  RxList<Doctor> doctorList = <Doctor>[].obs;
  RxList<Specialist> specialistList = <Specialist>[].obs;
  RxList<Doctor> nearestList = <Doctor>[].obs;
  late final ApiHomeImpl apiHome;

  UserInfo2? userInfo = Box.userInfo;

  @override
  void onInit() {
    super.onInit();
    apiHome = Get.put(ApiHomeImpl());
    getDoctorList();
    getSpecialistsApi();
    getNearestDoctorsApi(address: userInfo?.address);
  }

  void getNearestDoctorsApi({String? address = '218 Hồng Bàng, Phường 15, Quận 5, Thành phố Hồ Chí Minh, Việt Nam', int page = 1, int limit = 10}) async {
    'Fetching nearest doctors'.debugLog('HomeController');
    final result = await apiHome.getNearestDoctors(page: page, limit: limit);
    final Map<String, dynamic> response = ApiResponse.getResponse(result);
    final model = ResponseModel2.fromMap(response);
    final data = model.data as List<dynamic>;
    nearestList.value += data.map((e) => Doctor.fromMap(e)).toList();
    update();
  }

  void getDoctorList({int page = 1, int limit = 10}) async {
    'Initializing data'.debugLog('HomeController');
    final result = await apiHome.getDoctorList(page: page, limit: limit);
    final Map<String, dynamic> response = ApiResponse.getResponse(result);
    final model = ResponseModel2.fromMap(response);
    final data = model.data as List<dynamic>;
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
            specialists: e['specialists'],
          ),
        )
        .toList();
    update();
  }

  void getSpecialistsApi({int page = 1, int limit = 10}) async {
    'Fetching specialists'.debugLog('HomeController');
    final result = await apiHome.getSpecialists(page: page, limit: limit);
    final Map<String, dynamic> response = ApiResponse.getResponse(result);
    final model = ResponseModel2.fromMap(response);
    final data = model.data as List<dynamic>;
    specialistList.value += data
        .map(
          (e) => Specialist.fromMap(e),
        )
        .toList();
    update();
  }

  Future<RxList<Doctor>> getDoctors() async {
    return doctorList;
  }

  Future<RxList<Specialist>> getSpecialists() async {
    return specialistList;
  }
}
