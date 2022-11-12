import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/modules/settings/controllers/patient_profile_controller.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_card.dart';

class WelcomeItem extends StatelessWidget {
  final _cPatientProfile = Get.put(PatientProfileController());

  WelcomeItem({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _cPatientProfile.getPatientList(),
      builder: (_, AsyncSnapshot<bool?> snapshot) {
        if (snapshot.hasData && snapshot.data == true) {
          return Visibility(
            visible: _cPatientProfile.patientList.isEmpty,
            child: CustomCard(
              horizontalPadding: 18,
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/speaker1.svg',
                    width: 50.sp,
                    height: 50.sp,
                  ),
                  SizedBox(width: 15.sp),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Có vẻ như bạn là người dùng mới',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'OpenSans',
                          ),
                        ),
                        SizedBox(height: 10.sp),
                        Text(
                          'Nhấn vào đây hoặc vào phần quản lý hồ sơ bệnh nhân để tạo hồ sơ bệnh nhân mới và đặt lịch khám với bác sĩ',
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
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
