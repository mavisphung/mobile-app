import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/modules/appointment/controllers/booking/booking_controller.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';

class DateCalendar extends StatelessWidget {
  final BookingController cBooking;
  final _dayOfWeek = const ['Thứ hai', 'Thứ ba', 'Thứ tư', 'Thứ năm', 'Thứ sáu', 'Thứ bảy', 'Chủ nhật'];
  final _month = const [
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

  const DateCalendar({super.key, required this.cBooking});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    return Container(
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
        init: cBooking,
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
            firstDay: DateTime.utc(now.year, now.month, now.day),
            lastDay: DateTime.utc(now.year, now.month + 1, now.day),
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
    );
  }
}
