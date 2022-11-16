import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/common/util/transformation.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:hi_doctor_v2/app/modules/home/controllers/doctor_controller.dart';
import 'package:hi_doctor_v2/app/modules/home/views/doctor_tile.dart';
import 'package:hi_doctor_v2/app/modules/widgets/base_page.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_bottom_sheet.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_container.dart';
import 'package:hi_doctor_v2/app/modules/widgets/image_container.dart';
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
                    ? const Icon(
                        PhosphorIcons.star,
                        color: Colors.amber,
                      )
                    : const Icon(
                        PhosphorIcons.star_fill,
                        color: Colors.amber,
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
                  CustomContainer(
                    borderRadius: 8.sp,
                    child: Row(
                      children: [
                        ImageContainer(
                          width: 120,
                          height: 120,
                          imgUrl: _cDoctor.doctor.avatar,
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(left: 15.sp),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  '${Strings.doctor} ${Tx.getFullName(_cDoctor.doctor.lastName, _cDoctor.doctor.firstName)}',
                                  style: TextStyle(
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Divider(
                                  color: AppColors.greyDivider,
                                  thickness: 0.3.sp,
                                ),
                                Text(
                                  'Bác sĩ khoa tổng hợp',
                                  style: TextStyle(fontSize: 11.5.sp),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 5.sp),
                                  child: Text(
                                    'Bệnh viện Hùng Vương, Tp. HCM, VN dkf dnfkd dknfk  sdkf dfk dfknskf knfk d knkd ',
                                    maxLines: 2,
                                    style: TextStyle(
                                      fontSize: 11.5.sp,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.sp),
                  CustomContainer(
                    borderRadius: 8.sp,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DoctorTile(
                            icon: Icon(
                              PhosphorIcons.users_thin,
                              size: 30.sp,
                              color: AppColors.primary,
                            ),
                            middleText: '5,000+',
                            bottomText: 'Bệnh nhân',
                          ),
                          DoctorTile(
                            icon: Icon(
                              PhosphorIcons.chart_line_up_thin,
                              size: 30.sp,
                              color: AppColors.primary,
                            ),
                            middleText: '10+',
                            bottomText: 'Năm lam viec',
                          ),
                          DoctorTile(
                            icon: Icon(
                              PhosphorIcons.star_thin,
                              size: 30.sp,
                              color: AppColors.primary,
                            ),
                            middleText: '4.8',
                            bottomText: 'Đánh giá',
                          ),
                          DoctorTile(
                            icon: Icon(
                              PhosphorIcons.chat_teardrop_text_thin,
                              size: 30.sp,
                              color: AppColors.primary,
                            ),
                            middleText: '321',
                            bottomText: 'Lượt review',
                          ),
                        ],
                      ),
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
                            text:
                                '${Strings.doctor} ${Tx.getFullName(_cDoctor.doctor.lastName, _cDoctor.doctor.firstName)} là một trong những bác sĩ '
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
                                      ImageContainer(
                                        width: 53,
                                        height: 53,
                                        imgUrl: _cDoctor.doctor.avatar,
                                      ).circle(),
                                      SizedBox(width: 20.sp),
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
                                      text:
                                          'Tôi có thể thấy rằng đây có thể giải quyết cho cái lưng đau của tôi một cách triệt để',
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
