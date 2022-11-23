import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/modules/contract/controllers/create_contract_controller.dart';
import 'package:hi_doctor_v2/app/modules/contract/models/monitored_pathology.dart';
import 'package:hi_doctor_v2/app/modules/contract/widgets/recommend_hr_extendable_row.dart';
import 'package:hi_doctor_v2/app/modules/contract/widgets/recommend_item.dart';
import 'package:hi_doctor_v2/app/modules/contract/widgets/record_type_dropdown.dart';
import 'package:hi_doctor_v2/app/modules/health_record/controllers/health_record_controller.dart';
import 'package:hi_doctor_v2/app/modules/health_record/widgets/record_dropdown.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_elevate_btn_widget.dart';

class RecommendHr extends StatelessWidget {
  final List<MonitoredPathology> data;
  final List<Map<String, dynamic>> _lOtherTicket = [];

  final _c = Get.find<CreateContractController>();
  final _cHealthRecord = Get.find<HealthRecordController>();

  RecommendHr({super.key, required this.data});

  void _getOtherTicket() {
    final othherList = _cHealthRecord.otherList;
    if (othherList.isNotEmpty) {
      for (var hr in othherList) {
        final otherTicketList = hr.detail?['otherTickets'] as List?;
        if (otherTicketList?.isNotEmpty ?? false) {
          for (var t in otherTicketList!) {
            _lOtherTicket.add({
              'record': hr.record,
              'recordName': hr.detail?['name'],
              'ticketId': t['id'],
              'typeName': t['type'],
              'tickets': (t['tickets'] as List).map((e) => {'info': e, 'isChosen': false}).toList(),
            });
          }
        }
      }
    }
  }

  void _showModalBottom(BuildContext ctx) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: ctx,
      builder: (_) {
        return Container(
          height: Get.height * 0.9,
          padding: EdgeInsets.symmetric(vertical: 30.sp, horizontal: Constants.padding.sp),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(40.sp), topRight: Radius.circular(40.sp)),
          ),
          child: Column(
            children: [
              const Text('Danh sách phiếu khac'),
              RecordTypeDropDown(recordId: _c.rxRecordId),
              Expanded(
                child: ObxValue<RxInt>(
                  (data) {
                    final chooseList = _lOtherTicket.where((e) => e['ticketId'] == _c.rxRecordId.value).toList();
                    return chooseList.isNotEmpty
                        ? Column(
                            children: chooseList
                                .map((e) => ReccommendHrExtendableRow(
                                    map: e, ticketType: recordTypes[_c.rxRecordId.value]['label'] as String))
                                .toList(),
                          )
                        : const SizedBox.shrink();
                  },
                  _c.rxRecordId,
                ),
              ),
              CustomElevatedButtonWidget(
                textChild: 'Xong',
                onPressed: () {
                  // final sharedTickets = [];
                  // for (var item in _lType) {
                  //   final data = {
                  //     'typeId': item['typeId'],
                  //     'typeName': item['typeName'],
                  //     'details': [],
                  //   };

                  //   final dList = item['details'] as List;
                  //   for (var d in dList) {
                  //     final tList = d['tickets'] as List;
                  //     for (var t in tList) {
                  //       if (t['isChosen'] == true) {
                  //         (data['details'] as List).add(t['info']);
                  //       }
                  //     }
                  //   }
                  //   sharedTickets.add(data);
                  // }
                  // widget.data.sharedRecord = sharedTickets;
                  // setState(() {});
                  Get.back();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _getOtherTicket();
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
        Row(
          children: [
            const Text('Phiếu khác'),
            GestureDetector(
              onTap: () => _showModalBottom(context),
              child: SvgPicture.asset(
                'assets/icons/add_record.svg',
                width: 20.sp,
                height: 20.sp,
              ),
            ),
          ],
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
