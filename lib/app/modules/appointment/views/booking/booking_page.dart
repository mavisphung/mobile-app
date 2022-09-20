import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/common/util/utils.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:hi_doctor_v2/app/modules/appointment/controllers/booking/booking_controller.dart';
import 'package:hi_doctor_v2/app/modules/appointment/models/working_hour_item.dart';
import 'package:hi_doctor_v2/app/modules/home/controllers/doctor_controller.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_bottom_sheet.dart';
import 'package:hi_doctor_v2/app/modules/appointment/widgets/hour_item.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_appbar.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_section_title.dart';
import 'package:hi_doctor_v2/app/routes/app_pages.dart';
import 'package:table_calendar/table_calendar.dart';

// ignore: must_be_immutable
class BookingAppointmentPage extends StatelessWidget {
  BookingAppointmentPage({Key? key}) : super(key: key);

  DateTime currentDate = DateTime.now();

  final _c = Get.put(BookingController());
  final doctorController = Get.find<DoctorController>();

  List<WorkingHour>? getAvailableSlot(int weekDay) {
    final listShift = doctorController.rxDoctor.value.shifts;
    print(listShift);
    if (listShift != null) {
      final shift = listShift[weekDay - 1];
      final isActive = shift['isActive'] as bool;
      if (isActive) {
        print(shift['startTime']);
        final dateStr = '${currentDate.year}-${currentDate.month}-${currentDate.day}';
        final start = shift['startTime'] as String;
        final end = shift['endTime'] as String;
        final startTime = Utils.parseStrToDateTime('$dateStr ${start.replaceRange(5, null, "")}');
        print('start: $startTime');
        final endTime = Utils.parseStrToDateTime('$dateStr ${end.replaceRange(5, null, "")}');
        print('end: $endTime');
        if (startTime != null && endTime != null) {
          List<WorkingHour> slots = [];
          DateTime endSlot;
          int id = 1;
          endSlot = startTime;
          String label;
          do {
            label = 'AM';
            final midTime = DateTime(currentDate.year, currentDate.month, currentDate.day, 12);
            print('midTime: $midTime');
            if (endTime.isAfter(midTime)) {
              label = 'PM';
            }
            slots.add(WorkingHour(
              id: id++,
              title: '${Utils.formatTime(endSlot)} $label',
              value: Utils.formatTime(endSlot),
            ));
            endSlot = DateTime(
              currentDate.year,
              currentDate.month,
              currentDate.day,
              endSlot.hour,
              endSlot.minute,
            ).add(const Duration(minutes: 30));
            print('endSlot: $endSlot');
            print(endSlot.isBefore(endTime));
          } while (endSlot.isBefore(endTime) || endSlot.compareTo(endTime) == 0);

          return slots;
        }
      }
    }
    return null;
  }

  // final List<WorkingHour> _workingHours = [
  //   WorkingHour(id: 1, title: '09:00 AM', value: '09:00'),
  //   WorkingHour(id: 2, title: '09:30 AM', value: '09:30'),
  //   WorkingHour(id: 3, title: '10:00 AM', value: '10:00'),
  //   WorkingHour(id: 4, title: '10:30 AM', value: '10:30'),
  //   WorkingHour(id: 5, title: '11:00 AM', value: '11:00'),
  //   WorkingHour(id: 6, title: '11:30 AM', value: '11:30'),
  //   WorkingHour(id: 7, title: '12:00 PM', value: '12:00'),
  //   WorkingHour(id: 8, title: '01:00 PM', value: '13:00'),
  //   WorkingHour(id: 9, title: '01:00 PM', value: '13:00'),
  //   WorkingHour(id: 10, title: '01:00 PM', value: '13:00'),
  //   WorkingHour(id: 11, title: '01:00 PM', value: '13:00'),
  // ];

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
                child: GetBuilder<BookingController>(
                  init: _c,
                  builder: (c) {
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
                      firstDay: DateTime.utc(currentDate.year, currentDate.month, currentDate.day),
                      lastDay: DateTime.utc(currentDate.year, currentDate.month + 1, currentDate.day),
                      focusedDay: c.focusedDate,
                      selectedDayPredicate: (day) {
                        return isSameDay(c.selectedDate, day);
                      },
                      onDaySelected: (selectedDay, focusedDay) {
                        if (!isSameDay(c.selectedDate, selectedDay)) {
                          c.setSelectedDate(selectedDay);
                          c.setFocusedDate(focusedDay);
                          'Selected day $selectedDay | Focused day $focusedDay'.debugLog('Selected day');
                          c.update();
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
              ObxValue<Rx<DateTime>>((data) {
                final slots = getAvailableSlot(data.value.weekday);
                if (slots != null) {
                  return GridView.builder(
                    padding: EdgeInsets.only(bottom: 5.sp),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: slots.length,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      crossAxisSpacing: 10.sp,
                      mainAxisSpacing: 20.sp,
                      maxCrossAxisExtent: 80.sp,
                      mainAxisExtent: 50.sp,
                    ),
                    itemBuilder: (_, int index) {
                      WorkingHour e = slots[index];
                      return GestureDetector(
                        onTap: () {
                          _c.setSelectedTimeId(e.id!);
                          print(_c.selectedTimeId);
                        },
                        child: ObxValue<RxInt>(
                            (data) => HourItem(
                                  text: e.title!,
                                  id: e.id!,
                                  isSelected: data.value == e.id ? true : false,
                                ),
                            _c.rxSelectedTimeId),
                      );
                    },
                  );
                }
                return Text('No slot on week day ${data.value.weekday}');
              }, _c.rxSelectedDate),
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
