import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_icon_button.dart';

class PathologyExtendableRow extends StatefulWidget {
  final String generalName;
  final List diseaseList;

  const PathologyExtendableRow({super.key, required this.generalName, required this.diseaseList});

  @override
  State<PathologyExtendableRow> createState() => _PathologyExtendableRowState();
}

class _PathologyExtendableRowState extends State<PathologyExtendableRow> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
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
              Expanded(
                child: Text(
                  widget.generalName,
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
                  _isExpanded ? CupertinoIcons.chevron_up : CupertinoIcons.chevron_down,
                  size: 12.8.sp,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          if (_isExpanded)
            ...widget.diseaseList
                .map((e) => Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.sp),
                      child: Row(
                        children: [
                          Expanded(child: Text(e['diseaseName']!)),
                          Checkbox(value: true, onChanged: (value) {}),
                        ],
                      ),
                    ))
                .toList()
        ],
      ),
    );
  }
}
