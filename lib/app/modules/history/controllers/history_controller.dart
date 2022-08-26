import 'package:get/state_manager.dart';
import 'package:hi_doctor_v2/app/models/appointment.dart';

class HistoryController extends GetxController {
  RxList<Appointment> incomingList = <Appointment>[].obs;
  RxList<Appointment> completedList = <Appointment>[].obs;
  List<String> types = ['ALL', 'ONLINE', 'OFFLINE'];


  @override
  void dispose() {
    incomingList.close();
    completedList.close();
    super.dispose();
  }
}
