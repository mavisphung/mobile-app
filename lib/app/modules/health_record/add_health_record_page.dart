// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/util/dialogs.dart';

import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/models/other_health_record.dart';
import 'package:hi_doctor_v2/app/modules/health_record/controllers/edit_health_record_controller.dart';
import 'package:hi_doctor_v2/app/modules/health_record/views/pathology_view.dart';
import 'package:hi_doctor_v2/app/modules/health_record/widgets/pathology_textfield.dart';
import 'package:hi_doctor_v2/app/modules/health_record/views/record_view.dart';
import 'package:hi_doctor_v2/app/modules/health_record/widgets/record_dropdown.dart';
import 'package:hi_doctor_v2/app/modules/widgets/base_page.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_text_btn.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_textfield_widget.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_appbar.dart';

class AddOtherHealthRecordPage extends StatelessWidget {
  late final EditOtherHealthRecordController _cEditOtherHealthRecord =
      Get.put(EditOtherHealthRecordController(), tag: 'MAIN');
  late String _funcLabel;
  late VoidCallback _func;

  AddOtherHealthRecordPage({super.key});

  final _box10 = SizedBox(width: 10.sp, height: 10.sp);

  final _hBox20 = SizedBox(height: 20.sp);

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

  void init(BuildContext ctx) {
    final hr = Get.arguments as OtherHealthRecord?;
    final parameters = Get.parameters;
    final tag = parameters['tag'];

    _funcLabel = 'Add';
    _func = () async {
      final isSuccess = await _cEditOtherHealthRecord.addOtherHealthRecord();
      if (isSuccess != null) {
        Dialogs.statusDialog(
          ctx: ctx,
          isSuccess: isSuccess,
          successMsg: 'Thêm hồ sơ ngoài hệ thống thành công.',
          failMsg: 'Xảy ra lỗi khi thêm hồ sơ ngoài hệ thống',
          successAction: () => Get.back(),
        );
      }
    };

    if (tag != null && tag == 'EDIT' && hr != null) {
      _funcLabel = 'Update';
      _func = () => _cEditOtherHealthRecord.updateOtherHealthRecord();
      _cEditOtherHealthRecord.healthRecord = hr;
    }
  }

  @override
  Widget build(BuildContext context) {
    init(context);
    return BasePage(
      paddingTop: 20.sp,
      backgroundColor: Colors.white,
      appBar: MyAppBar(
        title: 'Thêm hồ sơ sức khỏe',
        actions: [
          Padding(
            padding: EdgeInsets.only(
              top: 16.sp,
              right: 14.sp,
            ),
            child: CustomTextButton(
              btnText: _funcLabel,
              action: _func,
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
          Row(
            children: const [
              PathologyTextField(),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(child: RecordDropDown()),
              _box10,
              _getAddBtn(
                margin: EdgeInsets.only(bottom: 2.sp),
                onPressed: _cEditOtherHealthRecord.addTicket,
              ),
            ],
          ),
          _box10,
          ImagePreviewGrid(),
          _hBox20,
          _getTitle('Bệnh lý đã thêm'),
          PathologyView(),
          _hBox20,
          _getTitle('Các phiếu đã thêm'),
          RecordsView(),
        ],
      ),
    );
  }
}
