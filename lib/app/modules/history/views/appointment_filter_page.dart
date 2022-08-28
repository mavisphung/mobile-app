import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/modules/history/controllers/history_controller.dart';
import 'package:hi_doctor_v2/app/modules/history/widgets/my_chip.dart';

class AppointmentFilterPage extends StatelessWidget {
  AppointmentFilterPage({Key? key}) : super(key: key);
  final HistoryController historyControler = Get.find<HistoryController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: historyControler,
        builder: (HistoryController controller) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              elevation: 0.0,
              title: const Text(
                'Filter',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              backgroundColor: Colors.transparent,
              leading: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
              child: Column(
                children: [
                  SizedBox(
                    width: 1.sw,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Types',
                          style: TextStyle(
                            fontSize: 18.0.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.start,
                          clipBehavior: Clip.hardEdge,
                          spacing: 8.0.sp,
                          children: historyControler.types
                              .map(
                                (e) => MyTypeChip(
                                  backgroundColor: Colors.greenAccent[100]!,
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
                    thickness: 1.0.sp,
                  ),
                  SizedBox(
                    width: 1.sw,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Status',
                          style: TextStyle(
                            fontSize: 18.0.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.start,
                          clipBehavior: Clip.hardEdge,
                          spacing: 8.0.sp,
                          children: historyControler.statuses
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
