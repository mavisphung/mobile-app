import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/util/transformation.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/modules/health_record/controllers/health_record_controller.dart';
import 'package:hi_doctor_v2/app/modules/health_record/views/pathology_search.dart';
import 'package:hi_doctor_v2/app/modules/health_record/views/record_view.dart';
import 'package:hi_doctor_v2/app/modules/health_record/views/record_dropdown.dart';
import 'package:hi_doctor_v2/app/modules/widgets/base_page.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_icon_button.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_textfield_widget.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_appbar.dart';

class AddHealthRecordPage extends StatelessWidget {
  final _cHealthRecord = Get.put(HealthRecordController());
  final _formKey = GlobalKey<FormState>();

  AddHealthRecordPage({super.key});

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

  void _addPathologyItem(String value) {
    if (value.trim().isEmpty) {
      _cHealthRecord.pathologyNameStatus.value = PathologyNameStatus.EMPTY;
      return;
    }
    _cHealthRecord.addPathology();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      backgroundColor: Colors.white,
      appBar: MyAppBar(
        title: 'Thêm hồ sơ sức khỏe',
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 5.sp),
            child: CustomIconButton(
              onPressed: () {},
              icon: Icon(
                PhosphorIcons.folder_notch_plus_light,
                color: AppColors.secondary,
                size: 24.sp,
              ),
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextFieldWidget(
              labelText: 'Tên hồ sơ',
              focusNode: _cHealthRecord.nameFocusNode,
              controller: _cHealthRecord.nameController,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ObxValue<Rx<PathologyNameStatus>>(
                    (data) => CustomTextFieldWidget(
                      labelText: 'Bệnh lý',
                      hintText: 'Tap to find pathology',
                      validator: null,
                      focusNode: _cHealthRecord.pathologyFocusNode,
                      controller: _cHealthRecord.pathologyController,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (value) => _addPathologyItem(value ?? ''),
                      errorText: data.value == PathologyNameStatus.INVALID
                          ? 'Invalid pathology'
                          : (data.value == PathologyNameStatus.EMPTY ? 'Please input pathology' : null),
                      onTap: () async {
                        _cHealthRecord.pathologyController.text = await showSearch(
                          context: context,
                          delegate: PathologySearchDelegate(),
                        );
                      },
                    ),
                    _cHealthRecord.pathologyNameStatus,
                  ),
                ),
                _box10,
                _getAddBtn(
                  margin: EdgeInsets.only(top: 2.sp),
                  onPressed: () => _addPathologyItem(_cHealthRecord.pathologyController.text),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(child: RecordDropDown()),
                _box10,
                _getAddBtn(
                  margin: EdgeInsets.only(bottom: 2.sp),
                  onPressed: _cHealthRecord.addTicket,
                ),
              ],
            ),
            _box10,
            ImagePreviewGrid(),
            _hBox20,
            _getTitle('Bệnh lý đã thêm'),
            ObxValue<RxInt>(
              (data) {
                if (data.value == 0) {
                  return const Text('Bạn chưa thêm phiếu sức khỏe nào');
                }
                return Container(
                  height: 150.sp,
                  padding: EdgeInsets.symmetric(horizontal: 14.sp),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Constants.textFieldRadius.sp),
                    border: Border.all(
                      width: 0.2.sp,
                      color: Colors.blueGrey.shade200,
                    ),
                  ),
                  child: ListView.builder(
                    physics: const ScrollPhysics(),
                    itemCount: data.value,
                    itemBuilder: (_, index) {
                      var e = _cHealthRecord.getPathologys[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.sp),
                        child: Row(
                          children: [
                            CustomIconButton(
                              size: 28.sp,
                              color: AppColors.grey300.withOpacity(0.7),
                              onPressed: () {},
                              icon: Icon(
                                CupertinoIcons.xmark,
                                size: 12.8.sp,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(width: 10.sp),
                            Flexible(
                              child: Text(
                                Tx.getPathologyString(e.code, e.name),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
              _cHealthRecord.pathologiesLength,
            ),
            _hBox20,
            _getTitle('Các phiếu đã thêm'),
            RecordsView(),
          ],
        ),
      ),
    );
  }
}
