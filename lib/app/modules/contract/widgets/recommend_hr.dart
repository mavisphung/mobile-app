import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        ...data.map((e) => RecommendItem(data: e)).toList(),
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
      height: 25.sp,
      padding: EdgeInsets.symmetric(horizontal: 18.sp),
      decoration: BoxDecoration(
        color: const Color(0xFFDAFFEF),
        borderRadius: BorderRadius.circular(20.sp),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 50.sp,
            child: Text(otherCode ?? ''),
          ),
          Flexible(
              child: Text(
            diseaseName ?? '',
            maxLines: 1,
          )),
        ],
      ),
    );
  }
}
