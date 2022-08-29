import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ReminderCard extends StatelessWidget {
  const ReminderCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.rawSnackbar(message: 'Card click'),
      // splashColor: Colors.white,
      highlightColor: Color.fromARGB(157, 155, 39, 176),
      splashFactory: NoSplash.splashFactory,
      borderRadius: BorderRadius.circular(10.sp),
      child: Ink(
        padding: EdgeInsets.all(12.sp),
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(10.sp),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 53.0.sp,
                  height: 53.0.sp,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage('https://cuu-be.s3.amazonaws.com/cuu-be/2022/6/28/O2VWFV.png'),
                    ),
                  ),
                ),
                Column(
                  children: const [
                    Text('Dr. lalalalalala'),
                    Text('shskdfsnf'),
                  ],
                )
              ],
            ),
            Row(
              children: const [
                Icon(CupertinoIcons.calendar),
                Text('Monday, July 29'),
                Spacer(),
                Icon(CupertinoIcons.time),
                Text('11:00 - 12:00 AM'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
