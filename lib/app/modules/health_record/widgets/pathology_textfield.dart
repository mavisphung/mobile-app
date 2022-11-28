import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/models/pathology.dart';
import 'package:hi_doctor_v2/app/modules/health_record/views/pathology_search_delegate.dart';

class PathologyTextField extends StatelessWidget {
  final void Function(Pathology) onChoose;
  final bool? hasLabel;
  final double? height;
  const PathologyTextField({super.key, required this.onChoose, this.hasLabel, this.height});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await showSearch(
          context: context,
          delegate: PathologySearchDelegate(onChoose: onChoose),
        );
      },
      child: SizedBox(
        height: height?.sp ?? 80.sp,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (hasLabel ?? true)
              Padding(
                padding: EdgeInsets.only(
                  left: 19.sp,
                  bottom: 1.sp,
                ),
                child: Text(
                  'Bệnh lý',
                  style: DefaultTextStyle.of(context).style.copyWith(
                        fontSize: 11.5.sp,
                        color: Colors.grey[600],
                      ),
                ),
              ),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 16.sp,
                horizontal: Constants.padding.sp,
              ),
              decoration: BoxDecoration(
                color: AppColors.whiteHighlight,
                borderRadius: BorderRadius.circular(Constants.textFieldRadius.sp),
              ),
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      'Nhấn để tìm và chọn bệnh lý',
                      maxLines: 1,
                      style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 13.8.sp,
                        color: Colors.grey[850],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
