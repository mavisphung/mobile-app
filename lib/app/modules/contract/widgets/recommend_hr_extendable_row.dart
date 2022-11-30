import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/constants.dart';

import 'package:hi_doctor_v2/app/common/util/utils.dart';
import 'package:hi_doctor_v2/app/modules/contract/controllers/create_contract_controller.dart';
import 'package:hi_doctor_v2/app/modules/health_record/controllers/health_record_controller.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_icon_button.dart';

class ReccommendHrExtendableRow extends StatefulWidget {
  final String ticketType;
  final dynamic map;

  const ReccommendHrExtendableRow({super.key, required this.map, required this.ticketType});

  @override
  State<ReccommendHrExtendableRow> createState() => _ReccommendHrExtendableRowState();
}

class _ReccommendHrExtendableRowState extends State<ReccommendHrExtendableRow> {
  final _cHealthRecord = Get.find<HealthRecordController>();
  final _c = Get.find<CreateContractController>();
  bool _isExpanded = false;
  var isChosenList = <bool>[];

  @override
  Widget build(BuildContext context) {
    final list1 = widget.map['tickets'] as List?;
    final recordId = widget.map['record']?['id'] as int?;
    final isPatientProvided = (widget.map['record']?['isPatientProvided'] as bool?) ?? false;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.sp, horizontal: 12.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/hr1.svg',
                width: 25.sp,
                height: 25.sp,
              ),
              SizedBox(width: 15.sp),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hồ sơ ${widget.map["recordName"]}',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 2.sp),
                    Text(
                      'Tạo ngày ${Utils.formatDate(DateTime.tryParse(widget.map["record"]["createdAt"])!)}',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 10.5.sp,
                      ),
                    ),
                  ],
                ),
              ),
              CustomIconButton(
                size: 28.sp,
                color: Colors.white,
                onPressed: () => setState(() {
                  _isExpanded = !_isExpanded;
                }),
                icon: Icon(
                  _isExpanded ? CupertinoIcons.chevron_up : CupertinoIcons.chevron_down,
                  size: 12.8.sp,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          if (_isExpanded)
            if (list1?.isNotEmpty == true)
              ...list1!
                  .map((e) => Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.sp),
                        child: Row(
                          children: [
                            Container(
                              width: 60.sp,
                              height: 80.sp,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5.sp),
                                image: DecorationImage(
                                  image: NetworkImage(e['info']),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(child: Text(widget.ticketType)),
                            Checkbox(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.sp)),
                                value: e['isChosen'],
                                onChanged: (value) {
                                  setState(() {
                                    e['isChosen'] = value ?? false;
                                  });
                                }),
                          ],
                        ),
                      ))
                  .toList(),
          if (_isExpanded && !isPatientProvided)
            if (recordId != null)
              FutureBuilder<bool?>(
                future: _cHealthRecord.getHrWithId(recordId),
                builder: (ctx, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data == true) {
                      final lprescription = _cHealthRecord.systemHrResModel?.prescriptions;
                      if (lprescription?.isNotEmpty == true) {
                        widget.map['prescriptions'] = lprescription!.map((e) {
                          isChosenList.addIf(
                              isChosenList.length < lprescription.length, _c.lPrescription.contains(e['id']));
                          final index = lprescription.indexOf(e);
                          return {
                            'id': e['id'],
                            'isChosen': isChosenList[index],
                          };
                        }).toList();
                        return Column(
                          children: lprescription.map((e) {
                            final index = lprescription.indexOf(e);
                            final details = e['details'] as List?;
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 5.sp),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 60.sp,
                                    height: 80.sp,
                                    padding: EdgeInsets.symmetric(horizontal: Constants.padding.sp),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5.sp),
                                    ),
                                    child: SvgPicture.asset(
                                      'assets/icons/medicine1.svg',
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: details?.map((e) => Text(e['name'])).toList() ?? [],
                                    ),
                                  ),
                                  Checkbox(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.sp)),
                                      value: widget.map['prescriptions'][index]['isChosen'],
                                      onChanged: (value) {
                                        setState(() {
                                          isChosenList[index] = value ?? false;
                                        });
                                      }),
                                ],
                              ),
                            );
                          }).toList(),
                        );
                      }
                      return const Text('can not get data');
                    } else {
                      return const Text('can not get data');
                    }
                  } else {
                    return Text(recordId.toString());
                  }
                },
              ),
        ],
      ),
    );
  }
}
