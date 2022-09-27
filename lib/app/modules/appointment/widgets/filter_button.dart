import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/modules/appointment/views/appointment_filter_page.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => AppointmentFilterPage(), fullscreenDialog: true);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 9.sp,
          vertical: 6.sp,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.sp),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              offset: const Offset(0, 2),
              blurRadius: 4.sp,
            ),
          ],
        ),
        child: const Icon(Icons.sort_rounded),
      ),
    );
  }
}
