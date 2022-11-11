import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hi_doctor_v2/app/common/util/transformation.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_card.dart';
import 'package:hi_doctor_v2/app/modules/widgets/image_container.dart';

class DoctorCard extends StatelessWidget {
  final String? avatar;
  final String? firstName;
  final String? lastName;
  final String? specialist;
  final String? address;

  const DoctorCard(
      {super.key,
      required this.avatar,
      required this.firstName,
      required this.lastName,
      required this.specialist,
      required this.address});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Row(
        children: [
          ImageContainer(
            width: 120,
            height: 120,
            imgUrl: avatar,
            borderRadius: 25,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 15.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    Tx.getDoctorName(lastName, firstName),
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Divider(
                    color: AppColors.greyDivider,
                    thickness: 0.3.sp,
                  ),
                  Text(
                    specialist ?? '',
                    style: TextStyle(fontSize: 11.5.sp),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5.sp),
                    child: Text(
                      address ?? '',
                      style: TextStyle(
                        fontSize: 11.5.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
