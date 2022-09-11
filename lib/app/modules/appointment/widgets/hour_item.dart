import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/modules/appointment/controllers/booking/booking_controller.dart';

class HourItem extends StatefulWidget {
  final String text;
  final int id;
  bool isSelected;

  HourItem({
    Key? key,
    required this.text,
    required this.id,
    required this.isSelected,
  }) : super(key: key);

  @override
  State<HourItem> createState() => _HourItemState();
}

class _HourItemState extends State<HourItem> {
  final BookingController bookingController = Get.find<BookingController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.isSelected == false) {
          // 'The time ${widget.text} is chosen'.debugLog('HourItem');
          setState(() {
            widget.isSelected = !widget.isSelected;
          });
          // print(widget.isSelected);
          bookingController.setSelectedId(widget.id);
        } else {
          bookingController.setSelectedId(-1);
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 5.0.sp,
          horizontal: 16.0.sp,
        ),
        decoration: BoxDecoration(
          // border: Border.all(
          //   color: AppColors.primary,
          //   width: 2.5.sp,
          // ),
          borderRadius: BorderRadius.circular(10.0.sp),
          color: widget.isSelected ? AppColors.primary : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              offset: const Offset(0, 2),
              blurRadius: 4.0.sp,
            ),
          ],
        ),
        child: Text(
          widget.text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12.0.sp,
            fontWeight: FontWeight.w400,
            color: widget.isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
