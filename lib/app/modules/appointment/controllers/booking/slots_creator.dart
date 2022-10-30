import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/models/doctor.dart';

import 'package:hi_doctor_v2/app/modules/appointment/controllers/booking/booking_controller.dart';
import 'package:hi_doctor_v2/app/modules/appointment/models/working_hour_item.dart';

class SlotsCreator {
  final Doctor doctor;
  final _cBooking = Get.find<BookingController>();

  final _now = DateTime.now();

  late List<Map<String, dynamic>> _selectedWeekdayShifts;

  SlotsCreator(this.doctor);

  List<Map<String, dynamic>>? _getWeekdayShift(int weekday) {
    for (var shift in doctor.shifts!) {
      Map<String, dynamic> temp = shift as Map<String, dynamic>;
      if (temp['isActive'] == true && temp['weekday'] == weekday) {
        _selectedWeekdayShifts.add(temp);
      }
    }
    return _selectedWeekdayShifts;
  }

  List<WorkingHour>? getAvailableSlot(int weekDay) {
    final listShift = doctor.shifts;
    if (listShift == null || listShift.isEmpty) {
      return null;
    }
    final shifts = _getWeekdayShift(weekDay);

    if (shifts == null) return null;

    // // print(shift['startTime']);
    // final dateStr = '${_now.year}-${_now.month}-${_now.day}';
    // final start = shifts['startTime'] as String;
    // final end = shifts['endTime'] as String;
    // final startTime = Utils.parseStrToDateTime('$dateStr ${start.replaceRange(5, null, "")}');
    // // print('start: $startTime');
    // final endTime = Utils.parseStrToDateTime('$dateStr ${end.replaceRange(5, null, "")}');
    // // print('end: $endTime');
    // if (startTime != null && endTime != null) {
    //   List<WorkingHour> slots = [];
    //   DateTime endSlot;
    //   int id = 1;
    //   endSlot = startTime;
    //   String label;
    //   do {
    //     label = 'AM';
    //     final midTime = DateTime(_now.year, _now.month, _now.day, 12);
    //     if (endTime.isAfter(midTime)) {
    //       label = 'PM';
    //     }
    //     slots.add(WorkingHour(
    //       id: id++,
    //       title: '${Utils.formatTime(endSlot)} $label',
    //       value: '${Utils.formatTime(endSlot)}:00',
    //     ));
    //     endSlot = DateTime(
    //       _now.year,
    //       _now.month,
    //       _now.day,
    //       endSlot.hour,
    //       endSlot.minute,
    //     ).add(const Duration(minutes: 30));
    //     // print('endSlot: $endSlot');
    //   } while (endSlot.isBefore(endTime) || endSlot.compareTo(endTime) == 0);

    //   return slots;
    // }
    return null;
  }
}
