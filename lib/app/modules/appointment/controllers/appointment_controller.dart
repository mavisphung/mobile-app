import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/common/util/enum.dart';
import 'package:hi_doctor_v2/app/data/api_response.dart';
import 'package:hi_doctor_v2/app/data/response_model.dart';
import 'package:hi_doctor_v2/app/models/appointment.dart';
import 'package:hi_doctor_v2/app/modules/appointment/models/filter_model.dart';
import 'package:hi_doctor_v2/app/modules/appointment/providers/api_appointment.dart';

class AppointmentController extends GetxController {
  RxList<Appointment> historyList = <Appointment>[].obs;
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
  Rx<Status> historyTabStatus = Status.init.obs;
  // scroll controller
  late ScrollController historyScrollController;

  late ApiAppointmentImpl apiAppointment;

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

  void clearHistoryList() {
    historyList.clear();
    update();
  }

  void getUserHistoricalAppointments({int page = 1, int limit = 10}) async {
    'loading historical appointments'.debugLog('HistoryTab');
    historyTabStatus.value = Status.loading;
    update();
    Response result = await apiAppointment.getUserHistoricalAppointments(page: page, limit: limit);
    var response = ApiResponse.getResponse(result);
    ResponseModel2 model = ResponseModel2.fromMap(response);
    var data = model.data as List<dynamic>;
    historyList.value += data.map((e) {
      // print(e['bookedAt']);
      return Appointment(
        beginAt: e['beginAt'],
        id: e['id'],
        status: e['status'],
        category: e['category'],
        doctor: e['doctor'],
        checkInCode: e['checkInCode'],
        bookedAt: e['bookedAt'],
      );
    }).toList();
    // print(incomingList.value);
    historyTabStatus.value = Status.success;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    historyScrollController = ScrollController();
    historyScrollController.addListener(() {
      'Scrolling...'.debugLog('historyScrollController');
    });
    apiAppointment = Get.put(ApiAppointmentImpl());
    getUserHistoricalAppointments(page: 1, limit: 10);
  }

  @override
  void dispose() {
    historyList.close();
    filterModel.close();
    historyTabStatus.close();
    selectedTypeObx.close();
    selectedStatusObx.close();
    apiAppointment.dispose();
    super.dispose();
  }
}
