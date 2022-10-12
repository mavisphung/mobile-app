import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';

class CategoryItem extends StatelessWidget {
  final String label;
  final String image;

  const CategoryItem({
    Key? key,
    required this.label,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(8.sp),
      child: Container(
        width: 90.sp,
        padding: EdgeInsets.all(8.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              image,
              color: AppColors.primary,
              fit: BoxFit.cover,
              width: 33.0,
              height: 33.0,
            ),
            SizedBox(
              height: 4.sp,
            ),
            Expanded(
              child: Text(
                label,
                style: TextStyle(fontSize: 11.6.sp),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<CategoryItem> categoriesList = [
  const CategoryItem(
    label: 'Cardiology',
    image: 'assets/icons/specs/cardio2.svg',
  ),
  const CategoryItem(
    label: 'Pediatrics',
    image: 'assets/icons/specs/baby2.svg',
  ),
  const CategoryItem(
    label: 'Dentistry',
    image: 'assets/icons/specs/dental2.svg',
  ),
  const CategoryItem(
    label: 'Pulmonology',
    image: 'assets/icons/specs/lung2.svg',
  ),
  // const CategoryItem(
  //   label: 'Physical therapy',
  //   image: 'assets/icons/specs/physical.svg',
  // ),
  const CategoryItem(
    label: 'More',
    image: 'assets/icons/specs/more2.svg',
  ),
];
