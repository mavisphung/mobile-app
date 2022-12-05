import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/common/util/enum.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/modules/notification/controllers/notification_controller.dart';
import 'package:hi_doctor_v2/app/modules/notification/widgets/notification_list_tile.dart';
import 'package:hi_doctor_v2/app/modules/widgets/loading_widget.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_appbar.dart';
import 'package:hi_doctor_v2/app/modules/widgets/response_status_widget.dart';

// ignore: must_be_immutable
class NotificationPage extends StatelessWidget {
  final NotificationController _controller = Get.put(NotificationController());

  NotificationPage({super.key});

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
          child: const NoDataWidget(message: 'Không có thông báo nào để hiển thị.'),
        );
      case Status.loading:
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          controller: _controller.scrollController,
          child: const LoadingWidget(),
        );
      case Status.init:
      default:
        return const LoadingWidget();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MyAppBar(
        title: 'Thông báo',
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          'Fetching notifications'.debugLog('NotificationPage');
          _controller.fetchNotifications();
        },
        child: Obx(() => buildChild(_controller.status)),
      ),
    );
  }
}
