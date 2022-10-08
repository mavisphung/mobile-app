import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';

class ReminderCard extends StatelessWidget {
  const ReminderCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.rawSnackbar(message: 'Card click'),
      child: Ink(
        height: 150.sp,
        padding: EdgeInsets.all(12.sp),
        decoration: BoxDecoration(
          color: const Color(0xDB5D92EE),
          borderRadius: BorderRadius.circular(10.sp),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 53.sp,
                  height: 53.sp,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage('https://cuu-be.s3.amazonaws.com/cuu-be/2022/6/28/O2VWFV.png'),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.sp,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Dr. Pham Thuan Hi',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Dental Specials',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                )
              ],
            ),
            const Spacer(),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 15.sp,
                horizontal: 10.sp,
              ),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/calendar.svg',
                    color: Colors.white,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.sp),
                    child: const Text(
                      'Monday, July 29',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const Spacer(),
                  SvgPicture.asset(
                    'assets/icons/clock.svg',
                    color: Colors.white,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.sp),
                    child: const Text(
                      '11:00 - 12:00 AM',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
