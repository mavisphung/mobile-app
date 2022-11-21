import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/util/transformation.dart';

import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/modules/settings/controllers/patient_profile_controller.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_card.dart';

class WelcomeItem extends StatelessWidget {
  final String firstName;
  final String lastName;
  final _cPatientProfile = Get.put(PatientProfileController());

  WelcomeItem({super.key, required this.firstName, required this.lastName});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _cPatientProfile.getPatientList(),
      builder: (_, AsyncSnapshot<bool?> snapshot) {
        if (snapshot.hasData && snapshot.data == true) {
          return Visibility(
            visible: _cPatientProfile.patientList.isEmpty,
            child: Padding(
              padding: EdgeInsets.only(top: 15.sp),
              child: CustomCard(
                horizontalPadding: 18,
                child: Row(
                  children: [
                    Transform.rotate(
                      angle: -math.pi / 6,
                      child: SvgPicture.asset(
                        'assets/icons/speaker.svg',
                        width: 55.sp,
                        height: 55.sp,
                      ),
                    ),
                    SizedBox(width: 15.sp),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Chào mừng ${Tx.getFullName(lastName, firstName)},',
                            style: TextStyle(
                              fontSize: 14.5.sp,
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                          Text(
                            'Có vẻ như bạn là người dùng mới',
                            style: TextStyle(
                              color: AppColors.secondary,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                          SizedBox(height: 10.sp),
                          Text(
                            'Hãy nhấn vào đây hoặc vào phần quản lý hồ sơ bệnh nhân để tạo hồ sơ bệnh nhân và đặt lịch khám với bác sĩ',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
