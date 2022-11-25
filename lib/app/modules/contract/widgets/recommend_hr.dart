import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/modules/contract/models/monitored_pathology.dart';
import 'package:hi_doctor_v2/app/modules/contract/widgets/recommend_item.dart';
import 'package:hi_doctor_v2/app/modules/contract/widgets/recommend_other_widget.dart';

class RecommendHr extends StatelessWidget {
  final List<MonitoredPathology> data;

  const RecommendHr({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...data
            .map((e) =>
                MonitoredPathologyRow(otherCode: e.pathology?['otherCode'], diseaseName: e.pathology?['diseaseName']))
            .toList(),
        const Text('Chia sẻ phiếu y lệnh'),
        const Text(
            'Sau đây là những phiếu y lệnh mà hệ thống gợi ý cho bạn để chia sẻ cho bác sĩ. Những phiếu này tương ứng với bệnh lý mà bạn đã chọn.'),
        ...data
            .map((e) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.sp),
                  child: RecommendItem(data: e),
                ))
            .toList(),
        const RecommendOtherWidget(),
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
      padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 18.sp),
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
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
