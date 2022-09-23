import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/storage/storage.dart';

import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:hi_doctor_v2/app/models/user_info.dart';
import 'package:hi_doctor_v2/app/modules/appointment/controllers/booking/booking_controller.dart';
import 'package:hi_doctor_v2/app/modules/widgets/base_page.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_bottom_sheet.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_appbar.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_title_section.dart';
import 'package:hi_doctor_v2/app/routes/app_pages.dart';

class BookingPatientDetailPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final _c = Get.find<BookingController>();

  BookingPatientDetailPage({Key? key}) : super(key: key);

  Widget _getTitle(String text) {
    return SizedBox(
      width: 115.sp,
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userInfo = Storage.getValue<UserInfo2>(CacheKey.USER_INFO.name);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const MyAppBar(title: 'Patient Details'),
      body: BasePage(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: 15.0.sp),
              child: Form(
                key: _formKey,
                child: GetBuilder<BookingController>(
                  init: _c,
                  builder: (_) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ------------- Choose patient section -------------
                        CustomTitleSection(title: Strings.patient.tr),
                        Container(
                          margin: const EdgeInsets.only(bottom: 15.0),
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            vertical: 20.sp,
                            horizontal: 15.sp,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(15.0.sp),
                          ),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _getTitle(Strings.fullName.tr),
                                  Flexible(
                                    child: Text(
                                      '${userInfo?.lastName} ${userInfo?.firstName}',
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  _getTitle(Strings.gender.tr),
                                  Text('${userInfo?.gender}'),
                                ],
                              ),
                              Row(
                                children: [
                                  _getTitle(Strings.dob.tr),
                                  const Text('25/6/2000'),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _getTitle(Strings.address.tr),
                                  Flexible(child: Text('${userInfo?.address}')),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8.0.sp,
                        ),
                        SizedBox(
                          height: 16.0.sp,
                        ),
                        CustomTitleSection(title: Strings.healthIssue.tr),
                        TextFormField(
                          validator: (String? value) {
                            if (value!.length >= 1000) {
                              return Strings.problemLengthMsg.tr;
                            }
                            return null;
                          },
                          focusNode: FocusNode(),
                          controller: _c.problemController,
                          decoration: InputDecoration(
                            hintText: Strings.problemMsg.tr,
                            contentPadding: EdgeInsets.only(top: 16.sp, bottom: 16.sp, left: 18.sp, right: -18.sp),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            filled: true,
                            fillColor: AppColors.whiteHighlight,
                          ),
                          keyboardType: TextInputType.multiline,
                          maxLines: 5,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: CustomBottomSheet(
        buttonText: Strings.kContinue.tr,
        onPressed: () => Get.toNamed(Routes.BOOKING_SUMMARY),
      ),
    );
  }
}
