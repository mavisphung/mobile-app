import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/util/enum.dart' as mytag;
import 'package:hi_doctor_v2/app/common/util/transformation.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/models/pathology.dart';
import 'package:hi_doctor_v2/app/modules/health_record/controllers/edit_health_record_controller.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_icon_button.dart';
import 'package:hi_doctor_v2/app/routes/app_pages.dart';

class PathologyView extends StatelessWidget {
  final _cEditOtherHealthRecord = Get.find<EditOtherHealthRecordController>();

  PathologyView({super.key});

  @override
  Widget build(BuildContext context) {
    return ObxValue<RxList<Pathology>>(
      (data) {
        if (data.isEmpty) {
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
            var p = data[index];
            return Container(
              padding: EdgeInsets.all(15.sp),
              decoration: BoxDecoration(
                color: AppColors.grey200,
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
                          Tx.getPathologyString(p.code, p.diseaseName),
                        ),
                      ),
                      SizedBox(width: 10.sp),
                      CustomIconButton(
                        size: 28.sp,
                        color: AppColors.grey300.withOpacity(0.7),
                        onPressed: () => Get.toNamed(Routes.EDIT_PATHOLOGY_RECORD,
                            arguments: p.copyWith(), parameters: {'tag': mytag.Action.update.name}),
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
          itemCount: data.length,
          separatorBuilder: (_, __) => SizedBox(
            height: 5.sp,
          ),
        );
      },
      _cEditOtherHealthRecord.rxPathologies,
    );
  }
}
