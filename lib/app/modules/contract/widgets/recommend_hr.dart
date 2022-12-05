import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/modules/contract/controllers/create_contract_controller.dart';
import 'package:hi_doctor_v2/app/modules/contract/models/monitored_pathology.dart';
import 'package:hi_doctor_v2/app/modules/contract/widgets/recommend_item.dart';
import 'package:hi_doctor_v2/app/modules/contract/widgets/recommend_other_widget.dart';
import 'package:hi_doctor_v2/app/modules/widgets/content_container.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_container.dart';
import 'package:hi_doctor_v2/app/modules/widgets/info_container.dart';

class RecommendHr extends StatelessWidget {
  final List<MonitoredPathology> data;
  final _c = Get.find<CreateContractController>();
  RecommendHr({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...data
            .map((e) =>
                MonitoredPathologyRow(otherCode: e.pathology?['otherCode'], diseaseName: e.pathology?['diseaseName']))
            .toList(),
        Divider(color: AppColors.greyDivider, height: 30.sp),
        const ContentTitle1(title: 'Chia sẻ phiếu y lệnh', topPadding: 0, bottomPadding: 8),
        const InfoContainer(
            info:
                'Sau đây là những phiếu y lệnh mà hệ thống gợi ý cho bạn để chia sẻ cho bác sĩ. Những phiếu này tương ứng với bệnh lý mà bạn đã chọn.'),
        ...data
            .map((e) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.sp),
                  child: RecommendItem(data: e),
                ))
            .toList(),
        Divider(color: AppColors.greyDivider, height: 30.sp),
        const ContentTitle1(title: 'Chia sẻ phiếu y lệnh khác', topPadding: 0, bottomPadding: 8),
        CustomContainer(
          color: AppColors.grey200,
          child: RecommendOtherWidget(setChosenList: (list) => _c.lOtherSharedRecord.value = list),
        ),
      ],
    );
  }
}

class MonitoredPathologyRow extends StatelessWidget {
  final String? otherCode;
  final String? diseaseName;
  const MonitoredPathologyRow({super.key, required this.otherCode, required this.diseaseName});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2.sp),
      padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: Constants.padding.sp),
      decoration: BoxDecoration(
        color: AppColors.blue100,
        borderRadius: BorderRadius.circular(5.sp),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 40.sp,
            child: Text(
              otherCode ?? '',
              style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w500),
            ),
          ),
          Flexible(
            child: Text(
              diseaseName ?? '',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
