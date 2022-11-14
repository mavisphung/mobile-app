// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/common/util/status.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/modules/notification/controllers/notification_controller.dart';
import 'package:hi_doctor_v2/app/modules/notification/widgets/notification_list_tile.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_appbar.dart';

// ignore: must_be_immutable
class NotificationPage extends StatelessWidget {
  final NotificationController _controller = Get.put(NotificationController());

  NotificationPage({super.key});

  List<Widget> mockData = [
    NotificationListTile(
      title: 'Appointment',
      description: 'Chúng ta không thuộc về nhau',
      date: '15/10/2022 12:30 pm',
    ),
    ListTile(
      isThreeLine: true,
      dense: true,
      leading: SvgPicture.asset(
        'assets/icons/chat_fill.svg',
        width: 48.sp,
        height: 48.sp,
      ),
      title: Text(
        'Lịch hẹn khám',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16.5.sp,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Who can say where the path would go? Philosophers guess but they just don\'t know. Maybe I have, I have the head in the clouds',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: 5.sp,
          ),
          Text(
            '15/10/2022 12:30 pm',
            style: TextStyle(
              fontSize: 12.5.sp,
            ),
          ),
        ],
      ),
      onTap: () {
        'Pressed list tile'.debugLog('NotificationPage');
      },
      trailing: Icon(Icons.more_vert),
    ),
    ListTile(
      leading: Icon(Icons.flight),
      title: Text('Flight'),
      trailing: Icon(Icons.more_vert),
    ),
    ListTile(
      leading: Icon(Icons.train),
      title: Text('Train'),
      trailing: Icon(Icons.more_vert),
    ),
    ListTile(
      leading: Icon(Icons.car_rental),
      title: Text('Car'),
      trailing: Icon(Icons.more_vert),
    ),
    ListTile(
      leading: Icon(Icons.flight),
      title: Text('Flight'),
      trailing: Icon(Icons.more_vert),
    ),
    ListTile(
      leading: Icon(Icons.train),
      title: Text('Train'),
      trailing: Icon(Icons.more_vert),
    ),
    ListTile(
      leading: Icon(Icons.car_rental),
      title: Text('Car'),
      trailing: Icon(Icons.more_vert),
    ),
    ListTile(
      leading: Icon(Icons.flight),
      title: Text('Flight'),
      trailing: Icon(Icons.more_vert),
    ),
    ListTile(
      leading: Icon(Icons.train),
      title: Text('Train'),
      trailing: Icon(Icons.more_vert),
    ),
    ListTile(
      leading: Icon(Icons.car_rental),
      title: Text('Car'),
      trailing: Icon(Icons.more_vert),
    ),
    ListTile(
      leading: Icon(Icons.flight),
      title: Text('Flight'),
      trailing: Icon(Icons.more_vert),
    ),
    ListTile(
      leading: Icon(Icons.train),
      title: Text('Train'),
      trailing: Icon(Icons.more_vert),
    ),
    ListTile(
      leading: Icon(Icons.car_rental),
      title: Text('Car'),
      trailing: Icon(Icons.more_vert),
    ),
    ListTile(
      leading: Icon(Icons.car_rental),
      title: Text('Car'),
      trailing: Icon(Icons.more_vert),
    ),
    ListTile(
      leading: Icon(Icons.car_rental),
      title: Text('Car'),
      trailing: Icon(Icons.more_vert),
    ),
    ListTile(
      leading: Icon(Icons.car_rental),
      title: Text('Car'),
      trailing: Icon(Icons.more_vert),
    ),
    ListTile(
      leading: Icon(Icons.car_rental),
      title: Text('Car'),
      trailing: Icon(Icons.more_vert),
    ),
    ListTile(
      leading: Icon(Icons.car_rental),
      title: Text('Car'),
      trailing: Icon(Icons.more_vert),
    ),
  ];

  Widget buildChild(Status status) {
    status.toString().debugLog('Status');
    switch (status) {
      case Status.success:
        return ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (_, index) {
            var model = _controller.notifications[index];
            return NotificationListTile(
              title: model.title,
              description: model.message,
              date: model.createdAt.substring(0, model.createdAt.length - 3),
            );
          },
          itemCount: _controller.notifications.length,
        );
      case Status.fail:
        return SingleChildScrollView(
          controller: _controller.scrollController,
          child: Container(
            alignment: Alignment.center,
            height: Get.height.sp / 100 * 80,
            child: const Text('Không có dữ liệu'),
          ),
        );
      case Status.loading:
        return Container(
          alignment: Alignment.center,
          height: Get.height.sp / 100 * 80,
          child: const Text('Đang tải dữ liệu'),
        );
      case Status.init:
      default:
        return SingleChildScrollView(
          controller: _controller.scrollController,
          child: Container(
            alignment: Alignment.center,
            height: Get.height.sp / 100 * 80,
            child: const CircularProgressIndicator(),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MyAppBar(
        title: 'Thông báo',
        hasBackBtn: false,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          'Fetching notifications'.debugLog('NotificationPage');
          _controller.fetchNotifications();
        },
        child: Obx(() => buildChild(_controller.status)),
        // child: buildChild(Status.success),
      ),
    );
  }
}
