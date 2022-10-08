import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/modules/home/controllers/doctor_controller.dart';
import 'package:hi_doctor_v2/app/modules/home/widgets/doctor_tile.dart';
import 'package:hi_doctor_v2/app/modules/widgets/base_page.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_bottom_sheet.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_appbar.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_title_section.dart';
import 'package:hi_doctor_v2/app/routes/app_pages.dart';

class DoctorDetailPage extends StatelessWidget {
  DoctorDetailPage({Key? key}) : super(key: key);

  final doctorId = Get.arguments as int;

  final _cDoctor = Get.put(DoctorController());

  @override
  Widget build(BuildContext context) {
    return BasePage(
      appBar: MyAppBar(
        title: 'Thông tin bác sĩ',
        actions: [
          Obx(
            () => GestureDetector(
              onTap: () {
                _cDoctor.setFavorite(!_cDoctor.isFavorite.value);
              },
              child: Container(
                padding: EdgeInsets.only(
                  right: 12.sp,
                  left: 12.sp,
                ),
                child: _cDoctor.isFavorite.value
                    ? SvgPicture.asset(
                        'assets/icons/star.svg',
                        color: Colors.amber,
                      )
                    : SvgPicture.asset(
                        'assets/icons/star_fill.svg',
                        color: Colors.amber,
                        width: 23.sp,
                        height: 23.sp,
                      ),
              ),
            ),
          ),
        ],
      ),
      body: FutureBuilder<bool>(
        future: _cDoctor.getDoctorWithId(doctorId),
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == true) {
              return Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 8.sp),
                    padding: EdgeInsets.all(12.sp),
                    width: Get.width,
                    decoration: BoxDecoration(
                      // border: Border.all(color: Colors.grey[200]!),
                      color: Colors.black.withOpacity(0.011),
                      borderRadius: BorderRadius.circular(20.sp),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 120.sp,
                          height: 120.sp,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(15.sp),
                            image: const DecorationImage(
                              image: NetworkImage(Constants.defaultAvatar),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(left: 15.sp),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  'Dr. ${_cDoctor.doctor.firstName} ${_cDoctor.doctor.lastName}',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Divider(
                                  color: AppColors.primary,
                                  thickness: 0.65.sp,
                                ),
                                SizedBox(
                                  height: 30.sp,
                                  child: Text(
                                    'Bác sĩ khoa tổng hợp',
                                    style: TextStyle(fontSize: 11.5.sp),
                                  ),
                                ),
                                Text(
                                  'Bệnh viện Hùng Vương, Tp. HCM, VN',
                                  style: TextStyle(fontSize: 11.5.sp),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 25.sp),
                    padding: EdgeInsets.symmetric(horizontal: 12.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DoctorTile(
                          icon: Icon(
                            PhosphorIcons.users,
                            size: 30.sp,
                            color: AppColors.primary,
                          ),
                          middleText: '5,000+',
                          bottomText: 'Bệnh nhân',
                        ),
                        DoctorTile(
                          icon: Icon(
                            PhosphorIcons.chart_line_up,
                            size: 30.sp,
                            color: AppColors.primary,
                          ),
                          middleText: '10+',
                          bottomText: 'Năm',
                        ),
                        DoctorTile(
                          icon: Icon(
                            Icons.star_half,
                            size: 30.sp,
                            color: AppColors.primary,
                          ),
                          middleText: '4.8',
                          bottomText: 'Đánh giá',
                        ),
                        DoctorTile(
                          icon: Icon(
                            PhosphorIcons.chat_centered_text,
                            size: 30.sp,
                            color: AppColors.primary,
                          ),
                          middleText: '321',
                          bottomText: 'Lượt review',
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: Get.width,
                    margin: EdgeInsets.only(top: 25.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomTitleSection(
                          title: 'Mô Tả',
                        ),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              color: Colors.black,
                              height: 1.25.sp, // Line height
                            ),
                            text: 'Dr. ${_cDoctor.doctor.firstName} ${_cDoctor.doctor.lastName} là một trong những bác sĩ '
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
                    margin: EdgeInsets.only(top: 25.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        CustomTitleSection(
                          title: 'Giờ Làm Việc',
                        ),
                        Text('Thứ 2 - Thứ 6, 17:00 đến 20:00'),
                      ],
                    ),
                  ),
                  Container(
                    width: Get.width,
                    margin: EdgeInsets.only(top: 25.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const CustomTitleSection(
                              title: 'Đánh Giá',
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                'See more reviews'.debugLog('ReviewSection');
                              },
                              child: Text(
                                'Xem thêm',
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
                              margin: EdgeInsets.only(top: 10.sp, bottom: 20.sp),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(right: 20.sp),
                                        width: 53.sp,
                                        height: 53.sp,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(_cDoctor.doctor.avatar!),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'Bệnh nhân ${index + 1}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.sp,
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
                                      //         style: TextStyle(fontSize: 17.sp),
                                      //       ),
                                      //     ],
                                      //   ),
                                      // ),
                                      Wrap(
                                        direction: Axis.horizontal,
                                        spacing: 5.sp,
                                        children: [
                                          Icon(Icons.star_half, size: 20.sp, color: AppColors.primary),
                                          Text(
                                            '5',
                                            style: TextStyle(fontSize: 17.sp),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15.sp,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.black,
                                      ),
                                      text: 'Tôi có thể thấy rằng đây có thể giải quyết cho cái lưng đau của tôi một cách triệt để',
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                      top: 12.sp,
                                    ),
                                    child: Text(
                                      '2 ngày trước',
                                      style: TextStyle(
                                        fontSize: 11.sp,
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
              );
            }
          }
          return const Center(
            child: Text('Đang tải...'),
          );
        },
      ),
      bottomSheet: CustomBottomSheet(
        buttonText: 'Make an appointment',
        onPressed: () => Get.toNamed(
          Routes.BOOKING,
          arguments: _cDoctor.doctor,
        ),
      ),
    );
  }
}
