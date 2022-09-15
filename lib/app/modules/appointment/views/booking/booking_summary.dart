import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/storage/storage.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:hi_doctor_v2/app/models/doctor.dart';
import 'package:hi_doctor_v2/app/modules/appointment/controllers/booking/patient_controller.dart';
import 'package:hi_doctor_v2/app/modules/appointment/providers/req_appointment_model.dart';
import 'package:hi_doctor_v2/app/modules/home/controllers/doctor_controller.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_bottom_sheet.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_appbar.dart';

class BookingSummary extends StatelessWidget {
  final _controller = Get.find<PatientController>();
  final _doctorController = Get.find<DoctorController>();

  final _imageWidth = Get.width / 10 * 3;
  late Doctor _doctorInfo;
  late Map<String, dynamic>? _userInfo;

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

  void createAppointment() {
    final doctorId = _doctorInfo.id;
    if (doctorId != null) {
      final reqModel = ReqAppointmentModel(
        doctorId,
        2,
        1,
        "2022-09-15 18:43:00",
        "ONLINE",
        _controller.problemController.text.trim(),
      );
      _controller.createAppointment(reqModel);
    }
  }

  @override
  Widget build(BuildContext context) {
    _doctorInfo = _doctorController.rxDoctor.value;
    _userInfo = Storage.getValue<Map<String, dynamic>>(CacheKey.USER_INFO.name);
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
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.sp),
                ),
                shadowColor: Colors.black26,
                child: Padding(
                  padding: EdgeInsets.all(10.sp),
                  child: Row(
                    children: [
                      Container(
                        width: _imageWidth,
                        height: _imageWidth,
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(15.0.sp),
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
                            Text('Gender: ${_doctorInfo.gender}'),
                            Text('Age: ${_doctorInfo.age}'),
                            Text('Experience years: ${_doctorInfo.experienceYears}'),
                            Text('Phone number: ${_doctorInfo.phoneNumber}'),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              _spacing,
              const Text('Patient'),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.sp),
                ),
                shadowColor: Colors.black26,
                child: Padding(
                  padding: EdgeInsets.all(10.sp),
                  child: Row(
                    children: [
                      Container(
                        width: _imageWidth,
                        height: _imageWidth,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(15.0.sp),
                          image: DecorationImage(
                            image: NetworkImage(_userInfo?['avatar'] ?? Constants.defaultAvatar),
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
                              '${_userInfo?['firstName']} ${_userInfo?['lastName']}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Divider(
                              color: AppColors.greyDivider,
                              thickness: 0.8.sp,
                            ),
                            Text('Gender: ${_userInfo?['gender']}'),
                            Text('Address: ${_userInfo?['address']}'),
                            Text('Phone number: ${_userInfo?['phoneNumber']}'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              _spacing,
              const Text('Appointment details'),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.sp),
                ),
                shadowColor: Colors.black26,
                child: Padding(
                  padding: EdgeInsets.all(10.sp),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _getSubText('Book at:'),
                          const Text('15/6/2022 16:00'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _getSubText('Duration:'),
                          const Text('40 minutes'),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _getSubText('Amount:'),
                          const Text('\$ 20'),
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
                          _getSubText('Total:'),
                          const Text('\$ 80'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              _spacing,
              const Text('Payment'),
              Card(
                elevation: 4,
                shadowColor: Colors.black26,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.sp),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.sp,
                    horizontal: 15.sp,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'momo',
                            style: TextStyle(
                              color: Colors.pink[700],
                              fontWeight: FontWeight.bold,
                            ),
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
