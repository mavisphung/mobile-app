import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/models/contract.dart';
import 'package:hi_doctor_v2/app/modules/contract/controllers/contract_controller.dart';
import 'package:hi_doctor_v2/app/common/util/transformation.dart';
import 'package:hi_doctor_v2/app/modules/settings/widgets/setting_item.dart';
import 'package:hi_doctor_v2/app/modules/treatment/controllers/treatment_controller.dart';
import 'package:hi_doctor_v2/app/modules/widgets/base_page.dart';
import 'package:hi_doctor_v2/app/modules/widgets/content_container.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_container.dart';
import 'package:hi_doctor_v2/app/modules/widgets/loading_widget.dart';
import 'package:hi_doctor_v2/app/modules/widgets/response_status_widget.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_appbar.dart';
import 'package:hi_doctor_v2/app/routes/app_pages.dart';

class ContractDetailPage extends StatelessWidget {
  final _cContract = Get.put(ContractController());
  final _contractId = Get.arguments as int;
  final TreatmentController _cTreatment = Get.put(TreatmentController());

  ContractDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      appBar: MyAppBar(
        title: 'Chi tiết hợp đồng',
        actions: [
          PopupMenuButton<int>(
            padding: EdgeInsets.zero,
            onSelected: (value) {},
            itemBuilder: (context) => <PopupMenuEntry<int>>[
              const PopupMenuItem<int>(
                value: 1,
                child: Text('Hủy hợp đồng'),
              ),
              const PopupMenuItem<int>(
                value: 2,
                child: Text('Báo cáo hợp đồng'),
              ),
            ],
          ),
        ],
      ),
      body: FutureBuilder(
        future: _cContract.getContractWithId(_contractId),
        builder: (_, AsyncSnapshot<bool?> snapshot) {
          if (snapshot.hasData && snapshot.data == true) {
            final doctor = _cContract.contract.doctor;
            final patient = _cContract.contract.patient;
            final service = _cContract.contract.service;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Hợp đồng',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22.sp),
                  ),
                ),
                const SizedBox(height: 20),
                ContentRow(
                  verPadding: 0,
                  hozPadding: 0,
                  content: {
                    'Bác sĩ:': Tx.getFullName(doctor?['lastName'], doctor?['firstName']),
                    'Bệnh nhân:': Tx.getFullName(patient?['lastName'], patient?['firstName']),
                  },
                  labelWidth: 90,
                  labelStyle: const TextStyle(),
                  valueStyle: const TextStyle(fontWeight: FontWeight.w500),
                  maxLines: 1,
                ),
                Row(
                  children: [
                    const Text('Trạng thái'),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 8.sp),
                      width: 5.sp,
                      child: Divider(
                        color: Colors.grey[350],
                        thickness: 1.2.sp,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 7.sp),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: contractStatusColors[CONTRACT_STATUS.PENDING]!,
                            width: 1.5.sp,
                          ),
                          borderRadius: BorderRadius.circular(5.sp),
                        ),
                        child: Text(
                          _cContract.contract.status.toString().contractStatus.label,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: contractStatusColors[CONTRACT_STATUS.PENDING]!,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.sp),
                ContentRow(
                  labelWidth: 170,
                  verPadding: 0,
                  hozPadding: 0,
                  content: {
                    'Ngày bắt đầu hợp đồng:': Tx.getParsedDateString(_cContract.contract.startedTime),
                    'Ngày kết thúc hợp đồng:': _cContract.contract.endedAt == null
                        ? 'Đang chờ cập nhật'
                        : Tx.getParsedDateString(_cContract.contract.endedAt),
                  },
                  labelStyle: const TextStyle(),
                  valueStyle: const TextStyle(fontWeight: FontWeight.w500),
                ),
                const ContentTitle1(title: 'Thông tin gói hợp đồng', leftPadding: 0),
                ContentRow(
                  labelWidth: 100,
                  hozPadding: 0,
                  content: {
                    'Tên dịch vụ': service?['name'],
                    // 'Mô tả': service?['description'],
                    'Giá dịch vụ': 'Đang chờ cập nhật',
                  },
                  labelStyle: const TextStyle(),
                  valueStyle: const TextStyle(fontWeight: FontWeight.w500),
                ),
                CustomContainer(
                  child: Column(
                    children: [
                      SettingItem1(
                        title: 'Bản hợp đồng chính thức',
                        icon: Icon(PhosphorIcons.file_text_thin, color: AppColors.primary),
                        function: () {},
                      ),
                      SettingItem1(
                        title: 'Lịch hẹn',
                        icon: Icon(PhosphorIcons.calendar_thin, color: AppColors.primary),
                        function: () => Get.toNamed(Routes.CONTRACT_SCHEDULE),
                      ),
                      SettingItem1(
                        title: 'Hồ sơ sức khỏe',
                        icon: Icon(PhosphorIcons.folders_thin, color: AppColors.primary),
                        function: () => Get.toNamed(Routes.CONTRACT_RECORDS),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else if (snapshot.hasData && snapshot.data == false) {
            return const SystemErrorWidget();
          } else if (snapshot.connectionState == ConnectionState.none) {
            return const NoInternetWidget2();
          }
          return const LoadingWidget(topPadding: 200);
        },
      ),
    );
  }
}
