import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';

import 'package:hi_doctor_v2/app/modules/health_record/controllers/edit_health_record_controller.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_icon_button.dart';

class RecordItem extends StatefulWidget {
  final int recordIndex;

  const RecordItem({
    super.key,
    required this.recordIndex,
  });

  @override
  State<RecordItem> createState() => _RecordItemState();
}

class _RecordItemState extends State<RecordItem> {
  final _cEditHealthRecord = Get.find<EditHealthRecordController>();
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final record = _cEditHealthRecord.getRecords[widget.recordIndex];
    return Container(
      padding: EdgeInsets.all(15.sp),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(15.sp),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CustomIconButton(
                size: 28.sp,
                color: Colors.redAccent.withOpacity(0.8),
                onPressed: () => _cEditHealthRecord.removeRecord(widget.recordIndex, record.type!),
                icon: Icon(
                  CupertinoIcons.xmark,
                  size: 12.8.sp,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 10.sp),
              Expanded(
                child: Text(
                  '${record.type}',
                ),
              ),
              SizedBox(width: 10.sp),
              CustomIconButton(
                size: 28.sp,
                color: AppColors.grey300.withOpacity(0.7),
                onPressed: () => setState(() {
                  _isExpanded = !_isExpanded;
                }),
                icon: Icon(
                  CupertinoIcons.chevron_down,
                  size: 12.8.sp,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          if (record.tickets != null && _isExpanded) RecordGrid(recordIndex: widget.recordIndex),
        ],
      ),
    );
  }
}

class RecordGrid extends StatefulWidget {
  final int recordIndex;

  const RecordGrid({
    Key? key,
    required this.recordIndex,
  }) : super(key: key);

  @override
  State<RecordGrid> createState() => _RecordGridState();
}

class _RecordGridState extends State<RecordGrid> {
  late RxInt _recordsLength;
  final _cEditHealthRecord = Get.find<EditHealthRecordController>();

  @override
  void dispose() {
    _recordsLength.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final records = _cEditHealthRecord.getTicketsWithRecordId(widget.recordIndex);
    if (records == null) return const SizedBox.shrink();
    _recordsLength = records.length.obs;
    return Padding(
      padding: EdgeInsets.only(top: 10.sp),
      child: SizedBox(
        height: 150.sp,
        child: ObxValue<RxInt>(
          (data) => GridView.builder(
            padding: EdgeInsets.only(bottom: 5.sp),
            physics: const BouncingScrollPhysics(),
            itemCount: data.value,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 10.sp,
              mainAxisSpacing: 20.sp,
              childAspectRatio: 0.9,
            ),
            itemBuilder: (_, int index) {
              String e = records[index];
              return Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.sp),
                      image: DecorationImage(
                        image: FileImage(File(e)),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: CustomIconButton(
                      size: 28.sp,
                      color: AppColors.grey300.withOpacity(0.7),
                      onPressed: () => setState(() {
                        _cEditHealthRecord.removeTicket(widget.recordIndex, index);
                      }),
                      icon: Icon(
                        CupertinoIcons.xmark,
                        size: 12.8.sp,
                        color: Colors.black87,
                      ),
                    ),
                  )
                ],
              );
            },
          ),
          _recordsLength,
        ),
      ),
    );
  }
}
