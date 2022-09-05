import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/modules/appointment/controllers/booking_controller.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_appbar.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_section_title.dart';
import 'package:table_calendar/table_calendar.dart';

class BookingAppointmentPage extends StatefulWidget {
  BookingAppointmentPage({Key? key}) : super(key: key);

  @override
  State<BookingAppointmentPage> createState() => _BookingAppointmentPageState();
}

class _BookingAppointmentPageState extends State<BookingAppointmentPage> {
  final BookingController bookingController = Get.put(BookingController());
  DateTime? _selectedDay;
  DateTime? _focusedDay;
  DateTime _currentDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _selectedDay = null;
    _focusedDay = null;
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: const MyAppBar(
          title: 'Make an appointment',
        ),
        body: Container(
          margin: EdgeInsets.only(top: 17.5.sp),
          padding: EdgeInsets.symmetric(horizontal: 12.0.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MySectionTitle(title: 'Select Date'),
              GetBuilder(
                  init: bookingController,
                  builder: (BookingController controller) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 15.0.sp),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEEF4FF),
                        borderRadius: BorderRadius.circular(30.0.sp),
                      ),
                      child: TableCalendar(
                        firstDay: DateTime.utc(_currentDate.year, _currentDate.month, _currentDate.day),
                        lastDay: DateTime.utc(_currentDate.year, _currentDate.month + 1, _currentDate.day),
                        focusedDay: DateTime(_currentDate.year, _currentDate.month, _currentDate.day + 1),
                        selectedDayPredicate: (day) {
                          // 'selectedDayPredicate invoke'.debugLog('TableCalendar');
                          return isSameDay(controller.selectedDate, day);
                        },
                        onDaySelected: (selectedDay, focusedDay) {
                          controller.setSelectedDate(selectedDay);
                          controller.setFocusedDate(focusedDay);
                          _selectedDay.toString().debugLog('Selected day');
                          controller.update();
                        },
                        onPageChanged: (focusedDay) {
                          controller.setFocusedDate(focusedDay);
                          // controller.update();
                        },
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
