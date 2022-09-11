import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/modules/appointment/controllers/booking/package_controller.dart';

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

  final PackageController packageController = Get.find<PackageController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteHighlight,
        borderRadius: BorderRadius.circular(12.0.sp),
      ),
      margin: EdgeInsets.only(bottom: 20.0.sp),
      padding: EdgeInsets.symmetric(horizontal: 16.0.sp, vertical: 16.0.sp),
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
                  blurRadius: 2.0.sp,
                ),
              ],
            ),
            child: Icon(
              iconData,
              color: AppColors.primary,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.0.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 5.0.sp,
              ),
              Text(
                description,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 10.0.sp,
                  overflow: TextOverflow.fade,
                  // wordSpacing: 0.1,
                ),
              ),
            ],
          ),
          const Spacer(),
          Column(
            children: [
              Text(
                '\$ $price',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 18.0.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '/ 30 mins',
                style: TextStyle(
                  fontSize: 10.0.sp,
                ),
              ),
            ],
          ),
          Obx(
            () => Radio(
              onChanged: (int? value) {
                packageController.serviceId = value!;
                packageController.serviceId.toString().debugLog('Service Id');
              },
              value: serviceId,
              groupValue: packageController.serviceId,
            ),
          ),
        ],
      ),
    );
  }
}
