import 'package:get/state_manager.dart';
import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/models/appointment.dart';
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

  @override
  void dispose() {
    incomingList.close();
    completedList.close();
    filterModel.close();
    selectedTypeObx.close();
    selectedStatusObx.close();
    super.dispose();
  }
}
