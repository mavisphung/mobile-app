import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      borderRadius: BorderRadius.circular(5.sp),
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              offset: const Offset(0, 2),
              blurRadius: 2.0,
            ),
          ],
          borderRadius: BorderRadius.circular(5.sp),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                image,
                fit: BoxFit.cover,
                width: 33.0,
                height: 33.0,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    // left: 10.sp,
                    top: 4.sp,
                  ),
                  child: Text(
                    label,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<CategoryItem> categoriesList = [
  const CategoryItem(
    label: 'Cardiology',
    image: 'assets/images/specs/cardio.png',
  ),
  const CategoryItem(
    label: 'Pediatrics',
    image: 'assets/images/specs/baby.png',
  ),
  const CategoryItem(
    label: 'Dentistry',
    image: 'assets/images/specs/dental.png',
  ),
  const CategoryItem(
    label: 'Pulmonology',
    image: 'assets/images/specs/lung.png',
  ),
  const CategoryItem(
    label: 'Physical therapy',
    image: 'assets/images/specs/physical.png',
  ),
  const CategoryItem(
    label: 'More',
    image: 'assets/images/specs/more.png',
  ),
];
