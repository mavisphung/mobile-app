import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:hi_doctor_v2/app/modules/contract/controllers/create_contract_controller.dart';
import 'package:hi_doctor_v2/app/modules/contract/models/monitored_pathology.dart';
import 'package:hi_doctor_v2/app/modules/contract/widgets/pathology_extendable_row.dart';
import 'package:hi_doctor_v2/app/modules/health_record/controllers/health_record_controller.dart';
import 'package:hi_doctor_v2/app/modules/health_record/models/hr_res_model.dart';
import 'package:hi_doctor_v2/app/modules/health_record/widgets/pathology_textfield.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom/patient_option.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_elevate_btn_widget.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_title_section.dart';
import 'package:hi_doctor_v2/app/modules/widgets/loading_widget.dart';

class ContractStep1 extends StatelessWidget {
  final _cHealthRecord = Get.put(HealthRecordController());
  final _c = Get.put(CreateContractController());

  final List<Map<String, dynamic>> _lCategory = [];
  final List<Map<String, dynamic>> _lOtherTicket = [];

  ContractStep1({super.key});

  final _spacing = SizedBox(height: 20.sp);

  void _getOtherTicket(HrResModel hr) {
    final otherTicketList = hr.detail!['otherTickets'] as List;
    for (var t in otherTicketList) {
      _lOtherTicket.add({
        'record': hr.record,
        'id': t['id'],
        'type': t['type'],
        'tickets': t['tickets'],
      });
    }
  }

  void _categorizeDisease(HrResModel hr) {
    final pList = hr.detail!['pathologies'] as List;
    for (var d in pList) {
      final cate = _lCategory.firstWhereOrNull((e) => e['generalName'] == d['generalName']);

      final record = (d['records'] as List).isNotEmpty
          ? {
              'record': hr.record,
              'detail': d['records'],
            }
          : null;

      if (cate == null) {
        _lCategory.add({
          'generalName': d['generalName'],
          'diseases': [
            {
              'id': d['id'],
              'code': d['code'],
              'otherCode': d['otherCode'],
              'generalName': d['generalName'],
              'diseaseName': d['diseaseName'],
              // 'records': [].addNonNull(record),
              'isChosen': false,
            },
          ],
        });
        continue;
      }
      final updatedCate = cate['diseases'] as List;
      final existedP = updatedCate.firstWhereOrNull((e) => e['diseaseName'] == d['diseaseName']);
      if (existedP != null) {
        final tmp = existedP['records'] as List;
        tmp.addNonNull(record);
        continue;
      }
      updatedCate.add({
        'id': d['id'],
        'code': d['code'],
        'otherCode': d['otherCode'],
        'generalName': d['generalName'],
        'diseaseName': d['diseaseName'],
        // 'records': [].addNonNull(record),
        'isChosen': false,
      });
      cate['diseases'] = updatedCate;
    }
  }

  @override
  Widget build(BuildContext context) {
    final patientOption = PatientOption(context, (p) {
      _c.rxPatient.value = p;
      _cHealthRecord.rxPatient.value = p;
      _cHealthRecord.getOtherHealthRecords(limit: 15);
    });
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTitleSection(
          title: Strings.patientInfo,
          suffixText: Strings.change,
          suffixAction: patientOption.openPatientOptions,
        ),
        patientOption.patientContainer(_c.rxPatient),
        _spacing,
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
                    height: Get.height * 0.9,
                    padding: EdgeInsets.symmetric(vertical: 30.sp, horizontal: Constants.padding.sp),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(40.sp), topRight: Radius.circular(40.sp)),
                    ),
                    child: Column(
                      children: [
                        const Text('Danh sách bệnh lý bạn đã thêm'),
                        const PathologyTextField(),
                        Expanded(
                          child: ObxValue<RxList<HrResModel>>(
                            (data) {
                              if (data.isNotEmpty) {
                                for (var hr in data) {
                                  final pList = hr.detail?['pathologies'] as List?;
                                  final otherTicketList = hr.detail?['otherTickets'] as List?;
                                  if (pList?.isNotEmpty ?? false) {
                                    _categorizeDisease(hr);
                                  }
                                  if (otherTicketList?.isNotEmpty ?? false) {
                                    _getOtherTicket(hr);
                                  }
                                }
                                if (_lCategory.isNotEmpty) {
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
                                return const SizedBox.shrink();
                              } else if (data.isEmpty) {
                                return const SizedBox.shrink();
                              }
                              return const LoadingWidget();
                            },
                            _cHealthRecord.otherList,
                          ),
                        ),
                        CustomElevatedButtonWidget(
                            textChild: 'Xong',
                            onPressed: () {
                              final monitoredItems = [];
                              for (var d in _lCategory) {
                                final dList = d['diseases'] as List;
                                for (var i in dList) {
                                  if (i['isChosen'] == true) monitoredItems.add(i);
                                }
                              }
                              for (var i in monitoredItems) {
                                _c.lMonitoredPathology.add(MonitoredPathology(
                                    null,
                                    {
                                      'id': i['id'],
                                      'code': i['code'],
                                      'otherCode': i['otherCode'],
                                      'generalName': i['generalName'],
                                      'diseaseName': i['diseaseName'],
                                      'records': i['records'],
                                    },
                                    null));
                              }
                              Get.back();
                            }),
                      ],
                    ),
                  );
                },
              ),
              child: Container(
                padding: EdgeInsets.all(Constants.padding.sp),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(Constants.textFieldRadius.sp),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Chọn bệnh lý cần theo dõi',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Icon(PhosphorIcons.magnifying_glass_plus, color: AppColors.primary),
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
