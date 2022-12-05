import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/constants.dart';

import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/modules/appointment/controllers/booking/booking_controller.dart';
import 'package:intl/intl.dart';

// ignore: constant_identifier_names
enum CategoryType { AT_DOCTOR_HOME, AT_PATIENT_HOME, ONLINE }

const List<String> _categoryStr = ['Tại nhà bác sĩ', 'Tại nhà bệnh nhân', 'Trực tuyến'];

class PackageItem extends StatelessWidget {
  final int id;
  final String name;
  final String description;
  final double price;
  final String? category;

  PackageItem({
    Key? key,
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
  }) : super(key: key);

  final _c = Get.find<BookingController>();

  String getPrice() {
    return NumberFormat.decimalPattern('vi,VN').format(price);
  }

  String getCategory() {
    final index = CategoryType.values.indexWhere((e) => e.name == category);
    if (index != -1) return _categoryStr[index];
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteHighlight,
        borderRadius: BorderRadius.circular(Constants.borderRadius.sp),
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
                  height: 10.sp,
                ),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12.sp,
                  ),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                Text(
                  getCategory(),
                  style: TextStyle(
                    color: AppColors.secondary,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 8.sp,
          ),
          Text(
            getPrice(),
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              fontFamily: 'OpenSans',
            ),
          ),
          ObxValue<RxInt>(
            (data) => Radio(
              onChanged: (int? value) {
                if (value != null) {
                  _c.setServiceId(value);
                }
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
