import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/util/transformation.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/modules/health_record/controllers/edit_health_record_controller.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_icon_button.dart';

class PathologyView extends StatelessWidget {
  final _cEditHealthRecord = Get.find<EditHealthRecordController>();

  PathologyView({super.key});

  @override
  Widget build(BuildContext context) {
    return ObxValue<RxInt>(
      (data) {
        if (data.value == 0) {
          return const Align(
            heightFactor: 3,
            alignment: Alignment.center,
            child: Text('Bạn chưa thêm bệnh lý nào'),
          );
        }
        return Container(
          height: 150.sp,
          padding: EdgeInsets.symmetric(horizontal: 14.sp),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Constants.textFieldRadius.sp),
            border: Border.all(
              width: 0.2.sp,
              color: Colors.blueGrey.shade200,
            ),
          ),
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: data.value,
            itemBuilder: (_, index) {
              var e = _cEditHealthRecord.getPathologys[index];
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 8.sp),
                child: Row(
                  children: [
                    CustomIconButton(
                      size: 28.sp,
                      color: AppColors.grey300.withOpacity(0.7),
                      onPressed: () => _cEditHealthRecord.removePathology(index),
                      icon: Icon(
                        CupertinoIcons.xmark,
                        size: 12.8.sp,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(width: 10.sp),
                    Flexible(
                      child: Text(
                        Tx.getPathologyString(e.code, e.name),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
      _cEditHealthRecord.pathologiesLength,
    );
  }
}
