import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/util/dialogs.dart';
import 'package:hi_doctor_v2/app/common/util/enum.dart';
import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/common/util/utils.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:hi_doctor_v2/app/modules/appointment/controllers/incoming_controller.dart';
import 'package:hi_doctor_v2/app/modules/appointment/widgets/cancel_dropdown.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_elevate_btn_widget.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_title_section.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_appbar.dart';
import 'package:hi_doctor_v2/app/routes/app_pages.dart';

class CancelPage extends StatelessWidget {
  final _ic = Get.find<IncomingController>();

  CancelPage({super.key});

  final List<String> reasons = CancelReason.reasons;

  @override
  Widget build(BuildContext context) {
    int appId = Get.arguments['appId'];
    return Scaffold(
      appBar: const MyAppBar(
        title: 'Xác nhận hủy',
        actions: [BackHomeWidget()],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0.sp),
          child: Column(
            children: [
              const CustomTitleSection(
                title: 'Lí do bạn hủy cuộc hẹn là:',
              ),
              CancelDropdown(
                rxReason: _ic.rxReason,
                reasonTemplates: reasons,
              ),
              TextFormField(
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return Strings.fieldCantBeEmpty;
                  }
                  if (value.length >= 1000) {
                    return Strings.problemLengthMsg;
                  }
                  return null;
                },
                focusNode: FocusNode(),
                controller: _ic.textController,
                decoration: InputDecoration(
                  hintText: 'Lời nhắn của bạn là...',
                  contentPadding: EdgeInsets.only(top: 16.sp, bottom: 16.sp, left: 18.sp, right: 18.sp),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(Constants.borderRadius.sp),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Constants.borderRadius.sp),
                  ),
                  filled: true,
                  fillColor: AppColors.grey200,
                ),
                keyboardType: TextInputType.multiline,
                maxLines: 7,
              ),
              Container(
                padding: EdgeInsets.only(top: 20.0.sp),
                child: CustomElevatedButtonWidget(
                  textChild: 'Xác nhận',
                  onPressed: () async {
                    if (_ic.loadingStatus.value == Status.loading) {
                      'Loading cancel page button'.debugLog('CancelPage');
                      return;
                    }
                    bool isOk = false;
                    if (_ic.validateCancelReason()) {
                      Utils.showAlertDialog('Vui lòng nhập lí do');
                      return;
                    }

                    String reason = '${_ic.rxReason.value}|${_ic.textController.text}';
                    isOk = await _ic.cancelAppointment(appId, reason);
                    Dialogs.statusDialog(
                      ctx: context,
                      isSuccess: isOk,
                      successMsg: 'Hủy lịch thành công',
                      failMsg: 'Xảy ra lỗi phát sinh khi hủy lịch',
                      successAction: () => Get.offAllNamed(Routes.NAVBAR),
                    );
                    _ic.complete();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
