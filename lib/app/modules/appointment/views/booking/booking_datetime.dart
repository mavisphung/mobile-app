import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/modules/appointment/controllers/booking/slots_creator.dart';
import 'package:hi_doctor_v2/app/modules/appointment/widgets/slots_skeleton.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/common/util/utils.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:hi_doctor_v2/app/models/doctor.dart';
import 'package:hi_doctor_v2/app/modules/appointment/controllers/booking/booking_controller.dart';
import 'package:hi_doctor_v2/app/modules/appointment/models/working_hour_item.dart';
import 'package:hi_doctor_v2/app/modules/widgets/base_page.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_bottom_sheet.dart';
import 'package:hi_doctor_v2/app/modules/appointment/widgets/hour_item.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_appbar.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_title_section.dart';
import 'package:hi_doctor_v2/app/routes/app_pages.dart';

// ignore: must_be_immutable
class BookingDateTimePage extends StatelessWidget {
  BookingDateTimePage({Key? key}) : super(key: key);

  final _cBooking = Get.put(BookingController());
  final _doctor = Get.arguments as Doctor;

  final _now = DateTime.now();

  final _dayOfWeek = ['Thứ hai', 'Thứ ba', 'Thứ tư', 'Thứ năm', 'Thứ sáu', 'Thứ bảy', 'Chủ nhật'];
  final _month = [
    'Tháng một',
    'Tháng hai',
    'Tháng ba',
    'Tháng tư',
    'Tháng năm',
    'Tháng sáu',
    'Tháng bảy',
    'Tháng tám',
    'Tháng chín',
    'Tháng mười',
    'Tháng mười một',
    'Tháng mười hai'
  ];

  @override
  Widget build(BuildContext context) {
    _cBooking.setDoctor(_doctor);
    final slotsCreator = SlotsCreator(_doctor);
    return BasePage(
      appBar: const MyAppBar(
        title: 'Book an appointment',
      ),
      bottomSheet: CustomBottomSheet(
        buttonText: Strings.kContinue.tr,
        onPressed: () {
          if (_cBooking.selectedTime.isEmpty) {
            Utils.showAlertDialog('Please choose your booking time');
            return;
          }
          Get.toNamed(Routes.BOOKING_PACKAGE, preventDuplicates: true);
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTitleSection(
            title: 'Select date',
            paddingLeft: 8.sp,
          ),
          Container(
            height: 330.sp,
            margin: EdgeInsets.only(bottom: 30.sp),
            padding: EdgeInsets.symmetric(
              vertical: 15.sp,
              horizontal: 15.sp,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25.sp),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.12),
                  offset: const Offset(0, 2),
                  blurRadius: 4.sp,
                ),
              ],
            ),
            child: GetBuilder<BookingController>(
              init: _cBooking,
              builder: (c) {
                return TableCalendar(
                  shouldFillViewport: true,
                  daysOfWeekHeight: 40.sp,
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
                  firstDay: DateTime.utc(_now.year, _now.month, _now.day),
                  lastDay: DateTime.utc(_now.year, _now.month + 1, _now.day),
                  focusedDay: c.focusedDate,
                  selectedDayPredicate: (day) {
                    return isSameDay(c.selectedDate, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    if (!isSameDay(c.selectedDate, selectedDay)) {
                      c.setSelectedDate(selectedDay);
                      c.setFocusedDate(focusedDay);
                      'Selected day ${c.selectedDate} | Focused day ${c.focusedDate}'.debugLog('Selected day');
                      c.update();
                    }
                  },
                  calendarBuilders: CalendarBuilders(
                    headerTitleBuilder: (context, day) {
                      return Text(
                        '${_month[day.month - 1]} ${day.year}',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      );
                    },
                    dowBuilder: (context, day) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.sp),
                        child: Text(
                          _dayOfWeek[day.weekday - 1],
                          textAlign: TextAlign.center,
                        ),
                      );
                    },
                    selectedBuilder: (_, DateTime day, DateTime otherDay) {
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
          CustomTitleSection(
            title: 'Chọn giờ',
            paddingLeft: 8.sp,
          ),
          ObxValue<Rx<DateTime>>((data) {
            return FutureBuilder(
              future: slotsCreator.getAvailableSlot(data.value.getWeekday()),
              builder: (_, AsyncSnapshot<List<WorkingHour>?> snapshot) {
                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  final slots = snapshot.data!;
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
                          _cBooking.setSelectedTimeId(e.id!);
                          print('E.VALUE: ${e.value}');
                          _cBooking.setSelectedTime(e.value!);
                        },
                        child: ObxValue<RxInt>(
                            (data) => HourItem(
                                  text: e.title!,
                                  id: e.id!,
                                  isSelected: data.value == e.id ? true : false,
                                ),
                            _cBooking.rxSelectedTimeId),
                      );
                    },
                  );
                } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                  return Text('No slot on week day ${data.value.weekday}');
                }
                return const SlotsSkeleton();
              },
            );
          }, _cBooking.rxSelectedDate),
          SizedBox(height: 90.sp),
        ],
      ),
    );
  }
}
