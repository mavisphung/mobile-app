// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/util/transformation.dart';
import 'package:hi_doctor_v2/app/common/util/utils.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:hi_doctor_v2/app/modules/health_record/controllers/health_record_controller.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_container.dart';

class PathologicalView extends StatelessWidget {
  final _cHealthRecord = Get.find<HealthRecordController>();
  final _isExpanded = false.obs;

  PathologicalView({super.key});

  @override
  Widget build(BuildContext context) {
    return ObxValue<RxInt>(
      (data) => ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (_, index) {
          final p = _cHealthRecord.getPathologicals[index];
          return Padding(
            padding: EdgeInsets.only(top: 8.sp),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(2.sp),
                      decoration: BoxDecoration(
                        // color: Colors.white,
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10.sp),
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: AppColors.primary.withOpacity(0.2),
                        //     offset: const Offset(2, 2),
                        //     blurRadius: 8.sp,
                        //   ),
                        // ],
                      ),
                      child: IconButton(
                        onPressed: () => _isExpanded.value = !_isExpanded.value,
                        icon: const Icon(
                          // PhosphorIcons.trash_fill,
                          Icons.delete_outline_rounded,
                        ),
                        color: Colors.red.shade400,
                      ),
                    ),
                    SizedBox(width: 10.sp),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(16.sp),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10.sp),
                          // boxShadow: [
                          //   BoxShadow(
                          //     // color: AppColors.primary.withOpacity(0.2),
                          //     color: Colors.grey.withOpacity(0.2),
                          //     offset: const Offset(1, 3),
                          //     blurRadius: 4.sp,
                          //   ),
                          // ],
                        ),
                        child: Text(
                          Tx.getPathologicalString(p.code, p.name),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.sp),
                    Container(
                      padding: EdgeInsets.all(2.sp),
                      decoration: BoxDecoration(
                        // color: Colors.white,
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10.sp),
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: AppColors.primary.withOpacity(0.2),
                        //     offset: const Offset(2, 2),
                        //     blurRadius: 8.sp,
                        //   ),
                        // ],
                      ),
                      child: IconButton(
                        onPressed: () => _isExpanded.value = !_isExpanded.value,
                        icon: Icon(
                          Icons.arrow_drop_down_rounded,
                          size: 30.sp,
                        ),
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
                if (p.records != null)
                  ObxValue<RxBool>(
                    (data) => data.value ? ImagePreviewGrid() : const SizedBox.shrink(),
                    _isExpanded,
                  ),
              ],
            ),
          );
        },
        itemCount: data.value,
      ),
      _cHealthRecord.pathologicalsLength,
    );
  }
}

class ImagePreviewGrid extends StatelessWidget {
  final _cHealthRecord = Get.find<HealthRecordController>();

  ImagePreviewGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      height: 200.sp,
      child: ObxValue<RxInt>(
        (data) => GridView.builder(
          padding: EdgeInsets.only(bottom: 5.sp),
          physics: const BouncingScrollPhysics(),
          // shrinkWrap: true,
          itemCount: data.value + 1,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10.sp,
            mainAxisSpacing: 20.sp,
            childAspectRatio: 0.9,
          ),
          itemBuilder: (_, int index) {
            if (index == 0) {
              return GestureDetector(
                onTap: () async {
                  var isFromCamera = await Utils.showConfirmDialog(
                    Strings.imageSourceMsg.tr,
                    cancelText: Strings.gallery.tr,
                    confirmText: Strings.camera.tr,
                  );
                  if (isFromCamera != null) {
                    _cHealthRecord.addRecordImage(isFromCamera);
                  }
                },
                child: Container(
                  width: 50.sp,
                  height: 50.sp,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.shade300,
                    ),
                    borderRadius: BorderRadius.circular(5.sp),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.add_a_photo_rounded),
                      Text(
                        'Add new image',
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            }
            String? e = _cHealthRecord.getRecordImgs[index - 1];
            return Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  width: 50.sp,
                  height: 100.sp,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.sp),
                    image: DecorationImage(
                      image: FileImage(File(e)),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: ClipOval(
                    child: Material(
                      color: Colors.grey.shade300.withOpacity(0.8),
                      child: IconButton(
                        onPressed: () => print('ERASE'),
                        icon: const Icon(
                          CupertinoIcons.xmark,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),
        _cHealthRecord.recordImgsLength,
      ),
    );
  }
}
