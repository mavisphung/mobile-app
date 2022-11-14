import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hi_doctor_v2/app/common/constants.dart';

class ContentContainer extends StatelessWidget {
  final Color? color;
  final Map<String, String> content;
  final double? verPadding;
  final double? hozPadding;
  final double labelWidth;

  const ContentContainer({
    super.key,
    required this.labelWidth,
    required this.content,
    this.color,
    this.verPadding,
    this.hozPadding,
  });

  Widget _getRow(String key, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 25.sp,
          width: labelWidth.sp,
          child: Text(
            key,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Text(value),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: verPadding?.sp ?? 20.sp,
        horizontal: hozPadding?.sp ?? 18.sp,
      ),
      decoration: BoxDecoration(
        color: color ?? Colors.grey.shade200,
        borderRadius: BorderRadius.circular(Constants.padding.sp),
      ),
      child: Column(
        children: content.entries.map((e) => _getRow(e.key, e.value)).toList(),
      ),
    );
  }
}

class ContentRow extends StatelessWidget {
  final Map<String, String> content;
  final double? verPadding;
  final double? hozPadding;
  final double labelWidth;

  const ContentRow({
    super.key,
    required this.content,
    this.verPadding,
    this.hozPadding,
    required this.labelWidth,
  });

  Widget _getRow(String key, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.sp),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: labelWidth.sp,
            child: Text(
              key,
              style: const TextStyle(
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: verPadding?.sp ?? 20.sp,
        horizontal: hozPadding?.sp ?? 18.sp,
      ),
      child: Column(
        children: content.entries.map((e) => _getRow(e.key, e.value)).toList(),
      ),
    );
  }
}

class ContentTitle1 extends StatelessWidget {
  final String title;
  final double? leftPadding;
  final double? topPadding;
  final double? bottomPadding;

  const ContentTitle1({
    super.key,
    required this.title,
    this.leftPadding,
    this.topPadding,
    this.bottomPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: topPadding?.sp ?? 20.sp,
        left: leftPadding?.sp ?? 5.sp,
        bottom: bottomPadding?.sp ?? 0,
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 15.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
