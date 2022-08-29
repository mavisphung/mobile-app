import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/data/api_response.dart';
import 'package:hi_doctor_v2/app/models/appointment.dart';
import 'package:hi_doctor_v2/app/models/response.dart';
import 'package:hi_doctor_v2/app/modules/history/data/api_history.dart';
import 'package:hi_doctor_v2/app/modules/history/models/filter_model.dart';

class HistoryController extends GetxController {
  RxList<Appointment> incomingList = <Appointment>[].obs;
  RxList<Appointment> completedList = <Appointment>[].obs;
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

  void getUserAppointments() async {
    Response result = await apiHistory.getUserAppointments();
    String response = ApiResponse.getResponse(result);
    ResponseModel2 model = ResponseModel2.fromJson(response);
    incomingList.value = model.data;
    print(incomingList.value);
  }

  @override
  void onInit() {
    super.onInit();
    apiHistory = Get.put(ApiHistoryImpl());
  }

  @override
  void dispose() {
    incomingList.close();
    completedList.close();
    filterModel.close();
    selectedTypeObx.close();
    selectedStatusObx.close();
    apiHistory.dispose();
    super.dispose();
  }
}
