import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/constants.dart';

import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/common/util/transformation.dart';
import 'package:hi_doctor_v2/app/common/util/utils.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:hi_doctor_v2/app/models/doctor.dart';
import 'package:hi_doctor_v2/app/modules/home/controllers/doctor_controller.dart';
import 'package:hi_doctor_v2/app/modules/home/views/doctor_tile.dart';
import 'package:hi_doctor_v2/app/modules/widgets/base_page.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_container.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_elevate_btn_widget.dart';
import 'package:hi_doctor_v2/app/modules/widgets/image_container.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_appbar.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_title_section.dart';
import 'package:hi_doctor_v2/app/routes/app_pages.dart';

class DoctorDetailPage extends StatelessWidget {
  DoctorDetailPage({Key? key}) : super(key: key);

  final doctorId = Get.arguments as int;

  final _cDoctor = Get.put(DoctorController());

  String _getDoctorSpecialist(Doctor doctor) {
    if (doctor.specialists == null) {
      return "Đa khoa";
    }

    return doctor.specialists?[0]['name'];
  }

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
                                    'Chuyên khoa: ${_getDoctorSpecialist(_cDoctor.doctor)}',
                                    style: TextStyle(fontSize: 11.5.sp),
                                  ),
                                  // Padding(
                                  //   padding: EdgeInsets.only(top: 5.sp),
                                  //   child: Text(
                                  //     'Nơi làm việc: ${_cDoctor.doctor.address!.toString()}',
                                  //     maxLines: 2,
                                  //     style: TextStyle(
                                  //       fontSize: 11.5.sp,
                                  //       overflow: TextOverflow.ellipsis,
                                  //     ),
                                  //   ),
                                  // ),
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
                              bottomText: 'Năm',
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
                                  '${Strings.doctor} ${Tx.getFullName(_cDoctor.doctor.lastName, _cDoctor.doctor.firstName)} có kinh nghiệm lâu năm '
                                  'trong các lĩnh vực liên quan về ${_getDoctorSpecialist(_cDoctor.doctor)}. Bác sĩ từng tham gia công tác tại bệnh viện da liễu tại TP.HCM hơn 8 năm. '
                                  'Hiện tại đang công tác tại bệnh viện đại học Y Dược TP.HCM cơ sở 1...',
                              children: [
                                TextSpan(
                                  text: 'Xem thêm',
                                  style: TextStyle(
                                    color: AppColors.primary,
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
                        children: [
                          CustomTitleSection(
                            title: 'Địa điểm',
                            suffixText: 'Xem địa điểm',
                            suffixAction: () {
                              Utils.openMap(_cDoctor.doctor.address!);
                            },
                          ),
                          Text(_cDoctor.doctor.address!.toString()),
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
                            title: 'Thời gian Làm Việc',
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
                                        const ImageContainer(
                                          width: 53,
                                          height: 53,
                                          imgUrl: Constants.defaultAvatar,
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
        bottomSheet: Container(
          width: double.infinity,
          height: 70.sp,
          color: Colors.transparent,
          padding: EdgeInsets.only(
            left: 15.sp,
            right: 15.sp,
            bottom: 20.sp,
          ),
          child: Row(
            children: [
              Expanded(
                child: CustomElevatedButtonWidget(
                  textChild: 'Đặt lịch khám',
                  onPressed: () => Get.toNamed(
                    Routes.BOOKING,
                    arguments: _cDoctor.doctor,
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: CustomElevatedButtonWidget(
                  textChild: 'Yêu cầu hợp đồng',
                  onPressed: () => Get.toNamed(
                    Routes.CREATE_CONTRACT,
                    arguments: _cDoctor.doctor,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
