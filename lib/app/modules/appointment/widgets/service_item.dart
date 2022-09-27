import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/modules/appointment/controllers/booking/booking_controller.dart';

class ServiceItem extends StatelessWidget {
  final String title;
  final String description;
  final int serviceId;
  final int price;
  final IconData iconData;

  ServiceItem({
    Key? key,
    required this.title,
    required this.description,
    required this.serviceId,
    required this.price,
    required this.iconData,
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
          Container(
            margin: EdgeInsets.only(right: 17.5.sp),
            padding: EdgeInsets.all(12.5.sp),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  offset: const Offset(0, 2),
                  blurRadius: 2.sp,
                ),
              ],
            ),
            child: Icon(
              iconData,
              color: AppColors.primary,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
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
          Column(
            children: [
              Text(
                '\$ $price',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '/ 30 mins',
                style: TextStyle(
                  fontSize: 10.sp,
                ),
              ),
            ],
          ),
          Obx(
            () => Radio(
              onChanged: (int? value) {
                _c.serviceId = value!;
                _c.serviceId.toString().debugLog('Service Id');
              },
              value: serviceId,
              groupValue: _c.serviceId,
            ),
          ),
        ],
      ),
    );
  }
}
