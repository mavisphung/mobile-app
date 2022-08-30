import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/data/api_response.dart';
import 'package:hi_doctor_v2/app/models/appointment.dart';
import 'package:hi_doctor_v2/app/models/response.dart';
import 'package:hi_doctor_v2/app/modules/history/data/api_history.dart';
import 'package:hi_doctor_v2/app/modules/history/models/filter_model.dart';

enum LoadingEvent { init, refresh, loadMore, nothing }

class HistoryController extends GetxController {
  RxList<Appointment> incomingList = <Appointment>[].obs;
  RxList<Appointment2> historyList = <Appointment2>[].obs;
  List<AppointmentType> types = AppointmentType.values;
  List<AppointmentStatus> statuses = AppointmentStatus.values;

  Rx<FilterModel> filterModel = FilterModel(
    type: AppointmentType.all.value,
    status: AppointmentStatus.all.value,
    isTypeChosen: false,
    isStatusChosen: false,
  ).obs;
  RxBool isOnline = true.obs;
  Rx<AppointmentType> selectedTypeObx = AppointmentType.all.obs;
  Rx<AppointmentStatus> selectedStatusObx = AppointmentStatus.all.obs;

  late ApiHistoryImpl apiHistory;

  void setFilterType(String type) {
    filterModel.value.type = type;
  }

  FilterModel get filter => filterModel.value;

  AppointmentType get selectedType => selectedTypeObx.value;

  void setAppointmentType(AppointmentType type) {
    selectedTypeObx.value = type;
    update();
  }

  AppointmentStatus get selectedStatus => selectedStatusObx.value;

  void setAppointmentStatus(AppointmentStatus status) {
    selectedStatusObx.value = status;
    update();
  }

  void clearList() {
    incomingList.clear();
    historyList.clear();
    update();
  }

  void clearIncomingList() {
    incomingList.clear();
    update();
  }

  void clearHistoryList() {
    historyList.clear();
    update();
  }

  void getUserIncomingAppointments({int page = 1, int limit = 10}) async {
    Response result = await apiHistory.getUserIncomingAppointments(page: page, limit: limit);
    var response = ApiResponse.getResponse(result);
    ResponseModel2 model = ResponseModel2.fromMap(response);
    var data = model.data as List<dynamic>;
    incomingList.value += data.map((e) {
      // print(e['bookedAt']);
      return Appointment(
        beginAt: e['beginAt'],
        id: e['id'],
        status: e['status'],
        type: e['type'],
        doctor: e['doctor'],
        checkInCode: e['checkInCode'],
        bookedAt: e['bookedAt'],
      );
    }).toList();
    // print(incomingList.value);
    update();
  }

  @override
  void onInit() {
    super.onInit();
    apiHistory = Get.put(ApiHistoryImpl());
    getUserIncomingAppointments(page: 1, limit: 10);
  }

  @override
  void dispose() {
    incomingList.close();
    historyList.close();
    filterModel.close();
    selectedTypeObx.close();
    selectedStatusObx.close();
    apiHistory.dispose();
    super.dispose();
  }
}
