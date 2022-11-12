import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';

class ImagePage extends StatelessWidget {
  final imgUrl = Get.arguments as String?;

  ImagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leadingWidth: 200,
        leading: Padding(
          padding: EdgeInsets.only(
            left: 8.sp,
          ),
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Row(
              children: [
                Icon(
                  CupertinoIcons.left_chevron,
                  color: Colors.white,
                  size: 18.sp,
                ),
                Text(
                  Strings.back,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Center(
        child: imgUrl!.endsWith('.svg')
            ? Container(
                height: 500.sp,
                decoration: const BoxDecoration(
                  color: Colors.black,
                ),
                child: SvgPicture.network(
                  imgUrl ?? Constants.defaultAvatar,
                  fit: BoxFit.scaleDown,
                ),
              )
            : Container(
                height: 500.sp,
                decoration: BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                    image: NetworkImage(imgUrl ?? Constants.defaultAvatar),
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
      ),
    );
  }
}
