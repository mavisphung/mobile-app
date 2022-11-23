import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/util/enum.dart' as mytag;
import 'package:hi_doctor_v2/app/common/util/dialogs.dart';
import 'package:hi_doctor_v2/app/common/util/enum.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/modules/health_record/controllers/edit_health_record_controller.dart';
import 'package:hi_doctor_v2/app/modules/health_record/models/hr_res_model.dart';
import 'package:hi_doctor_v2/app/modules/health_record/views/pathology_view.dart';
import 'package:hi_doctor_v2/app/modules/health_record/widgets/pathology_textfield.dart';
import 'package:hi_doctor_v2/app/modules/health_record/views/record_view.dart';
import 'package:hi_doctor_v2/app/modules/health_record/widgets/record_dropdown.dart';
import 'package:hi_doctor_v2/app/modules/widgets/base_page.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_text_btn.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_textfield_widget.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_appbar.dart';
import 'package:hi_doctor_v2/app/routes/app_pages.dart';

// ignore: must_be_immutable
class EditOtherHealthRecordPage extends StatelessWidget {
  final _cEditOtherHealthRecord = Get.put(EditOtherHealthRecordController());
  final _hr = Get.arguments as HrResModel?;

  final _box10 = SizedBox(width: 10.sp, height: 10.sp);
  final _hBox20 = SizedBox(height: 20.sp);

  EditOtherHealthRecordPage({super.key});

  Widget _getTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16.sp,
        bottom: 2.sp,
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 11.5.sp,
          color: Colors.grey[600],
        ),
      ),
    );
  }

  Widget _getAddBtn({required EdgeInsets margin, required VoidCallback onPressed}) {
    return Container(
      margin: margin,
      padding: EdgeInsets.all(2.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.sp),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.2),
            offset: const Offset(1, 1),
            blurRadius: 2.sp,
          ),
        ],
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: const Icon(
          CupertinoIcons.add,
        ),
        color: AppColors.primary,
      ),
    );
  }

  Future<bool?> _addEditHr() async {
    return _hr == null
        ? await _cEditOtherHealthRecord.addOtherHealthRecord()
        : await _cEditOtherHealthRecord.updateOtherHealthRecord();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      paddingTop: 20.sp,
      backgroundColor: Colors.white,
      appBar: MyAppBar(
        title: _hr == null ? 'Thêm hồ sơ sức khỏe' : 'Cập nhật hồ sơ sức khỏe',
        rxStatus: _cEditOtherHealthRecord.status,
        actions: [
          Padding(
            padding: EdgeInsets.only(
              top: 10.sp,
              right: 14.sp,
            ),
            child: ObxValue<Rx<Status>>(
              (data) {
                return CustomTextButton(
                  btnText: _hr == null ? 'Thêm' : 'Cập nhật',
                  action: () async {
                    final isSuccess = await _addEditHr();
                    if (isSuccess != null) {
                      Dialogs.statusDialog(
                        ctx: context,
                        isSuccess: isSuccess,
                        successMsg: 'Thêm hồ sơ ngoài hệ thống thành công.',
                        failMsg: 'Xảy ra lỗi khi thêm hồ sơ ngoài hệ thống',
                        successAction: () => Get.back(),
                      );
                    }
                  },
                  status: data.value,
                );
              },
              _cEditOtherHealthRecord.status,
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextFieldWidget(
            labelText: 'Tên hồ sơ',
            focusNode: _cEditOtherHealthRecord.nameFocusNode,
            controller: _cEditOtherHealthRecord.nameController,
          ),
          PathologyTextField(
            onChoose: (result) {
              final existedItem = _cEditOtherHealthRecord.rxPathologies.firstWhereOrNull((e) => e.id == result.id);
              if (existedItem == null) {
                Get.toNamed(Routes.EDIT_PATHOLOGY_RECORD,
                    arguments: result, parameters: {'tag': mytag.Action.create.name});
                return;
              }
              Get.toNamed(Routes.EDIT_PATHOLOGY_RECORD,
                  arguments: existedItem.copyWith(), parameters: {'tag': mytag.Action.update.name});
            },
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(child: RecordDropDown(c: _cEditOtherHealthRecord)),
              _box10,
              _getAddBtn(
                margin: EdgeInsets.only(bottom: 2.sp),
                onPressed: _cEditOtherHealthRecord.addTicket,
              ),
            ],
          ),
          _box10,
          ImagePreviewGrid(
            imgs: _cEditOtherHealthRecord.imgs,
            addImgFunc: _cEditOtherHealthRecord.addImage,
            removeImgFunc: _cEditOtherHealthRecord.removeImage,
          ),
          _hBox20,
          FutureBuilder(
            future: _cEditOtherHealthRecord.initialize(_hr),
            builder: (_, AsyncSnapshot<bool> snapshot) {
              if (snapshot.hasData && snapshot.data == true) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _getTitle('Bệnh lý đã thêm'),
                    PathologyView(),
                    _hBox20,
                    _getTitle('Các phiếu đã thêm'),
                    RecordsView(
                      rxRecords: _cEditOtherHealthRecord.rxRecords,
                      removeRecordFunc: _cEditOtherHealthRecord.removeRecord,
                      removeTicketFunc: _cEditOtherHealthRecord.removeTicket,
                    ),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
