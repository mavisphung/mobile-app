import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/modules/contract/models/monitored_pathology.dart';
import 'package:hi_doctor_v2/app/modules/contract/widgets/recommend_hr_extendable_row.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_container.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_elevate_btn_widget.dart';

class RecommendItem extends StatefulWidget {
  final MonitoredPathology data;

  const RecommendItem({super.key, required this.data});

  @override
  State<RecommendItem> createState() => _RecommendItemState();
}

class _RecommendItemState extends State<RecommendItem> {
  final List<Map<String, dynamic>> _lType = [];

  final _divider = Divider(color: Colors.grey.shade200, thickness: 0.5.sp);

  void _groupRecordType() {
    final records = widget.data.pathology?['records'] as List;
    for (var r in records) {
      final details = r['detail'] as List;
      for (var d in details) {
        bool isGenerated = false;
        final typeItem = _lType.firstWhere((e) => e['typeId'] == d['id'], orElse: () {
          isGenerated = true;
          return {
            'typeId': d['id'],
            'typeName': d['type'],
            'details': [],
          };
        });
        (typeItem['details'] as List).add(
          {
            'record': {
              'id': r['record']['id'],
              'createdAt': r['record']['createdAt'],
              'isPatientProvided': r['record']['isPatientProvided'],
            },
            'recordName': r['recordName'],
            'tickets': (d['tickets'] as List).map((e) => {'info': e, 'isChosen': false}).toList(),
          },
        );
        if (isGenerated) _lType.add(typeItem);
      }
    }
  }

  void _showModalSheet(BuildContext ctx, Map<String, dynamic> map) {
    final details = map['details'] as List;
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
              Text('Danh sách phiếu ${map["typeName"]}'),
              Expanded(
                child: Column(
                  children: details
                      .map((e) => ReccommendHrExtendableRow(map: e, ticketType: map["typeName"] as String))
                      .toList(),
                ),
              ),
              CustomElevatedButtonWidget(
                textChild: 'Xong',
                onPressed: () {
                  final sharedTickets = [];
                  for (var item in _lType) {
                    final data = {
                      'typeId': item['typeId'],
                      'typeName': item['typeName'],
                      'details': [],
                    };

                    final dList = item['details'] as List;
                    for (var d in dList) {
                      final tList = d['tickets'] as List;
                      for (var t in tList) {
                        if (t['isChosen'] == true) {
                          (data['details'] as List).add(t['info']);
                        }
                      }
                    }
                    sharedTickets.add(data);
                  }
                  widget.data.sharedRecord = sharedTickets;
                  setState(() {});
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
  void initState() {
    _groupRecordType();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _lType.isNotEmpty
        ? CustomContainer(
            color: Colors.grey.shade200,
            child: Column(
              children: [
                Row(
                  children: [
                    Text('Mã bệnh ${widget.data.pathology?["otherCode"]}'),
                    // Text('')/
                  ],
                ),
                ..._lType.map((e) {
                  final tickets = widget.data.sharedRecord?.firstWhereOrNull((r) => r['typeId'] == e['typeId']);
                  return Column(
                    children: [
                      Row(
                        children: [
                          Text('${e["typeName"]}'),
                          GestureDetector(
                            onTap: () => _showModalSheet(context, e),
                            child: SvgPicture.asset(
                              'assets/icons/add_record.svg',
                              width: 20.sp,
                              height: 20.sp,
                            ),
                          ),
                        ],
                      ),
                      tickets != null
                          ? Text('${(tickets["details"] as List).length} phiếu đã chọn')
                          : const Text('0 phieu da chon'),
                    ],
                  );
                }).toList(),
                _divider,
                Row(
                  children: [
                    const Text('Phiếu khác'),
                    GestureDetector(
                      onTap: () {},
                      child: SvgPicture.asset(
                        'assets/icons/add_record.svg',
                        width: 20.sp,
                        height: 20.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}
