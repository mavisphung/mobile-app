import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';

class ReminderCard extends StatelessWidget {
  const ReminderCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: Colors.greenAccent.withOpacity(0.2),
      shape: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(15.sp),
      ),
      child: Container(
        height: 150.sp,
        padding: EdgeInsets.only(
          top: 15.sp,
          left: 15.sp,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.sp),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.greenAccent.withOpacity(0.03),
              Colors.greenAccent.withOpacity(0.18),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.2),
              offset: const Offset(2, 0),
              blurRadius: 2.sp,
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 50.sp,
                      height: 50.sp,
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
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Dr. Nguyen Le Kim Phung',
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.greenAccent[900],
                                    fontWeight: FontWeight.w500,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 5.sp, right: 15.sp),
                                child: Text(
                                  'Monday, July 29',
                                  style: TextStyle(
                                    color: Colors.greenAccent[900],
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 5.sp),
                          Text(
                            'Dental Specials',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const Spacer(),
                Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        bottom: 12.sp,
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 15.sp,
                        horizontal: 10.sp,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFBF8A),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 40.sp),
                        child: const Text(
                          '11:00 AM - 12:00 AM',
                          style: TextStyle(
                            color: Color.fromARGB(255, 194, 87, 0),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: SvgPicture.asset(
                        'assets/icons/clock.svg',
                        width: 45.sp,
                        height: 45.sp,
                      ),
                    )
                  ],
                )
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: SvgPicture.asset(
                'assets/icons/custom_calendar.svg',
                width: 70.sp,
                height: 70.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
