import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/storage/box.dart';
import 'package:hi_doctor_v2/app/common/storage/storage.dart';
import 'package:hi_doctor_v2/app/common/util/dialogs.dart';
import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/common/util/transformation.dart';
import 'package:hi_doctor_v2/app/common/util/utils.dart';
import 'package:hi_doctor_v2/app/models/service.dart';
import 'package:hi_doctor_v2/app/models/user_info.dart';
import 'package:hi_doctor_v2/app/modules/widgets/image_container.dart';
import 'package:hi_doctor_v2/app/routes/app_pages.dart';
import 'package:intl/intl.dart';

import 'package:hi_doctor_v2/app/common/util/dialogs.dart';
import 'package:hi_doctor_v2/app/common/util/transformation.dart';
import 'package:hi_doctor_v2/app/modules/widgets/content_container.dart';
import 'package:hi_doctor_v2/app/modules/widgets/image_container.dart';
import 'package:hi_doctor_v2/app/routes/app_pages.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_container.dart';
import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:hi_doctor_v2/app/modules/appointment/controllers/booking/booking_controller.dart';
import 'package:hi_doctor_v2/app/modules/appointment/providers/req_appointment_model.dart';
import 'package:hi_doctor_v2/app/modules/widgets/base_page.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_bottom_sheet.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_appbar.dart';
import 'package:vnpay_flutter/vnpay_flutter.dart';

// ignore: must_be_immutable
class BookingSummary extends StatelessWidget {
  final _cBooking = Get.find<BookingController>();
  UserInfo2 userInfo = Box.getCacheUser();
  final _imageSize = Get.width / 4;

  BookingSummary({Key? key}) : super(key: key);

  final _spacing = SizedBox(
    height: 15.sp,
  );

  String getFormatedPhone() {
    final supervisor = Storage.getValue<UserInfo2>(CacheKey.USER_INFO.name);
    return supervisor!.phoneNumber!.replaceRange(0, 6, '******');
  }

  void createAppointment(BuildContext ctx) async {
    // Booking trước, payment sau
    'Creating appointment'.debugLog('Booking summary');
    final reqModel = ReqAppointmentModel(
      _cBooking.doctor.id!,
      _cBooking.patient!.id!,
      _cBooking.serviceId,
      "${DateFormat('yyyy-MM-dd').format(_cBooking.selectedDate)} ${_cBooking.selectedTime}",
      _cBooking.problemController.text.trim(),
    );
    Service selectedService = _cBooking.selectedService;
    if (userInfo.mainBalance! > selectedService.price!) {
      Dialogs.statusDialog(
        ctx: ctx,
        isSuccess: false,
        successMsg: '',
        failMsg: 'Bạn bạn không đủ tiền, vui lòng nạp thêm',
        successAction: () {},
      );
      return;
    }

    var isSuccess = await _cBooking.createAppointment(reqModel);
    if (isSuccess == null) {
      Utils.showAlertDialog('Phát sinh lỗi hệ thống');
      return;
    }

    if (isSuccess) {}

    Dialogs.statusDialog(
      ctx: ctx,
      isSuccess: isSuccess,
      successMsg: 'Lịch hẹn khám đã được đặt thành công. Bạn sẽ được nhận thông báo để theo dõi lịch hẹn với bác sĩ.',
      failMsg: 'Có vẻ như có ai đó đã đặt lịch trước bạn. Bạn hãy chọn một ca thời gian khác và thử lại xem.',
      successAction: () => Get.offAllNamed(Routes.NAVBAR),
    );
  }

  @override
  Widget build(BuildContext context) {
    final patient = _cBooking.patient!;
    final doctor = _cBooking.doctor;
    final servicePackage = _cBooking.packageList!.firstWhere((e) => e.id == _cBooking.serviceId);
    return BasePage(
        appBar: MyAppBar(
          title: Strings.reviewSummary,
          actions: const [BackHomeWidget()],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ContentTitle1(title: Strings.doctorInfo, bottomPadding: 5),
            CustomContainer(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ImageContainer(
                    width: _imageSize,
                    height: _imageSize,
                    imgUrl: doctor.avatar,
                  ),
                  SizedBox(
                    width: 10.sp,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${Strings.doctor} ${Tx.getFullName(doctor.lastName, doctor.firstName)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Divider(
                          color: AppColors.greyDivider,
                          thickness: 0.3.sp,
                        ),
                        ContentRow(
                          hozPadding: 0,
                          verPadding: 0,
                          content: {
                            Strings.gender: Utils.convertGender(doctor.gender!),
                            Strings.age: '${doctor.age}',
                            Strings.address: doctor.address ?? '',
                          },
                          labelWidth: 60,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            _spacing,
            ContentTitle1(title: Strings.patientInfo, bottomPadding: 5),
            CustomContainer(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ImageContainer(
                    width: _imageSize,
                    height: _imageSize,
                    imgUrl: patient.avatar,
                    borderRadius: Constants.textFieldRadius.sp,
                  ),
                  SizedBox(
                    width: 10.sp,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Tx.getFullName(patient.lastName, patient.firstName),
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Divider(
                          color: AppColors.greyDivider,
                          thickness: 0.3.sp,
                        ),
                        ContentRow(
                          hozPadding: 0,
                          verPadding: 0,
                          content: {
                            Strings.gender: Utils.convertGender(patient.gender!),
                            Strings.age: Tx.getAge(patient.dob ?? ""),
                            Strings.address: patient.address ?? '',
                          },
                          labelWidth: 60,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            _spacing,
            ContentTitle1(title: Strings.appointmentDetail, bottomPadding: 5),
            CustomContainer(
              child: ContentRow(
                hozPadding: 0,
                verPadding: 0,
                content: {
                  Strings.bookAt: "${DateFormat('yyyy-MM-dd').format(_cBooking.selectedDate)} ${_cBooking.selectedTime}",
                  Strings.duration: '30 phút',
                  Strings.package: servicePackage.name!,
                  'Mô tả': servicePackage.description!,
                  Strings.price: '${servicePackage.price} Vnđ',
                },
                labelWidth: 100,
              ),
            ),
            _spacing,
            const ContentTitle1(title: 'Ví của bạn', bottomPadding: 5),
            CustomContainer(
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/wallet.svg',
                    // fit: BoxFit.cover,
                    width: 28.sp,
                    height: 28.sp,
                  ),
                  SizedBox(
                    width: 15.sp,
                  ),
                  Expanded(
                    child: Text('${Utils.formatNumber(userInfo.mainBalance!.toStringAsFixed(0))}đ'),
                  ),
                  // TextButton(
                  //   onPressed: () {},
                  //   child: Text(Strings.change),
                  // ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.WALLET);
                    },
                    child: Text(
                      'Nạp thêm',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomSheet: CustomBottomSheet(
          buttonText: Strings.kContinue,
          onPressed: () => createAppointment(context),
        ));
  }
}
