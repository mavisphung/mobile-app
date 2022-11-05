import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/models/pathology.dart';
import 'package:hi_doctor_v2/app/modules/health_record/controllers/edit_health_record_controller.dart';
import 'package:hi_doctor_v2/app/modules/health_record/views/record_view.dart';
import 'package:hi_doctor_v2/app/modules/health_record/widgets/record_dropdown.dart';
import 'package:hi_doctor_v2/app/modules/widgets/base_page.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_text_btn.dart';
import 'package:hi_doctor_v2/app/modules/widgets/info_container.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_appbar.dart';

// ignore: must_be_immutable
class EditPathologyRecordPage extends StatelessWidget {
  final _c = Get.put(EditOtherHealthRecordController(), tag: 'SUB');
  final _cEditOtherHealthRecord = Get.find<EditOtherHealthRecordController>(tag: 'MAIN');
  final _p = Get.arguments as Pathology;
  late String funcLabel;
  late void Function(Pathology) func;

  final _box10 = SizedBox(width: 10.sp, height: 10.sp);
  final _hBox30 = SizedBox(height: 30.sp);

  EditPathologyRecordPage({Key? key}) : super(key: key) {
    _c.pathologyObj.value = _p;
    _c.recordsLength.value = _c.pathologyObj.value!.records.length;
    final parameters = Get.parameters;
    if (parameters['tag'] != null) {
      funcLabel = parameters['tag']!;
    }
    func = funcLabel == 'Save' ? _cEditOtherHealthRecord.savePathology : _cEditOtherHealthRecord.addPathology;
  }

  Widget _getLabel(String text) {
    return SizedBox(
      height: 25.sp,
      width: 100.sp,
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _getTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(
        left: 18.sp,
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

  @override
  Widget build(BuildContext context) {
    return BasePage(
      backgroundColor: Colors.white,
      appBar: MyAppBar(
        title: 'Thêm bệnh lý',
        actions: [
          Padding(
            padding: EdgeInsets.only(
              top: 16.sp,
              right: 14.sp,
            ),
            child: CustomTextButton(
              btnText: funcLabel,
              action: () => func(_p),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _getTitle('Thông tin bệnh lý'),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 20.sp,
              horizontal: 18.sp,
            ),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(15.sp),
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _getLabel('Mã bệnh'),
                    Text('${_p.code}'),
                  ],
                ),
                Row(
                  children: [
                    _getLabel('Mã bệnh khác'),
                    Text('${_p.otherCode}'),
                  ],
                ),
                Row(
                  children: [
                    _getLabel('Tên chung'),
                    Flexible(
                      child: Text('${_p.generalName}'),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _getLabel('Tên bệnh'),
                    Flexible(
                      child: Text('${_p.diseaseName}'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          _box10,
          const InfoContainer(
            info: 'Những phiếu sức khỏe được thêm liên quan với bệnh lý sẽ được gợi ý khi bạn ký hợp đồng với bác sĩ.',
            hasInfoIcon: true,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(child: RecordDropDown(tag: 'SUB')),
              _box10,
              _getAddBtn(
                margin: EdgeInsets.only(bottom: 2.sp),
                onPressed: _c.addTicket,
              ),
            ],
          ),
          _box10,
          ImagePreviewGrid(tag: 'SUB'),
          _hBox30,
          _getTitle('Các phiếu sức khỏe liên quan đến bệnh lý'),
          RecordsView(tag: 'SUB'),
        ],
      ),
    );
  }
}
