import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hi_doctor_v2/app/common/constants.dart';

import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/modules/widgets/image_container.dart';

class ReminderCard extends StatelessWidget {
  const ReminderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shadowColor: AppColors.shadow,
      color: Colors.white,
      shape: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(Constants.borderRadius.sp),
      ),
      child: ListTile(
        dense: true,
        contentPadding: EdgeInsets.symmetric(vertical: 15.sp, horizontal: 10.sp),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ImageContainer(
              width: 50,
              height: 50,
              imgUrl: null,
            ).circle(),
            SizedBox(width: 10.sp),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dr. Minh Thiên',
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 14.sp,
                      // color: Colors.black,
                      fontWeight: FontWeight.w600,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Text(
                    'Dental specialist',
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.more_vert,
              color: Colors.black54,
            ),
          ],
        ),
        subtitle: Padding(
          padding: EdgeInsets.only(top: 15.sp),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.sp,
                  vertical: 10.sp,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFDAFFEF),
                  borderRadius: BorderRadius.circular(10.sp),
                ),
                child: Text(
                  'Wednesday, July 29',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 13.2.sp,
                  ),
                ),
              ),
              SizedBox(width: 10.sp),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.sp,
                  vertical: 10.sp,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE4E4),
                  borderRadius: BorderRadius.circular(10.sp),
                ),
                child: Text(
                  '11:00 am - 12:00 am',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 13.2.sp,
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
