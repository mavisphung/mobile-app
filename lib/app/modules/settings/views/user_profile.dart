import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/values/colors.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // color: const Color(0xFF0601B4),
        color: AppColors.primary,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            offset: const Offset(0, 4),
            blurRadius: 4.0,
          ),
        ],
        borderRadius: BorderRadius.all(
          Radius.circular(5.0.sp),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 18.0),
      child: Row(
        children: [
          Container(
            width: 53.0.sp,
            height: 53.0.sp,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage('https://cuu-be.s3.amazonaws.com/cuu-be/2022/6/28/O2VWFV.png'),
              ),
            ),
          ),
          SizedBox(
            width: 13.0.sp,
          ),
          Expanded(
            child: Wrap(
              // vertical thi dung spacing
              spacing: 4,
              // horizontal thi dung run spacing
              // runSpacing: 100,
              direction: Axis.vertical,
              children: [
                Text(
                  'Huy Phung',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0.sp,
                  ),
                ),
                FittedBox(
                  fit: BoxFit.cover,
                  child: Text(
                    'nguoibimatthegioi@gmail.com',
                    style: TextStyle(
                      color: const Color(0xFFD7D7D7),
                      fontSize: 14.0.sp,
                    ),
                    overflow: TextOverflow.clip,
                  ),
                )
              ],
            ),
          ),
          // const Spacer(),
          GestureDetector(
            onTap: () {
              // Get.toNamed(Profile);
              print('edit');
            },
            child: SvgPicture.asset(
              'assets/images/ic_edit.svg',
              width: 24.0.sp,
              height: 24.0.sp,
              fit: BoxFit.fitWidth,
            ),
          ),
        ],
      ),
    );
  }
}
