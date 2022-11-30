import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/common/util/transformation.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:hi_doctor_v2/app/models/doctor.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_inkwell.dart';
import 'package:hi_doctor_v2/app/modules/widgets/image_container.dart';
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
    return Row(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      width: 330.sp,
      onTap: () {
        'Call api get doctor with id ${doctor.id}'.debugLog('Doctor instance');
        Get.toNamed(Routes.DOCTOR_DETAIL, arguments: doctor.id);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageContainer(
            width: 100,
            height: 100,
            imgUrl: doctor.avatar,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                top: 5.sp,
                left: 10.sp,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${Strings.doctor} ${Tx.getFullName(doctor.lastName, doctor.firstName)}',
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
                    height: 20.sp,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _getDescription('Chuyên ngành: ', '${doctor.specialists?[0]["name"]}'),
                        if (doctor.distance != null)
                          Padding(
                            padding: EdgeInsets.only(top: 8.sp),
                            child: _getDescription('Khoảng cách: ', 'cách bạn ${doctor.distance?["text"]}'),
                          ),
                        Padding(
                          padding: EdgeInsets.only(top: 8.sp),
                          child: Row(
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
                              Text(
                                ' (0 bình luận)',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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
