import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hi_doctor_v2/app/models/doctor.dart';

class DoctorItem extends StatelessWidget {
  final String fullName;
  final String avtUrl;
  final String service;
  final int experienceYears;
  final double rating;
  final int reviewNumber;

  const DoctorItem({
    Key? key,
    required this.fullName,
    this.avtUrl = 'https://cuu-be.s3.amazonaws.com/cuu-be/2022/6/28/O2VWFV.png',
    required this.service,
    required this.experienceYears,
    required this.rating,
    required this.reviewNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250.sp,
      padding: EdgeInsets.only(right: 10.sp),
      child: InkWell(
        onTap: () {},
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(10.sp),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 53.0.sp,
                  height: 53.0.sp,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(avtUrl),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 8.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dr. $fullName',
                          overflow: TextOverflow.fade,
                          style: TextStyle(
                            fontSize: 16.sp,
                          ),
                        ),
                        Text(
                          service,
                          overflow: TextOverflow.fade,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          'Experience: $experienceYears years',
                          overflow: TextOverflow.fade,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              CupertinoIcons.star_fill,
                              color: Colors.yellow,
                            ),
                            Text(
                              '$rating | $reviewNumber reviews',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

List<DoctorItem> doctorList = [
  const DoctorItem(
    fullName: 'Mahnud Nik Hasan',
    service: 'Cardiologist',
    experienceYears: 4,
    rating: 4.6,
    reviewNumber: 56,
  ),
  const DoctorItem(
    fullName: 'Jane Cooper',
    service: 'Heart Surgeon',
    experienceYears: 8,
    rating: 4.7,
    reviewNumber: 102,
  ),
  const DoctorItem(
    fullName: 'Brycen Bradford',
    service: 'Cardiologist',
    experienceYears: 9,
    rating: 4.3,
    reviewNumber: 26,
  ),
  const DoctorItem(
    fullName: 'Tierra Riley',
    service: 'Therapist',
    experienceYears: 2,
    rating: 4.8,
    reviewNumber: 56,
  ),
  const DoctorItem(
    fullName: 'Ashley Wentworth',
    service: 'Cardiologist',
    experienceYears: 4,
    rating: 4.7,
    reviewNumber: 89,
  ),
];

class DoctorItem2 extends StatelessWidget {
  final Doctor doctor;

  const DoctorItem2({
    Key? key,
    required this.doctor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250.sp,
      padding: EdgeInsets.only(right: 10.sp),
      child: InkWell(
        onTap: () {},
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(10.sp),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 53.0.sp,
                  height: 53.0.sp,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(doctor.avatar!, scale: 1.0),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 8.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dr. ${doctor.firstName} ${doctor.lastName}',
                          overflow: TextOverflow.fade,
                          style: TextStyle(
                            fontSize: 16.sp,
                          ),
                        ),
                        // Text(
                        //   service,
                        //   overflow: TextOverflow.fade,
                        //   style: TextStyle(
                        //     fontSize: 12.sp,
                        //     color: Colors.grey,
                        //   ),
                        // ),
                        Text(
                          'Experience: ${doctor.experienceYears} years',
                          overflow: TextOverflow.fade,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey,
                          ),
                        ),
                        // Row(
                        //   children: [
                        //     const Icon(
                        //       CupertinoIcons.star_fill,
                        //       color: Colors.yellow,
                        //     ),
                        //     Text(
                        //       '$rating | $reviewNumber reviews',
                        //       style: TextStyle(
                        //         fontSize: 12.sp,
                        //         color: Colors.grey,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
