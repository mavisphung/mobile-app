import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:hi_doctor_v2/app/models/doctor.dart';
import 'package:hi_doctor_v2/app/routes/app_pages.dart';

class DoctorItem extends StatelessWidget {
  final Doctor doctor;

  const DoctorItem({
    Key? key,
    required this.doctor,
  }) : super(key: key);

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
            detail,
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
    return InkWell(
      onTap: () {
        'Call api get doctor with id ${doctor.id}'.debugLog('Doctor instance');
        Get.toNamed(Routes.DOCTOR_DETAIL, arguments: doctor.id);
      },
      child: Ink(
        width: 300.sp,
        height: 150.sp,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Constants.borderRadius.sp),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(0, 2),
              blurRadius: 4.sp,
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(Constants.padding.sp),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 110.sp,
                height: 115.sp,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(17.sp),
                  image: DecorationImage(
                    image: NetworkImage(doctor.avatar!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 10.sp,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dr. ${doctor.firstName} ${doctor.lastName}',
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      // Text(
                      //   service,
                      //   overflow: TextOverflow.fade,
                      //   style: TextStyle(
                      //     fontSize: 12.sp,
                      //     color: Colors.grey,
                      //   ),
                      // ),
                      Divider(
                        color: Colors.grey[300],
                        thickness: 0.5.sp,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _getDescription(Strings.expYrs.tr, '${doctor.experienceYears?.toStringAsFixed(0)}'),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Icon(
                                  PhosphorIcons.star_fill,
                                  color: Colors.blue,
                                  size: 16.sp,
                                ),
                                SizedBox(width: 6.sp),
                                Text(
                                  '4.6 (5,366 reviews)',
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
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
        ),
      ),
    );
  }
}
