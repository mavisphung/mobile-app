import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/storage/storage.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:hi_doctor_v2/app/models/doctor.dart';
import 'package:hi_doctor_v2/app/models/user_info.dart';
import 'package:hi_doctor_v2/app/modules/appointment/controllers/booking/booking_controller.dart';
import 'package:hi_doctor_v2/app/modules/appointment/providers/req_appointment_model.dart';
import 'package:hi_doctor_v2/app/modules/home/controllers/doctor_controller.dart';
import 'package:hi_doctor_v2/app/modules/widgets/base_page.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_bottom_sheet.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_container.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_appbar.dart';

// ignore: must_be_immutable
class BookingSummary extends StatelessWidget {
  final _c = Get.find<BookingController>();
  final _doctorController = Get.find<DoctorController>();

  final _imageSize = Get.width / 4;
  late Doctor _doctorInfo;
  late UserInfo2? _userInfo;

  BookingSummary({Key? key}) : super(key: key);

  final _spacing = SizedBox(
    height: 15.sp,
  );

  Widget _getSubText(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.grey,
      ),
    );
  }

  Widget _getTitle(String text) {
    return SizedBox(
      width: 115.sp,
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  void createAppointment() {
    final doctorId = _doctorInfo.id;
    if (doctorId != null) {
      final reqModel = ReqAppointmentModel(
        doctorId,
        2,
        _c.serviceId,
        "${DateFormat('yyyy-MM-dd').format(_c.selectedDate)} ${_c.selectedTime}",
        "ONLINE",
        _c.problemController.text.trim(),
      );
      _c.createAppointment(reqModel);
    }
  }

  @override
  Widget build(BuildContext context) {
    _doctorInfo = _doctorController.rxDoctor.value;
    _userInfo = Storage.getValue<UserInfo2>(CacheKey.USER_INFO.name);
    return Scaffold(
      appBar: MyAppBar(title: Strings.reviewSummary.tr),
      body: BasePage(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(Strings.doctor.tr),
            CustomContainer(
              child: Row(
                children: [
                  Container(
                    width: _imageSize,
                    height: _imageSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(Constants.borderRadius.sp),
                      image: DecorationImage(
                        image: NetworkImage(_doctorInfo.avatar ?? Constants.defaultAvatar),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.sp,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${Strings.dr.tr} ${_doctorInfo.firstName} ${_doctorInfo.lastName}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Divider(
                          color: AppColors.greyDivider,
                          thickness: 0.8.sp,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _getSubText(Strings.gender.tr),
                            Text('${_doctorInfo.gender}'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _getSubText(Strings.age.tr),
                            Text('${_doctorInfo.age}'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _getSubText(Strings.expYrs.tr),
                            Text('${_doctorInfo.experienceYears}'),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            _spacing,
            Text(Strings.patient.tr),
            CustomContainer(
              child: Row(
                children: [
                  Container(
                    width: _imageSize,
                    height: _imageSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(15.sp),
                      image: DecorationImage(
                        image: NetworkImage(_userInfo?.avatar ?? Constants.defaultAvatar),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.sp,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${_userInfo?.lastName} ${_userInfo?.firstName}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Divider(
                          color: AppColors.greyDivider,
                          thickness: 0.8.sp,
                        ),
                        Row(
                          children: [
                            _getTitle(Strings.gender.tr),
                            Text('${_userInfo?.gender}'),
                          ],
                        ),
                        Row(
                          children: [
                            _getTitle(Strings.dob.tr),
                            const Text('25/6/2000'),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _getTitle(Strings.dob.tr),
                            Flexible(child: Text('${_userInfo?.address}')),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            _spacing,
            Text(Strings.appointmentDetail.tr),
            CustomContainer(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _getSubText(Strings.bookAt.tr),
                      Text("${DateFormat('yyyy-MM-dd').format(_c.selectedDate)} ${_c.selectedTime}"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _getSubText(Strings.duration.tr),
                      const Text('30 minutes'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _getSubText(Strings.appointmentType.tr),
                      const Text('ONLINE'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _getSubText(Strings.package.tr),
                      const Text('Messaging'),
                    ],
                  ),
                  Divider(
                    height: 0,
                    color: AppColors.greyDivider,
                    thickness: 0.8.sp,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _getSubText(Strings.price.tr),
                      const Text('\$ 20'),
                    ],
                  ),
                ],
              ),
            ),
            _spacing,
            const Text('Payment'),
            CustomContainer(
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/momo.svg',
                    // fit: BoxFit.cover,
                    width: 38.sp,
                    height: 38.sp,
                  ),
                  SizedBox(
                    width: 15.sp,
                  ),
                  const Expanded(
                    child: Text('****123456'),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(Strings.change.tr),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 90.sp,
            ),
          ],
        ),
      ),
      bottomSheet: CustomBottomSheet(
        buttonText: Strings.kContinue.tr,
        onPressed: createAppointment,
      ),
    );
  }
}
