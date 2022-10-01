import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/storage/storage.dart';
import 'package:hi_doctor_v2/app/models/user_info.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_container.dart';
import 'package:intl/intl.dart';

import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:hi_doctor_v2/app/modules/appointment/controllers/booking/booking_controller.dart';
import 'package:hi_doctor_v2/app/modules/appointment/providers/req_appointment_model.dart';
import 'package:hi_doctor_v2/app/modules/widgets/base_page.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_bottom_sheet.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_appbar.dart';

// ignore: must_be_immutable
class BookingSummary extends StatelessWidget {
  final _cBooking = Get.find<BookingController>();

  final _imageSize = Get.width / 4;

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

  String getFormatedPhone() {
    final supervisor = Storage.getValue<UserInfo2>(CacheKey.USER_INFO.name);
    return supervisor!.phoneNumber!.replaceRange(0, 6, '******');
  }

  void createAppointment() {
    final reqModel = ReqAppointmentModel(
      _cBooking.doctor.id!,
      _cBooking.patient.id!,
      _cBooking.serviceId,
      "${DateFormat('yyyy-MM-dd').format(_cBooking.selectedDate)} ${_cBooking.selectedTime}",
      _cBooking.serviceType,
      _cBooking.problemController.text.trim(),
    );
    _cBooking.createAppointment(reqModel);
  }

  @override
  Widget build(BuildContext context) {
    final patient = _cBooking.patient;
    final doctor = _cBooking.doctor;
    final servicePackage = _cBooking.packageList!.firstWhere((e) => e.id == _cBooking.serviceId);
    return BasePage(
        appBar: MyAppBar(title: Strings.reviewSummary.tr),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(Strings.doctorInfo.tr),
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
                        image: NetworkImage(doctor.avatar ?? Constants.defaultAvatar),
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
                          '${Strings.dr.tr} ${doctor.firstName} ${doctor.lastName}',
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
                            Text('${doctor.gender}'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _getSubText(Strings.age.tr),
                            Text('${doctor.age}'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _getSubText(Strings.expYrs.tr),
                            Text('${doctor.experienceYears}'),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            _spacing,
            Text(Strings.patientInfo.tr),
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
                        image: NetworkImage(patient.avatar ?? Constants.defaultAvatar),
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
                          '${patient.lastName} ${patient.firstName}',
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
                            Text('${patient.gender}'),
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
                            Flexible(child: Text('${patient.address}')),
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
                      Text("${DateFormat('yyyy-MM-dd').format(_cBooking.selectedDate)} ${_cBooking.selectedTime}"),
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
                      Text(_cBooking.serviceType),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _getSubText(Strings.package.tr),
                      Text(servicePackage.name),
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
                      Text('${servicePackage.price}'),
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
                    'assets/icons/wallet.svg',
                    // fit: BoxFit.cover,
                    width: 38.sp,
                    height: 38.sp,
                  ),
                  SizedBox(
                    width: 15.sp,
                  ),
                  Expanded(
                    child: Text(getFormatedPhone()),
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
        bottomSheet: CustomBottomSheet(
          buttonText: Strings.kContinue.tr,
          onPressed: createAppointment,
        ));
  }
}
