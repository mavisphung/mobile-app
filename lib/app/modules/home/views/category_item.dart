import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:hi_doctor_v2/app/models/specialist.dart';

class CategoryItem extends StatelessWidget {
  final Specialist spec;

  const CategoryItem({
    Key? key,
    required this.spec,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(8.sp),
      child: SizedBox(
        width: 90.sp,
        child: Column(
          children: [
            SvgPicture.asset(
              _getIconOfSpec(spec.id!),
              fit: BoxFit.cover,
              width: 33.sp,
              height: 33.sp,
            ),
            SizedBox(
              height: 4.sp,
            ),
            Expanded(
              child: Text(
                '${spec.name}',
                style: TextStyle(fontSize: 11.6.sp),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getIconOfSpec(int specId) {
    switch (specId) {
      case 1:
        return 'assets/icons/specs/general.svg';
      case 2:
        return 'assets/icons/specs/cardiology.svg';
      case 3:
        return 'assets/icons/specs/baby.svg';
      case 4:
        return 'assets/icons/specs/skin.svg';
      case 5:
        return 'assets/icons/specs/earnose.svg';
      case 6:
        return 'assets/icons/specs/skeleton.svg';
      case 7:
        return 'assets/icons/specs/eye.svg';
      case 8:
        return 'assets/icons/specs/psychology.svg';
      case 9:
        return 'assets/icons/specs/traditional_medicine.svg';
      default:
        return '';
    }
  }
}
