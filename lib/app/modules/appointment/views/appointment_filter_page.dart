import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';

import 'package:hi_doctor_v2/app/modules/appointment/controllers/appointment_controller.dart';
import 'package:hi_doctor_v2/app/modules/appointment/widgets/my_chip.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_appbar.dart';

class AppointmentFilterPage extends StatelessWidget {
  AppointmentFilterPage({Key? key}) : super(key: key);
  final AppointmentController _controller = Get.find<AppointmentController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: _controller,
        builder: (AppointmentController controller) {
          return Scaffold(
            appBar: const MyAppBar(
              title: 'Filter',
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.sp),
              child: Column(
                children: [
                  SizedBox(
                    width: 1.sw,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hình thức',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.start,
                          clipBehavior: Clip.hardEdge,
                          spacing: 8.sp,
                          children: _controller.types
                              .map(
                                (e) => MyTypeChip(
                                  backgroundColor: Colors.indigo,
                                  textColor: Colors.white,
                                  isChosen: controller.selectedType == e,
                                  label: e.label,
                                  value: e,
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 1.sp,
                  ),
                  SizedBox(
                    width: 1.sw,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Trạng thái',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.start,
                          clipBehavior: Clip.hardEdge,
                          spacing: 8.sp,
                          children: _controller.statuses
                              .map(
                                (e) => MyStatusChip(
                                  backgroundColor: AppColors.primary,
                                  isChosen: controller.selectedStatus == e,
                                  label: e.label,
                                  value: e,
                                  textColor: controller.selectedStatus == e ? Colors.white : Colors.black,
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
