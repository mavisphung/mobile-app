import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/common/util/transformation.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:hi_doctor_v2/app/models/doctor.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_inkwell.dart';
import 'package:hi_doctor_v2/app/routes/app_pages.dart';

class DoctorItem extends StatelessWidget {
  final Doctor doctor;

  const DoctorItem({
    Key? key,
    required this.doctor,
  }) : super(key: key);

  Widget _getDescription(
    String title,
    String detail,
  ) {
    return Padding(
      padding: EdgeInsets.only(top: 4.sp),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.grey[600]),
          ),
          Expanded(
            child: Text(
              detail,
              maxLines: 3,
              style: const TextStyle(
                overflow: TextOverflow.ellipsis,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      width: 330.sp,
      borderRadius: 5.sp,
      onTap: () {
        'Call api get doctor with id ${doctor.id}'.debugLog('Doctor instance');
        Get.toNamed(Routes.DOCTOR_DETAIL, arguments: doctor.id);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 80.sp,
                height: 80.sp,
                margin: EdgeInsets.only(bottom: 5.sp),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(17.sp),
                  image: DecorationImage(
                    image: NetworkImage(doctor.avatar!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/star.svg',
                    width: 15.sp,
                    height: 15.sp,
                  ),
                  SizedBox(width: 6.sp),
                  Text(
                    '${doctor.ratingPoints}',
                    style: TextStyle(
                      fontSize: 12.sp,
                      // color: Colors.grey,
                      // fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 2.sp),
                child: Text(
                  '(3.9k bình luận)',
                  style: TextStyle(
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                top: 5.sp,
                left: 10.sp,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${Strings.doctor.tr} ${Tx.getFullName(doctor.lastName, doctor.firstName)}',
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Divider(
                    color: Colors.grey[300],
                    thickness: 0.5.sp,
                    height: 10.sp,
                  ),
                  Column(
                    children: [
                      _getDescription('Chuyên ngành: ', '${doctor.specialists?[0]["name"]}'),
                      _getDescription('Địa chỉ: ', '${doctor.address}'),
                      if (doctor.distance != null)
                        _getDescription('Khoảng cách: ', 'cách bạn ${doctor.distance?["text"]}'),
                    ],
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
