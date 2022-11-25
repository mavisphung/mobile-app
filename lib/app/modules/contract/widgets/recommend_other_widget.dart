import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/modules/contract/controllers/create_contract_controller.dart';
import 'package:hi_doctor_v2/app/modules/contract/widgets/recommend_hr_extendable_row.dart';
import 'package:hi_doctor_v2/app/modules/contract/widgets/record_type_dropdown.dart';
import 'package:hi_doctor_v2/app/modules/health_record/controllers/health_record_controller.dart';
import 'package:hi_doctor_v2/app/modules/health_record/widgets/record_dropdown.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_elevate_btn_widget.dart';

class RecommendOtherWidget extends StatefulWidget {
  const RecommendOtherWidget({super.key});

  @override
  State<RecommendOtherWidget> createState() => _RecommendOtherWidgetState();
}

class _RecommendOtherWidgetState extends State<RecommendOtherWidget> {
  final _c = Get.find<CreateContractController>();
  final _cHealthRecord = Get.find<HealthRecordController>();

  final List<Map<String, dynamic>> _lOtherTicket = [];
  int totalSharedTickets = 0;

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
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(8.sp), topRight: Radius.circular(8.sp)),
          ),
          child: Column(
            children: [
              const Text('Danh sách phiếu khac'),
              RecordTypeDropDown(recordId: _c.rxRecordId),
              const SizedBox(height: 15),
              Expanded(
                child: ObxValue<RxInt>(
                  (data) {
                    final toChooseList = _lOtherTicket.where((e) => e['ticketId'] == _c.rxRecordId.value).toList();
                    return ListView.separated(
                      itemBuilder: (_, index) {
                        return ReccommendHrExtendableRow(
                            map: toChooseList[index], ticketType: recordTypes[_c.rxRecordId.value]['label'] as String);
                      },
                      separatorBuilder: (_, __) => const Divider(),
                      itemCount: toChooseList.length,
                    );
                  },
                  _c.rxRecordId,
                ),
              ),
              CustomElevatedButtonWidget(
                textChild: 'Xong',
                onPressed: () {
                  totalSharedTickets = 0;
                  final chosenList = <Map<String, dynamic>>[];
                  for (var r in recordTypes) {
                    final toChooseList = _lOtherTicket.where((e) => e['ticketId'] == r['value']).toList();
                    for (var t in toChooseList) {
                      final ticketList = t['tickets'] as List;
                      final tmp = ticketList.where((e) => e['isChosen'] == true).toList();
                      if (tmp.isNotEmpty) {
                        final tmpMap = {
                          'ticketId': t['ticketId'],
                          'typeName': t['typeName'],
                          'tickets': tmp.map((e) => e['info']).toList(),
                        };
                        chosenList.add(tmpMap);
                        totalSharedTickets += tmp.length;
                      }
                    }
                  }
                  _c.lOtherSharedRecord.value = chosenList;
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
    _getOtherTicket();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
        const SizedBox(height: 10),
        Text('$totalSharedTickets phiếu đã chọn')
      ],
    );
  }
}
