import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common/util/extensions.dart';
import '../controllers/appointment_controller.dart';

class MyTypeChip extends StatefulWidget {
  Color backgroundColor;
  Color? textColor;
  BoxDecoration? avatarDecoration;
  String label;
  AppointmentType value;
  bool isChosen;
  Function()? action;

  MyTypeChip({
    Key? key,
    required this.backgroundColor,
    this.textColor,
    this.avatarDecoration,
    required this.label,
    required this.value,
    required this.isChosen,
    this.action,
  }) : super(key: key);

  @override
  State<MyTypeChip> createState() => _MyTypeChipState();
}

class _MyTypeChipState extends State<MyTypeChip> {
  AppointmentController appsController = Get.find<AppointmentController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        appsController.setAppointmentType(widget.value);
        setState(() {
          widget.isChosen = !widget.isChosen;
        });
        print(appsController.selectedType);
      },
      child: Chip(
        elevation: 2.sp,
        padding: const EdgeInsets.all(2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.sp),
        ),
        backgroundColor: widget.isChosen ? widget.backgroundColor : Colors.transparent,
        shadowColor: Colors.black,
        label: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              widget.label,
              style: TextStyle(
                fontSize: 13.sp,
                color: widget.isChosen ? widget.textColor : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Status chip
class MyStatusChip extends StatefulWidget {
  Color backgroundColor;
  Color? textColor;
  BoxDecoration? avatarDecoration;
  String label;
  AppointmentStatus value;
  bool isChosen;
  Function()? action;

  MyStatusChip({
    Key? key,
    required this.backgroundColor,
    this.textColor,
    this.avatarDecoration,
    required this.label,
    required this.value,
    required this.isChosen,
    this.action,
  }) : super(key: key);

  @override
  State<MyStatusChip> createState() => _MyStatusChipState();
}

class _MyStatusChipState extends State<MyStatusChip> {
  AppointmentController appsController = Get.find<AppointmentController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        appsController.setAppointmentStatus(widget.value);
        setState(() {
          widget.isChosen = !widget.isChosen;
        });
        print(appsController.selectedStatus);
      },
      child: Chip(
        elevation: 2.sp,
        padding: const EdgeInsets.all(2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.sp),
        ),
        backgroundColor: widget.isChosen ? widget.backgroundColor : Colors.transparent,
        shadowColor: Colors.black87,
        label: Text(
          widget.label,
          style: TextStyle(fontSize: 13.sp, color: widget.textColor),
        ),
      ),
    );
  }
}
