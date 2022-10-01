import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/modules/appointment/controllers/booking/booking_controller.dart';

class PackageItem extends StatelessWidget {
  final int id;
  final String name;
  final String description;
  final double price;

  PackageItem({
    Key? key,
    required this.id,
    required this.name,
    required this.description,
    required this.price,
  }) : super(key: key);

  final _c = Get.find<BookingController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteHighlight,
        borderRadius: BorderRadius.circular(12.sp),
      ),
      margin: EdgeInsets.only(bottom: 20.sp),
      padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 16.sp),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5.sp,
                ),
                Text(
                  description,
                  maxLines: 2,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 10.sp,
                    overflow: TextOverflow.fade,
                    // wordSpacing: 0.1,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '\$ $price',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          ObxValue<RxInt>(
            (data) => Radio(
              onChanged: (int? value) {
                value != null ? _c.setServiceId(value) : null;
              },
              value: id,
              groupValue: data.value,
            ),
            _c.rxServiceId,
          ),
        ],
      ),
    );
  }
}
