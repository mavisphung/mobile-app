import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:hi_doctor_v2/app/modules/appointment/controllers/booking/booking_controller.dart';
import 'package:hi_doctor_v2/app/modules/appointment/models/working_hour_item.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_bottom_sheet.dart';
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
    WorkingHour(id: 4, title: '10:30 AM', value: '10:30'),
    WorkingHour(id: 5, title: '11:00 AM', value: '11:00'),
    WorkingHour(id: 6, title: '11:30 AM', value: '11:30'),
    WorkingHour(id: 7, title: '12:00 PM', value: '12:00'),
    WorkingHour(id: 8, title: '01:00 PM', value: '13:00'),
    WorkingHour(id: 9, title: '01:00 PM', value: '13:00'),
    WorkingHour(id: 10, title: '01:00 PM', value: '13:00'),
    WorkingHour(id: 11, title: '01:00 PM', value: '13:00'),
  ];

  @override
  void initState() {
    super.initState();
    _selectedDay = null;
    _focusedDay = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Book an appointment',
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 12.0.sp,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // -------------------------------------------------------------------------------
              MyTitleSection(
                title: 'Select date',
                paddingLeft: 8.sp,
              ),
              Container(
                height: 330.0.sp,
                margin: EdgeInsets.only(bottom: 30.0.sp),
                padding: EdgeInsets.symmetric(
                  vertical: 15.sp,
                  horizontal: 15.0.sp,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.0.sp),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.12),
                      offset: const Offset(0, 2),
                      blurRadius: 4.0.sp,
                    ),
                  ],
                ),
                child: GetBuilder(
                  init: bookingController,
                  builder: (BookingController controller) {
                    return TableCalendar(
                      shouldFillViewport: true,
                      daysOfWeekHeight: 25.sp,
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
              MyTitleSection(
                title: 'Select hour',
                paddingLeft: 8.sp,
              ),
              GetBuilder(
                init: bookingController,
                builder: (BookingController controller) {
                  return GridView.builder(
                    padding: EdgeInsets.only(bottom: 5.sp),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: workingHours.length,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      crossAxisSpacing: 10.sp,
                      mainAxisSpacing: 20.sp,
                      maxCrossAxisExtent: 80.sp,
                      mainAxisExtent: 50.sp,
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
              SizedBox(height: 90.0.sp),
            ],
          ),
        ),
      ),
      bottomSheet: CustomBottomSheet(
        buttonText: Strings.kContinue.tr,
        onPressed: () {
          Get.toNamed(Routes.BOOKING_PACKAGE, preventDuplicates: true);
        },
      ),
    );
  }
}
