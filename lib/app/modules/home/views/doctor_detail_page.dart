import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/models/doctor.dart';
import 'package:hi_doctor_v2/app/modules/home/controllers/doctor_controller.dart';
import 'package:hi_doctor_v2/app/modules/home/controllers/home_controller.dart';
import 'package:hi_doctor_v2/app/modules/home/widgets/doctor_tile.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_appbar.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_section_title.dart';
import 'package:hi_doctor_v2/app/routes/app_pages.dart';

class DoctorDetailPage extends StatefulWidget {
  DoctorDetailPage({Key? key}) : super(key: key);

  @override
  State<DoctorDetailPage> createState() => _DoctorDetailPageState();
}

class _DoctorDetailPageState extends State<DoctorDetailPage> {
  final HomeController homeController = Get.find<HomeController>();
  final DoctorController doctorController = Get.find<DoctorController>();

  @override
  void initState() {
    super.initState();
    doctorController.rxDoctor.value = Get.arguments as Doctor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Dr. ${doctorController.rxDoctor.value.firstName}',
        actions: [
          Obx(
            () => GestureDetector(
              onTap: () {
                doctorController.setFavorite(!doctorController.isFavorite.value);
              },
              child: Container(
                padding: EdgeInsets.only(
                  right: 12.0.sp,
                  left: 12.0.sp,
                ),
                child: doctorController.isFavorite.value
                    ? Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 26.0.sp,
                      )
                    : Icon(
                        Icons.favorite_outline,
                        color: Colors.black,
                        size: 26.0.sp,
                      ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0.sp),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 8.0.sp),
                padding: EdgeInsets.all(12.0.sp),
                width: Get.width,
                decoration: BoxDecoration(
                  // border: Border.all(color: Colors.grey[200]!),
                  color: Colors.black.withOpacity(0.011),
                  borderRadius: BorderRadius.circular(20.0.sp),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 120.0.sp,
                      height: 120.0.sp,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(15.0.sp),
                        image: DecorationImage(
                          image: NetworkImage(Constants.defaultAvatar),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 15.0.sp),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Dr. ${doctorController.doctor.firstName} ${doctorController.doctor.lastName}',
                              style: TextStyle(
                                fontSize: 18.0.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Divider(
                              color: AppColors.primary,
                              thickness: 0.65.sp,
                            ),
                            SizedBox(
                              height: 32.0.sp,
                              child: Text('Bác sĩ khoa tổng hợp'),
                            ),
                            Text('Bệnh viện Hùng Vương, Tp. HCM, VN'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 25.0.sp),
                padding: EdgeInsets.symmetric(horizontal: 12.0.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DoctorTile(
                      icon: Icon(
                        PhosphorIcons.users,
                        size: 30.0.sp,
                        color: AppColors.primary,
                      ),
                      middleText: '5,000+',
                      bottomText: 'patients',
                    ),
                    DoctorTile(
                      icon: Icon(
                        PhosphorIcons.chart_line_up,
                        size: 30.0.sp,
                        color: AppColors.primary,
                      ),
                      middleText: '10+',
                      bottomText: 'years',
                    ),
                    DoctorTile(
                      icon: Icon(
                        Icons.star_half,
                        size: 30.0.sp,
                        color: AppColors.primary,
                      ),
                      middleText: '4.8',
                      bottomText: 'rating',
                    ),
                    DoctorTile(
                      icon: Icon(
                        PhosphorIcons.chat_centered_text,
                        size: 30.0.sp,
                        color: AppColors.primary,
                      ),
                      middleText: '321',
                      bottomText: 'reviews',
                    ),
                  ],
                ),
              ),
              Container(
                width: Get.width,
                margin: EdgeInsets.only(top: 25.0.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   const MySectionTitle(
                      title: 'About me',
                    ),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: Colors.black,
                          height: 1.25.sp, // Line height
                        ),
                        text:
                            'Dr. ${doctorController.doctor.firstName} ${doctorController.doctor.lastName} là một trong những bác sĩ '
                            'giỏi nhất trong khoa tổng hợp của bệnh viện Hùng Vương, TP. HCM. '
                            'Đã từng đạt nhiều mạng người trên tay từ thời gian thực tập. '
                            'Tôi đã hành nghề này được hơn 10 năm...',
                        children: [
                          TextSpan(
                            text: 'Xem thêm',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                'Press Xem thêm button'.debugLog('DoctorTile');
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: Get.width,
                margin: EdgeInsets.only(top: 25.0.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    MySectionTitle(
                      title: 'Working time',
                    ),
                    Text('Monday - Friday, 8:00 AM to 17:30 PM'),
                  ],
                ),
              ),
              Container(
                width: Get.width,
                margin: EdgeInsets.only(top: 25.0.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const MySectionTitle(
                          title: 'Reviews',
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            'See more reviews'.debugLog('ReviewSection');
                          },
                          child: Text(
                            'See all',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 3,
                      itemBuilder: (_, index) {
                        if (index == 2) {
                          return SizedBox(
                            height: Get.height.sp / 100 * 9,
                          );
                        }
                        return Container(
                          margin: EdgeInsets.only(top: 10.0.sp, bottom: 20.0.sp),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 20.0.sp),
                                    width: 53.0.sp,
                                    height: 53.0.sp,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(doctorController.doctor.avatar!),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Bệnh nhân ${index + 1}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0.sp,
                                    ),
                                  ),
                                  const Spacer(),
                                  // ElevatedButton(
                                  //   onPressed: () {},
                                  //   child: Row(
                                  //     children: [
                                  //       Icon(Icons.star_outline),
                                  //       Text(
                                  //         '5',
                                  //         style: TextStyle(fontSize: 17.0.sp),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                  Wrap(
                                    direction: Axis.horizontal,
                                    spacing: 5.0.sp,
                                    children: [
                                      Icon(Icons.star_half, size: 20.0.sp, color: AppColors.primary),
                                      Text(
                                        '5',
                                        style: TextStyle(fontSize: 17.0.sp),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15.0.sp,
                              ),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 14.0.sp,
                                    color: Colors.black,
                                  ),
                                  text:
                                      'Tôi có thể thấy rằng đây có thể giải quyết cho cái lưng đau của tôi một cách triệt để',
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                  top: 12.0.sp,
                                ),
                                child: Text(
                                  '2 ngày trước',
                                  style: TextStyle(
                                    fontSize: 11.0.sp,
                                    color: Colors.grey[900],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        // width: Get.width,
        height: Get.height.sp / 100 * 9,
        padding: EdgeInsets.symmetric(horizontal: 12.0.sp),
        decoration: BoxDecoration(
          color: AppColors.bottomSheet,
          // border: Border.all(color: Colors.black.withOpacity(0.125)),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35.0.sp),
            topRight: Radius.circular(35.0.sp),
          ),
        ),
        child: Center(
          child: SizedBox(
            width: Get.width.sp / 100 * 80,
            height: 40.0.sp,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(AppColors.primary),
                // overlayColor: MaterialStateProperty.all(Colors.transparent),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              child: Text(
                'Make an appointment',
                style: TextStyle(fontSize: 14.0.sp),
              ),
              onPressed: () {
                Get.toNamed(Routes.BOOKING);
              },
            ),
          ),
        ),
      ),
    );
  }
}
