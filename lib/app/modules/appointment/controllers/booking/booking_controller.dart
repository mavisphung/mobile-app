import 'package:get/get.dart';

class BookingController extends GetxController {
  Rx<DateTime> rxSelectedDate = DateTime.now().obs;
  Rx<DateTime> rxFocusedDate = DateTime.now().obs;
  RxBool rxIsSelected = false.obs;
  RxInt rxSelectedId = 0.obs;

  // Field for appointment
  // Rx<int?> rxDurationId = null.obs;

  DateTime get selectedDate => rxSelectedDate.value;
  DateTime get focusedDate => rxSelectedDate.value;

  bool get isSelected => rxIsSelected.value;
  int get selectedId => rxSelectedId.value;

  void setSelectedId(int value) {
    rxSelectedId.value = value;
    update();
  }

  void setSelectedDate(DateTime value) {
    rxSelectedDate.value = value;
  }

  void setFocusedDate(DateTime value) {
    rxFocusedDate.value = value;
  }

  @override
  void dispose() {
    rxSelectedDate.close();
    rxFocusedDate.close();
    rxSelectedId.close();
    super.dispose();
  }
}
