import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/models/record.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_icon_button.dart';
import 'package:image_picker/image_picker.dart';

class RecordItem extends StatefulWidget {
  final Record record;
  final void Function(int, String) removeRecordFunc;
  final void Function(int, int) removeTicketFunc;

  const RecordItem({
    super.key,
    required this.record,
    required this.removeRecordFunc,
    required this.removeTicketFunc,
  });

  @override
  State<RecordItem> createState() => _RecordItemState();
}

class _RecordItemState extends State<RecordItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.sp),
      decoration: BoxDecoration(
        color: AppColors.grey200,
        borderRadius: BorderRadius.circular(15.sp),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CustomIconButton(
                size: 28.sp,
                color: Colors.redAccent.withOpacity(0.8),
                onPressed: () => widget.removeRecordFunc(widget.record.id!, widget.record.type!),
                icon: Icon(
                  CupertinoIcons.xmark,
                  size: 12.8.sp,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 10.sp),
              Expanded(
                child: Text(
                  '${widget.record.type}',
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
          if (widget.record.xFiles != null && _isExpanded)
            RecordGrid(
              record: widget.record,
              removeTicketFunc: widget.removeTicketFunc,
            ),
        ],
      ),
    );
  }
}

class RecordGrid extends StatefulWidget {
  final Record record;
  final void Function(int, int) removeTicketFunc;

  const RecordGrid({
    Key? key,
    required this.record,
    required this.removeTicketFunc,
  }) : super(key: key);

  @override
  State<RecordGrid> createState() => _RecordGridState();
}

class _RecordGridState extends State<RecordGrid> {
  final RxInt _xFilesLength = 0.obs;

  @override
  void dispose() {
    _xFilesLength.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final xFiles = widget.record.xFiles;
    final tickets = widget.record.tickets;

    if (xFiles == null || tickets == null) return const SizedBox.shrink();

    final list = [];
    list.addAll(tickets);
    list.addAll(xFiles);

    _xFilesLength.value = list.length;

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
              childAspectRatio: 0.8,
            ),
            itemBuilder: (_, int index) {
              final e = list[index];
              return Stack(
                fit: StackFit.expand,
                children: [
                  if (e is XFile)
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.sp),
                        image: DecorationImage(
                          image: FileImage(File(e.path)),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  if (e is String)
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.sp),
                        image: DecorationImage(
                          image: NetworkImage(e),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  Align(
                    alignment: Alignment.topRight,
                    child: CustomIconButton(
                      size: 28.sp,
                      color: AppColors.grey300.withOpacity(0.7),
                      onPressed: () {
                        widget.removeTicketFunc(widget.record.id!, index);
                        list.removeAt(index);
                        data.value = list.length;
                      },
                      icon: Icon(
                        CupertinoIcons.xmark,
                        size: 12.8.sp,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          _xFilesLength,
        ),
      ),
    );
  }
}
