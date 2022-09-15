import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/models/doctor.dart';
import 'package:hi_doctor_v2/app/modules/home/controllers/home_controller.dart';
import 'package:hi_doctor_v2/app/routes/app_pages.dart';

class DoctorItem extends StatelessWidget {
  final Doctor doctor;

  DoctorItem({
    Key? key,
    required this.doctor,
  }) : super(key: key);

  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250.sp,
      padding: EdgeInsets.only(right: 10.sp),
      child: InkWell(
        onTap: () {
          'Call api get doctor with id ${doctor.id}'.debugLog('Doctor instance');
          Get.toNamed(Routes.DOCTOR_DETAIL, arguments: doctor);
        },
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(10.sp),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 53.0.sp,
                  height: 53.0.sp,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(doctor.avatar!, scale: 1.0),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 8.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dr. ${doctor.firstName} ${doctor.lastName}',
                          overflow: TextOverflow.fade,
                          style: TextStyle(
                            fontSize: 16.sp,
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
                        Text(
                          'Experience: ${doctor.experienceYears} years',
                          overflow: TextOverflow.fade,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey,
                          ),
                        ),
                        // Row(
                        //   children: [
                        //     const Icon(
                        //       CupertinoIcons.star_fill,
                        //       color: Colors.yellow,
                        //     ),
                        //     Text(
                        //       '$rating | $reviewNumber reviews',
                        //       style: TextStyle(
                        //         fontSize: 12.sp,
                        //         color: Colors.grey,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
