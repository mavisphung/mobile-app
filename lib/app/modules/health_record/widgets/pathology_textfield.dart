import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/modules/health_record/views/pathology_search.dart';

class PathologyTextField extends StatelessWidget {
  const PathologyTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () async {
          await showSearch(
            context: context,
            delegate: PathologySearchDelegate(),
          );
        },
        child: SizedBox(
          height: 80.sp,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                  horizontal: 18.sp,
                ),
                decoration: BoxDecoration(
                  color: AppColors.whiteHighlight,
                  borderRadius: BorderRadius.circular(Constants.textFieldRadius.sp),
                ),
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        'Tap to search and add pathology',
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
      ),
    );
  }
}
