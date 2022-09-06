import 'package:get/get.dart';

class BookingController extends GetxController {
  Rx<DateTime> rxSelectedDate = DateTime.now().obs;
  Rx<DateTime> rxFocusedDate = DateTime.now().obs;

  DateTime get selectedDate => rxSelectedDate.value;
  DateTime get focusedDate => rxSelectedDate.value;

  void setSelectedDate(DateTime value) {
    rxSelectedDate.value = value;
  }

  void setFocusedDate(DateTime value) {
    rxFocusedDate.value = value;
  }
}
