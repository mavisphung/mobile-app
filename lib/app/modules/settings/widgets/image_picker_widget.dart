import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/util/utils.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';

class ImagePickerWidget extends StatelessWidget {
  final void Function(bool) getImageFucntion;
  const ImagePickerWidget({
    Key? key,
    required this.getImageFucntion,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        var isFromCamera = await Utils.showConfirmDialog(
          Strings.imageSourceMsg.tr,
          cancelText: Strings.gallery.tr,
          confirmText: Strings.camera.tr,
        );
        if (isFromCamera != null) {
          getImageFucntion(isFromCamera);
        }
      },
      child: Container(
        padding: EdgeInsets.all(5.sp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.sp),
          color: Colors.black87,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              offset: const Offset(0, 2),
              blurRadius: 4.sp,
            ),
          ],
        ),
        child: const Icon(
          Icons.camera_alt_outlined,
          color: Colors.white,
        ),
      ),
    );
  }
}
