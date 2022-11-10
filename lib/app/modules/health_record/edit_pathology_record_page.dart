import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/models/pathology.dart';
import 'package:hi_doctor_v2/app/modules/health_record/controllers/edit_pathology_controller.dart';
import 'package:hi_doctor_v2/app/modules/health_record/views/record_view.dart';
import 'package:hi_doctor_v2/app/modules/health_record/widgets/record_dropdown.dart';
import 'package:hi_doctor_v2/app/modules/widgets/base_page.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_text_btn.dart';
import 'package:hi_doctor_v2/app/modules/widgets/info_container.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_appbar.dart';

// ignore: must_be_immutable
class EditPathologyRecordPage extends StatelessWidget {
  final _cEditPathology = Get.put(EditPathologyController());

  final _p = Get.arguments as Pathology;

  final _box10 = SizedBox(width: 10.sp, height: 10.sp);
  final _hBox30 = SizedBox(height: 30.sp);

  EditPathologyRecordPage({super.key});

  late String _title;
  late String _funcLabel;
  late VoidCallback _func;

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

  void init() {
    final parameters = Get.parameters;
    final tag = parameters['tag'];
    if (tag != null) {
      if (tag == 'UPDATE') {
        _title = 'Cập nhật về bệnh lý';
        _funcLabel = 'Cập nhật';
        _func = _cEditPathology.updatePathology;
      } else {
        _title = 'Thêm bệnh lý';
        _funcLabel = 'Thêm';
        _func = _cEditPathology.addPathology;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    init();
    return BasePage(
      backgroundColor: Colors.white,
      appBar: MyAppBar(
        title: _title,
        actions: [
          Padding(
            padding: EdgeInsets.only(
              top: 10.sp,
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
              Expanded(child: RecordDropDown(c: _cEditPathology)),
              _box10,
              _getAddBtn(
                margin: EdgeInsets.only(bottom: 2.sp),
                onPressed: _cEditPathology.addTicket,
              ),
            ],
          ),
          _box10,
          ImagePreviewGrid(
            imgs: _cEditPathology.imgs,
            addImgFunc: _cEditPathology.addImage,
            removeImgFunc: _cEditPathology.removeImage,
          ),
          _hBox30,
          _getTitle('Các phiếu sức khỏe liên quan đến bệnh lý'),
          FutureBuilder(
            future: _cEditPathology.initialize(_p),
            builder: (_, AsyncSnapshot<bool> snapshot) {
              if (snapshot.hasData && snapshot.data == true) {
                return RecordsView(
                  rxRecords: _cEditPathology.rxRecords,
                  removeRecordFunc: _cEditPathology.removeRecord,
                  removeTicketFunc: _cEditPathology.removeTicket,
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
