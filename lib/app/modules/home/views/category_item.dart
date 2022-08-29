import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryItem extends StatelessWidget {
  final String label;
  final String image;
  final int doctorCounter;

  const CategoryItem({
    Key? key,
    required this.label,
    required this.image,
    required this.doctorCounter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 75.sp,
      height: 65.sp,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Image.asset(
              image,
              fit: BoxFit.cover,
              width: 23.0,
              height: 23.0,
            ),
          ),
          SizedBox(
            height: 35.sp,
            child: Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 3,
            ),
          ),
          Text(
            '$doctorCounter doctors',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }
}

List<CategoryItem> CategoriesList = [
  const CategoryItem(
    label: 'Cardio Specialist',
    image: 'assets/images/gg_ic.png',
    doctorCounter: 5,
  ),
  const CategoryItem(
    label: 'Heart issue',
    image: 'assets/images/gg_ic.png',
    doctorCounter: 5,
  ),
  const CategoryItem(
    label: 'Dental care',
    image: 'assets/images/gg_ic.png',
    doctorCounter: 5,
  ),
  const CategoryItem(
    label: 'Hello',
    image: 'assets/images/gg_ic.png',
    doctorCounter: 5,
  ),
  const CategoryItem(
    label: 'Hello',
    image: 'assets/images/gg_ic.png',
    doctorCounter: 5,
  ),
  const CategoryItem(
    label: 'Hello',
    image: 'assets/images/gg_ic.png',
    doctorCounter: 5,
  ),
  const CategoryItem(
    label: 'Hello',
    image: 'assets/images/gg_ic.png',
    doctorCounter: 5,
  ),
  const CategoryItem(
    label: 'Hello',
    image: 'assets/images/gg_ic.png',
    doctorCounter: 5,
  ),
  const CategoryItem(
    label: 'Hello',
    image: 'assets/images/gg_ic.png',
    doctorCounter: 5,
  ),
  const CategoryItem(
    label: 'Hello',
    image: 'assets/images/gg_ic.png',
    doctorCounter: 5,
  ),
  const CategoryItem(
    label: 'Hello',
    image: 'assets/images/gg_ic.png',
    doctorCounter: 5,
  ),
];
