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
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.generalName,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(width: 10.sp),
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
            ...widget.diseaseList
                .map((e) => Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              SizedBox(
                                  width: 42.sp,
                                  child: Text(
                                    e['otherCode'],
                                    style: TextStyle(color: AppColors.primary),
                                  )),
                              Flexible(
                                child: Text(
                                  e['diseaseName'] ?? '',
                                  style: TextStyle(color: AppColors.primary),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Checkbox(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.sp)),
                            value: e['isChosen'],
                            onChanged: (value) {
                              setState(() {
                                e['isChosen'] = value ?? false;
                              });
                            }),
                      ],
                    ))
                .toList()
        ],
      ),
    );
  }
}
