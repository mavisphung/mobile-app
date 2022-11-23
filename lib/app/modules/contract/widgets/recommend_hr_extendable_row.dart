import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:hi_doctor_v2/app/common/util/utils.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
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
    // return Text('${widget.map.toString()}');
    return Container(
      padding: EdgeInsets.all(15.sp),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(15.sp),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/hr1.svg',
                width: 32.sp,
                height: 32.sp,
              ),
              SizedBox(width: 10.sp),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hồ sơ ${widget.map["recordName"]}',
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 2.sp),
                    Text(
                      'Tạo lúc ${Utils.formatDateTime(DateTime.tryParse(widget.map["record"]["createdAt"])!)}',
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
                color: AppColors.grey300.withOpacity(0.7),
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
            ...(widget.map['tickets'] as List)
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
                              value: e['isChosen'],
                              onChanged: (value) {
                                setState(() {
                                  e['isChosen'] = value ?? false;
                                });
                              }),
                        ],
                      ),
                    ))
                .toList()
        ],
      ),
    );
  }
}
