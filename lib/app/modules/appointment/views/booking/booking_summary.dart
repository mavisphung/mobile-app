import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/storage/storage.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:hi_doctor_v2/app/models/doctor.dart';
import 'package:hi_doctor_v2/app/models/user_info.dart';
import 'package:hi_doctor_v2/app/modules/appointment/controllers/booking/booking_controller.dart';
import 'package:hi_doctor_v2/app/modules/appointment/providers/req_appointment_model.dart';
import 'package:hi_doctor_v2/app/modules/home/controllers/doctor_controller.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_bottom_sheet.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_container.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_appbar.dart';
import 'package:intl/intl.dart';

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
      appBar: MyAppBar(title: 'Review summary'),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          margin: EdgeInsets.only(top: 10.sp),
          padding: EdgeInsets.symmetric(horizontal: 12.0.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Doctor'),
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
                            'Dr. ${_doctorInfo.firstName} ${_doctorInfo.lastName}',
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
                              _getSubText('Gender:'),
                              Text('${_doctorInfo.gender}'),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _getSubText('Age:'),
                              Text('${_doctorInfo.age}'),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _getSubText('Experience years:'),
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
              const Text('Patient'),
              CustomContainer(
                child: Row(
                  children: [
                    Container(
                      width: _imageSize,
                      height: _imageSize,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(15.0.sp),
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
                              _getTitle('Gender:'),
                              Text('${_userInfo?.gender}'),
                            ],
                          ),
                          Row(
                            children: [
                              _getTitle('Day of birth:'),
                              const Text('25/6/2000'),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _getTitle('Address:'),
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
              const Text('Appointment details'),
              CustomContainer(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _getSubText('Book at:'),
                        Text("${DateFormat('yyyy-MM-dd').format(_c.selectedDate)} ${_c.selectedTime}"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _getSubText('Duration:'),
                        const Text('30 minutes'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _getSubText('Type:'),
                        const Text('ONLINE'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _getSubText('Pakage:'),
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
                        _getSubText('Price:'),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/momo.svg',
                          color: Colors.amber,
                        ),
                        const Text('****123456'),
                      ],
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('CHANGE'),
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
      ),
      bottomSheet: CustomBottomSheet(
        buttonText: Strings.kContinue.tr,
        onPressed: createAppointment,
      ),
    );
  }
}
