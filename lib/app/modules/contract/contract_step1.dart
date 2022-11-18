import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/modules/contract/controllers/create_contract_controller.dart';
import 'package:hi_doctor_v2/app/modules/contract/models/monitored_pathology.dart';
import 'package:hi_doctor_v2/app/modules/contract/widgets/pathology_extendable_row.dart';
import 'package:hi_doctor_v2/app/modules/health_record/controllers/health_record_controller.dart';
import 'package:hi_doctor_v2/app/modules/health_record/models/hr_res_model.dart';
import 'package:hi_doctor_v2/app/modules/widgets/loading_widget.dart';

class ContractStep1 extends StatelessWidget {
  final _cHealthRecord = Get.put(HealthRecordController());
  final _c = Get.put(CreateContractController());

  final List<Map<String, dynamic>> _lCategory = [];

  ContractStep1({super.key});

  void _categorizeDisease(List diseases) {
    for (var d in diseases) {
      final cate = _lCategory.firstWhereOrNull((e) => e['generalName'] == d['generalName']);
      if (cate == null) {
        _lCategory.add({
          'generalName': d['generalName'],
          'diseases': [
            {
              'id': d['id'],
              'code': d['code'],
              'otherCode': d['otherCode'],
              'diseaseName': d['diseaseName'],
            },
          ],
        });
      } else {
        final updatedCate = cate['diseases'] as List;
        updatedCate.add({
          'id': d['id'],
          'code': d['code'],
          'otherCode': d['otherCode'],
          'diseaseName': d['diseaseName'],
        });
        cate['diseases'] = updatedCate;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ObxValue<RxList<MonitoredPathology>>(
          (data) {
            if (data.isNotEmpty) {
              return Text(data.toString());
            }
            return GestureDetector(
              onTap: () => showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (_) {
                  _lCategory.clear();
                  return Container(
                    height: Get.height * 0.85,
                    padding: EdgeInsets.symmetric(vertical: 20.sp),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(40.sp), topRight: Radius.circular(40.sp)),
                    ),
                    child: Column(
                      children: [
                        const Text('Danh sách bệnh lý bạn đã thêm'),
                        Expanded(
                          child: ObxValue<RxList<HrResModel>>(
                            (data) {
                              if (data.isNotEmpty) {
                                for (var hr in data) {
                                  final pList = hr.detail?['pathologies'] as List;
                                  _categorizeDisease(pList);
                                }
                                return ListView.builder(
                                  itemBuilder: (_, index) {
                                    return PathologyExtendableRow(
                                      generalName: _lCategory[index]['generalName'],
                                      diseaseList: _lCategory[index]['diseases'] as List,
                                    );
                                  },
                                  itemCount: _lCategory.length,
                                );
                              }
                              return const LoadingWidget();
                            },
                            _cHealthRecord.otherList,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              child: Container(
                child: Row(
                  children: const [
                    Text('Chọn bệnh lý cần theo dõi'),
                    Icon(
                      CupertinoIcons.add,
                    ),
                  ],
                ),
              ),
            );
          },
          _c.lMonitoredPathology,
        ),
      ],
    );
  }
}
