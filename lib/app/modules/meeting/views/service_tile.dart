import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/modules/appointment/widgets/package_item.dart';
import 'package:hi_doctor_v2/app/modules/message/chat_page.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_card.dart';
import 'package:hi_doctor_v2/app/routes/app_pages.dart';

class ServiceTile extends StatelessWidget {
  final ChatPageArguments chatPageargs;
  final String category;
  final Function onJoin;

  const ServiceTile({super.key, required this.category, required this.chatPageargs, required this.onJoin});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Get.toNamed(
              Routes.CHAT,
              arguments: chatPageargs,
            );
          },
          child: CustomCard(
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(9.sp),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey[100]?.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(20.sp),
                  ),
                  child: Icon(
                    PhosphorIcons.messenger_logo,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: 15),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Nhắn tin',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Bạn có thể nhắn tin bằng văn bản, gửi ảnh với bác sĩ.',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        if (category == CategoryType.ONLINE.name)
          GestureDetector(
            onTap: () => onJoin(),
            child: CustomCard(
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(9.sp),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.grey[100]?.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(20.sp),
                    ),
                    child: Icon(
                      PhosphorIcons.phone,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Gọi video',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Bạn có thể gọi video trực tuyến với bác sĩ.',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
