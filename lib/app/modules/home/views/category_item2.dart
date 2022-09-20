import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryItem2 extends StatelessWidget {
  final String label;
  final String image;

  const CategoryItem2({
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

List<CategoryItem2> categoriesList = [
  const CategoryItem2(
    label: 'Cardiology',
    image: 'assets/icons/specs/cardio2.svg',
  ),
  const CategoryItem2(
    label: 'Pediatrics',
    image: 'assets/icons/specs/baby2.svg',
  ),
  const CategoryItem2(
    label: 'Dentistry',
    image: 'assets/icons/specs/dental2.svg',
  ),
  const CategoryItem2(
    label: 'Pulmonology',
    image: 'assets/icons/specs/lung2.svg',
  ),
  // const CategoryItem2(
  //   label: 'Physical therapy',
  //   image: 'assets/icons/specs/physical.svg',
  // ),
  const CategoryItem2(
    label: 'More',
    image: 'assets/icons/specs/more2.svg',
  ),
];
