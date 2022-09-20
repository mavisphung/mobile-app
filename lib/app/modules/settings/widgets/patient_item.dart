import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/models/patient.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_container.dart';
import 'package:hi_doctor_v2/app/routes/app_pages.dart';

class PatientItem extends StatelessWidget {
  final Patient patient;

  const PatientItem({Key? key, required this.patient}) : super(key: key);

  Widget _getSubText(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.grey,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final imageSize = Get.width / 4;
    return GestureDetector(
      onTap: () => Get.toNamed(
        Routes.PATIENT_PROFILE_DETAIL,
        arguments: patient.id,
      ),
      child: CustomContainer(
        child: Row(
          children: [
            Container(
              width: imageSize,
              height: imageSize,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(15.0.sp),
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
                    '${patient.firstName} ${patient.lastName}',
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
                      _getSubText('Day of birth:'),
                      Text('${patient.dob}'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _getSubText('Address:'),
                      Text('${patient.address}'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _getSubText('Gender:'),
                      Text('${patient.gender}'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
