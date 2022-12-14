import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/util/enum.dart' as mytag;
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/models/pathology.dart';
import 'package:hi_doctor_v2/app/modules/health_record/controllers/edit_pathology_controller.dart';
import 'package:hi_doctor_v2/app/modules/health_record/views/record_view.dart';
import 'package:hi_doctor_v2/app/modules/health_record/widgets/record_dropdown.dart';
import 'package:hi_doctor_v2/app/modules/widgets/base_page.dart';
import 'package:hi_doctor_v2/app/modules/widgets/content_container.dart';
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
      if (tag == mytag.Action.update.name) {
        _title = 'C???p nh???t v??? b???nh l??';
        _funcLabel = 'C???p nh???t';
        _func = _cEditPathology.updatePathology;
      } else {
        _title = 'Th??m b???nh l??';
        _funcLabel = 'Th??m';
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
          const ContentTitle1(
            title: 'Th??ng tin b???nh l??',
            leftPadding: 18,
            bottomPadding: 2,
          ),
          ContentContainer(
            labelWidth: 100,
            content: {
              'M?? b???nh': _p.code ?? '',
              'M?? b???nh kh??c': _p.otherCode ?? '',
              'T??n chung': _p.generalName ?? '',
              'T??n b???nh': _p.diseaseName ?? '',
            },
          ),
          _box10,
          const InfoContainer(
            info: 'Nh???ng phi???u s???c kh???e ???????c th??m li??n quan v???i b???nh l?? s??? ???????c g???i ?? khi b???n k?? h???p ?????ng v???i b??c s??.',
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
          const ContentTitle1(
            title: 'C??c phi???u s???c kh???e li??n quan ?????n b???nh l??',
            leftPadding: 18,
            bottomPadding: 2,
          ),
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
