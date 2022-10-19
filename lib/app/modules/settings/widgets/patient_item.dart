import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/util/transformation.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:hi_doctor_v2/app/models/patient.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_container.dart';
import 'package:hi_doctor_v2/app/routes/app_pages.dart';

class PatientItem extends StatelessWidget {
  final Patient patient;

  const PatientItem({Key? key, required this.patient}) : super(key: key);

  Widget _getDescription(String title, String detail) {
    return Padding(
      padding: EdgeInsets.only(top: 5.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 11.sp,
            ),
          ),
          Text(
            detail.length >= 25 ? '${detail.substring(0, 25)}...' : detail,
            overflow: TextOverflow.fade,
            style: TextStyle(
              fontSize: 11.sp,
              color: Colors.grey,
            ),
          ),
        ],
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
                borderRadius: BorderRadius.circular(15.sp),
                image: DecorationImage(
                  image: NetworkImage(patient.avatar ?? Constants.defaultAvatar),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 15.sp,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Tx.getFullName(patient.lastName, patient.firstName),
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Divider(
                    color: Colors.grey[300],
                    thickness: 0.2.sp,
                  ),
                  _getDescription(Strings.dob.tr, patient.dob ?? ''),
                  _getDescription(Strings.address.tr, patient.address ?? ''),
                  _getDescription(Strings.gender.tr, patient.gender ?? ''),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
