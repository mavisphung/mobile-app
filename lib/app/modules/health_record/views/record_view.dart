// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/util/utils.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:hi_doctor_v2/app/models/record.dart';
import 'package:hi_doctor_v2/app/modules/health_record/widgets/record_item.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_icon_button.dart';

class RecordsView extends StatelessWidget {
  final RxList<Record> rxRecords;
  final void Function(int, String) removeRecordFunc;
  final void Function(int, int) removeTicketFunc;

  const RecordsView({super.key, required this.rxRecords, required this.removeRecordFunc, required this.removeTicketFunc});

  @override
  Widget build(BuildContext context) {
    return ObxValue<RxList<Record>>(
      (data) {
        if (data.isEmpty) {
          return const Align(
            heightFactor: 3,
            alignment: Alignment.center,
            child: Text('Bạn chưa thêm phiếu sức khỏe nào'),
          );
        }
        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (_, index) {
            return RecordItem(
              record: data[index],
              removeRecordFunc: removeRecordFunc,
              removeTicketFunc: removeTicketFunc,
            );
          },
          itemCount: data.length,
          separatorBuilder: (_, __) => SizedBox(
            height: 5.sp,
          ),
        );
      },
      rxRecords,
    );
  }
}

class ImagePreviewGrid extends StatelessWidget {
  final RxList<XFile> imgs;
  final void Function(bool) addImgFunc;
  final void Function(int) removeImgFunc;

  const ImagePreviewGrid({super.key, required this.imgs, required this.addImgFunc, required this.removeImgFunc});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.sp,
      padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 15.sp),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(Constants.textFieldRadius.sp),
      ),
      child: ObxValue<RxList<XFile>>(
        (data) => GridView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: data.length + 1,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 10.sp,
            mainAxisSpacing: 20.sp,
            childAspectRatio: 0.9,
          ),
          itemBuilder: (_, int index) {
            if (index == 0) {
              return GestureDetector(
                onTap: () async {
                  var isFromCamera = await Utils.showConfirmDialog(
                    Strings.imageSourceMsg,
                    cancelText: Strings.gallery,
                    confirmText: Strings.camera,
                  );
                  if (isFromCamera != null) {
                    addImgFunc(isFromCamera);
                  }
                },
                child: Container(
                  width: 50.sp,
                  height: 50.sp,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.grey300,
                    ),
                    borderRadius: BorderRadius.circular(5.sp),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.add_a_photo_rounded),
                      SizedBox(height: 5.sp),
                      Text(
                        'Thêm ảnh',
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 11.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            String e = data[index - 1].path;
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
                  child: CustomIconButton(
                    size: 28.sp,
                    color: AppColors.grey300.withOpacity(0.7),
                    onPressed: () => removeImgFunc(index - 1),
                    icon: Icon(
                      CupertinoIcons.xmark,
                      size: 12.8.sp,
                      color: Colors.black87,
                    ),
                  ),
                )
              ],
            );
          },
        ),
        imgs,
      ),
    );
  }
}
