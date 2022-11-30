import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/modules/contract/controllers/create_contract_controller.dart';
import 'package:hi_doctor_v2/app/modules/contract/models/monitored_pathology.dart';
import 'package:hi_doctor_v2/app/modules/contract/widgets/recommend_hr_extendable_row.dart';
import 'package:hi_doctor_v2/app/modules/contract/widgets/recommend_other_widget.dart';
import 'package:hi_doctor_v2/app/modules/health_record/widgets/record_dropdown.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_container.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_elevate_btn_widget.dart';

class RecommendItem extends StatefulWidget {
  final MonitoredPathology data;

  const RecommendItem({super.key, required this.data});

  @override
  State<RecommendItem> createState() => _RecommendItemState();
}

class _RecommendItemState extends State<RecommendItem> {
  final _c = Get.find<CreateContractController>();
  final List<Map<String, dynamic>> _lType = [];
  int prescriptionCount = 0;

  Widget _getDivider() {
    return Divider(
      color: AppColors.greyDivider,
      thickness: 0.5.sp,
      height: 15,
    );
  }

  void _groupRecordType() {
    final records = widget.data.pathology?['records'] as List;
    final prescriptions = widget.data.pathology?['prescriptions'] as List;
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
    for (var p in prescriptions) {
      bool isGenerated = false;
      final typeItem = _lType.firstWhere((e) => e['typeId'] == 5, orElse: () {
        isGenerated = true;
        return {
          'typeId': recordTypes[5]['value'],
          'typeName': recordTypes[5]['label'],
          'details': [],
        };
      });
      (typeItem['details'] as List).add(
        {
          'record': {
            'id': p['record']['id'],
            'createdAt': p['record']['createdAt'],
            'isPatientProvided': p['record']['isPatientProvided'],
          },
          'recordName': p['recordName'],
          'prescriptions': [],
        },
      );
      if (isGenerated) _lType.add(typeItem);
    }
  }

  void _showModalSheet(BuildContext ctx, Map<String, dynamic> map) {
    prescriptionCount = 0;
    final details = map['details'] as List;
    showModalBottomSheet(
      isScrollControlled: true,
      context: ctx,
      builder: (_) {
        return Container(
          height: Get.height * 0.9,
          padding: EdgeInsets.symmetric(vertical: 30.sp, horizontal: Constants.padding.sp),
          decoration: BoxDecoration(
            color: AppColors.grey200,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(8.sp), topRight: Radius.circular(8.sp)),
          ),
          child: Column(
            children: [
              Text('Danh sách ${map["typeName"]}'),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (_, index) {
                    return ReccommendHrExtendableRow(map: details[index], ticketType: map["typeName"] as String);
                  },
                  separatorBuilder: (_, __) => const Divider(),
                  itemCount: details.length,
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
                      final tList = d['tickets'] as List?;
                      if (tList?.isNotEmpty == true) {
                        for (var t in tList!) {
                          if (t['isChosen'] == true) {
                            (data['details'] as List).add(t['info']);
                          }
                        }
                      }
                    }
                    sharedTickets.addIf((data['details'] as List).isNotEmpty, data);
                  }

                  final item5 = _lType.firstWhereOrNull((e) => e['typeId'] == 5);
                  final dListItem5 = item5?['details'] as List?;
                  if (dListItem5 != null) {
                    for (var d in dListItem5) {
                      final lPrescriptions = d['prescriptions'] as List?;
                      if (lPrescriptions != null) {
                        for (var p in lPrescriptions) {
                          if (p['isChosen'] == true) {
                            _c.lPrescription.add(p['id']);
                            ++prescriptionCount;
                          } else if (p['isChosen'] == false) {
                            _c.lPrescription.remove(p['id']);
                          }
                        }
                      }
                    }
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
            color: AppColors.grey200,
            borderRadius: 5,
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      PhosphorIcons.first_aid,
                      color: AppColors.primary,
                      size: 25.sp,
                    ),
                    SizedBox(width: 5.sp),
                    Text(
                      'Mã bệnh ${widget.data.pathology?["otherCode"]}',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15.sp),
                ..._lType.map((e) {
                  final tickets = widget.data.sharedRecord?.firstWhereOrNull((r) => r['typeId'] == e['typeId']);
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${e["typeName"]}'),
                          GestureDetector(
                            onTap: () => _showModalSheet(context, e),
                            child: Icon(
                              PhosphorIcons.folder_notch_plus_light,
                              color: AppColors.primary,
                              size: 27.sp,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5.sp),
                      Container(
                          padding: EdgeInsets.symmetric(vertical: 5.sp, horizontal: 8.sp),
                          decoration: BoxDecoration(
                            color: AppColors.blue100,
                            borderRadius: BorderRadius.circular(Constants.textFieldRadius.sp),
                          ),
                          child: Text(
                              '${((tickets?["details"] as List?)?.length) ?? 0 + prescriptionCount} phiếu đã chọn')),
                    ],
                  );
                }).toList(),
                _getDivider(),
                RecommendOtherWidget(
                  setChosenList: (list) {
                    for (var item in list) {
                      final tickets =
                          widget.data.sharedRecord?.firstWhereOrNull((r) => r['typeId'] == item['ticketId']);
                      if (tickets != null) {
                        (tickets['details'] as List).addAll(item['tickets']);
                        return;
                      }
                      final tmp = widget.data.sharedRecord ?? [];
                      tmp.add({
                        'typeId': item['ticketId'],
                        'typeName': item['typeName'],
                        'details': item['tickets'],
                      });
                      widget.data.sharedRecord = tmp;
                    }
                  },
                ),
              ],
            ),
          )
        : Padding(
            padding: EdgeInsets.only(left: 5.sp),
            child: const Text('Không có phiếu y lệnh được gợi ý.'),
          );
  }
}
