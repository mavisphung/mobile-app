import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hi_doctor_v2/app/common/constants.dart';

import 'package:hi_doctor_v2/app/common/util/utils.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_icon_button.dart';

class ReccommendHrExtendableRow extends StatefulWidget {
  final String ticketType;
  final dynamic map;

  const ReccommendHrExtendableRow({super.key, required this.map, required this.ticketType});

  @override
  State<ReccommendHrExtendableRow> createState() => _ReccommendHrExtendableRowState();
}

class _ReccommendHrExtendableRowState extends State<ReccommendHrExtendableRow> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final list1 = widget.map['tickets'] as List?;
    final list2 = widget.map['prescription']?['info'] as List?;
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
          if (_isExpanded)
            if (list2?.isNotEmpty == true)
              Padding(
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
                        children: list2!.map((e) => Text(e['medicineName'])).toList(),
                      ),
                    ),
                    Checkbox(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.sp)),
                        value: widget.map['prescription']['isChosen'],
                        onChanged: (value) {
                          setState(() {
                            widget.map['prescription']['isChosen'] = value ?? false;
                          });
                        }),
                  ],
                ),
              ),
        ],
      ),
    );
  }
}
