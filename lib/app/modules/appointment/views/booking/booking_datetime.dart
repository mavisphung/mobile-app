import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/modules/appointment/controllers/booking/slots_creator.dart';
import 'package:hi_doctor_v2/app/modules/appointment/widgets/date_calendar.dart';
import 'package:hi_doctor_v2/app/modules/appointment/widgets/slots_skeleton.dart';
import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/common/util/utils.dart';
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
          DateCalendar(cBooking: _cBooking),
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
                  return const Center(child: Text('Không có lịch làm việc'));
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
