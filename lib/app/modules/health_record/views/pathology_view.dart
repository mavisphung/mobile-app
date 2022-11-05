import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/util/transformation.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/modules/health_record/controllers/edit_health_record_controller.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_icon_button.dart';
import 'package:hi_doctor_v2/app/routes/app_pages.dart';

class PathologyView extends StatelessWidget {
  final _cEditOtherHealthRecord = Get.find<EditOtherHealthRecordController>(tag: 'MAIN');

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
        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (_, index) {
            var e = _cEditOtherHealthRecord.getPathologies[index];
            return Container(
              padding: EdgeInsets.all(15.sp),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(15.sp),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      CustomIconButton(
                        size: 28.sp,
                        color: Colors.redAccent.withOpacity(0.8),
                        onPressed: () => _cEditOtherHealthRecord.removePathology(index),
                        icon: Icon(
                          CupertinoIcons.xmark,
                          size: 12.8.sp,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 10.sp),
                      Expanded(
                        child: Text(
                          Tx.getPathologyString(e.code, e.diseaseName),
                        ),
                      ),
                      SizedBox(width: 10.sp),
                      CustomIconButton(
                        size: 28.sp,
                        color: AppColors.grey300.withOpacity(0.7),
                        onPressed: () =>
                            Get.toNamed(Routes.EDIT_PATHOLOGY_RECORD, arguments: e, parameters: {'tag': 'Save'}),
                        icon: Icon(
                          Icons.edit,
                          size: 14.sp,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
          itemCount: data.value,
          separatorBuilder: (_, __) => SizedBox(
            height: 5.sp,
          ),
        );
      },
      _cEditOtherHealthRecord.pathologiesLength,
    );
  }
}
