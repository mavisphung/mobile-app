import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hi_doctor_v2/app/common/util/extensions.dart';

// ignore: must_be_immutable
class NotificationListTile extends StatelessWidget {
  Widget? leading;
  String title;
  String? description;
  String date;

  NotificationListTile({
    Key? key,
    this.leading,
    required this.title,
    this.description,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      isThreeLine: true,
      dense: true,
      leading: leading ??
          SvgPicture.asset(
            'assets/icons/done1.svg',
            width: 48.sp,
            height: 48.sp,
          ),
      title: Text(
        overflow: TextOverflow.fade,
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16.5.sp,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (description != null)
            Text(
              description!,
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          SizedBox(
            height: 5.sp,
          ),
          Text(
            date,
            style: TextStyle(
              fontSize: 12.5.sp,
            ),
          ),
        ],
      ),
      onTap: () {
        'Pressed list tile'.debugLog('NotificationPage');
      },
    );
  }
}
