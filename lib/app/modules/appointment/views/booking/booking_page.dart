import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/modules/appointment/controllers/booking/booking_controller.dart';
import 'package:hi_doctor_v2/app/modules/appointment/models/working_hour_item.dart';
import 'package:hi_doctor_v2/app/modules/appointment/widgets/booking_bottom_sheet.dart';
import 'package:hi_doctor_v2/app/modules/appointment/widgets/hour_item.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_appbar.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_section_title.dart';
import 'package:hi_doctor_v2/app/routes/app_pages.dart';
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

  List<WorkingHour> workingHours = [
    // HourItem(text: '09:00 AM', isSelected: false),
    // HourItem(text: '09:30 AM', isSelected: false),
    // HourItem(text: '10:00 AM', isSelected: false),
    // HourItem(text: '10:30 AM', isSelected: false),
    // HourItem(text: '11:00 AM', isSelected: false),
    // HourItem(text: '11:30 AM', isSelected: false),
    // HourItem(text: '12:00 PM', isSelected: false),
    // HourItem(text: '12:30 PM', isSelected: false),
    // HourItem(text: '01:00 PM', isSelected: false),
    WorkingHour(id: 1, title: '09:00 AM', value: '09:00'),
    WorkingHour(id: 2, title: '09:30 AM', value: '09:30'),
    WorkingHour(id: 3, title: '10:00 AM', value: '10:00'),
    WorkingHour(id: 4, title: '10:00 AM', value: '10:00'),
    WorkingHour(id: 5, title: '11:00 AM', value: '11:00'),
    WorkingHour(id: 6, title: '11:30 AM', value: '11:30'),
    WorkingHour(id: 7, title: '12:00 PM', value: '12:00'),
    WorkingHour(id: 8, title: '01:00 PM', value: '13:00'),
  ];

  @override
  void initState() {
    super.initState();
    _selectedDay = null;
    _focusedDay = null;
  }

  final double _crossAxisSpacing = 8, _mainAxisSpacing = 12, _aspectRatio = 2.8;
  final int _crossAxisCount = 3;

  @override
  Widget build(BuildContext context) {
    var width = (Get.width - ((_crossAxisCount - 1) * _crossAxisSpacing)) / _crossAxisCount;
    var height = width / _aspectRatio;

    return Scaffold(
      appBar: const MyAppBar(
        title: 'Make an appointment',
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 17.5.sp),
          padding: EdgeInsets.symmetric(horizontal: 12.0.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // -------------------------------------------------------------------------------
              const MySectionTitle(title: 'Select Date'),
              Container(
                height: 270.0.sp,
                margin: EdgeInsets.only(bottom: 20.0.sp),
                padding: EdgeInsets.symmetric(horizontal: 15.0.sp),
                decoration: BoxDecoration(
                  color: const Color(0xFFEEF4FF),
                  borderRadius: BorderRadius.circular(30.0.sp),
                ),
                child: GetBuilder(
                  init: bookingController,
                  builder: (BookingController controller) {
                    return TableCalendar(
                      shouldFillViewport: true,
                      calendarStyle: CalendarStyle(
                        todayDecoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary.withOpacity(0.5),
                        ),
                        selectedDecoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary,
                        ),
                      ),
                      availableCalendarFormats: const {
                        CalendarFormat.month: 'Month',
                        // CalendarFormat.week: '',
                      },
                      firstDay: DateTime.utc(_currentDate.year, _currentDate.month, _currentDate.day),
                      lastDay: DateTime.utc(_currentDate.year, _currentDate.month + 1, _currentDate.day),
                      focusedDay: controller.focusedDate,
                      selectedDayPredicate: (day) {
                        return isSameDay(controller.selectedDate, day);
                      },
                      onDaySelected: (selectedDay, focusedDay) {
                        if (!isSameDay(controller.selectedDate, selectedDay)) {
                          controller.setSelectedDate(selectedDay);
                          controller.setFocusedDate(focusedDay);
                          'Selected day $selectedDay | Focused day $focusedDay'.debugLog('Selected day');
                          controller.update();
                        }
                      },
                      calendarBuilders: CalendarBuilders(
                        selectedBuilder: (_, DateTime day, DateTime otherDay) {
                          // day.toString().debugLog('day');
                          // otherDay.toString().debugLog('otherDay');
                          return Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primary,
                            ),
                            child: Center(
                              child: Text(
                                '${day.day}',
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              // -------------------------------------------------------------------------------
              const MySectionTitle(title: 'Select Hour'),
              SizedBox(
                width: Get.width.sp,
                child: GetBuilder(
                  init: bookingController,
                  builder: (BookingController controller) {
                    return GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: workingHours.length,
                      scrollDirection: Axis.vertical,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: _crossAxisCount,
                        crossAxisSpacing: _crossAxisSpacing,
                        mainAxisSpacing: _mainAxisSpacing,
                        childAspectRatio: _aspectRatio,
                      ),
                      itemBuilder: (_, int index) {
                        WorkingHour e = workingHours[index];
                        return HourItem(
                          text: e.title!,
                          id: e.id!,
                          isSelected: controller.selectedId == e.id ? true : false,
                        );
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 80.0.sp),
            ],
          ),
        ),
      ),
      bottomSheet: BookingBottomSheet(
        textButton: 'Next',
        width: Get.width.sp / 100 * 80,
        height: 40.0.sp,
        decoration: BoxDecoration(
          color: Colors.white,
          // border: Border.all(color: Colors.black.withOpacity(0.125)),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35.0.sp),
            topRight: Radius.circular(35.0.sp),
          ),
        ),
        onPressed: () {
          Get.toNamed(Routes.BOOKING_PACKAGE, preventDuplicates: true);
        },
      ),
    );
  }
}
