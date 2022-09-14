import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            Image.asset(
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
    image: 'assets/images/specs/cardio.png',
  ),
  const CategoryItem2(
    label: 'Pediatrics',
    image: 'assets/images/specs/baby.png',
  ),
  const CategoryItem2(
    label: 'Dentistry',
    image: 'assets/images/specs/dental.png',
  ),
  const CategoryItem2(
    label: 'Pulmonology',
    image: 'assets/images/specs/lung.png',
  ),
  const CategoryItem2(
    label: 'Physical therapy',
    image: 'assets/images/specs/physical.png',
  ),
  const CategoryItem2(
    label: 'More',
    image: 'assets/images/specs/more.png',
  ),
];
