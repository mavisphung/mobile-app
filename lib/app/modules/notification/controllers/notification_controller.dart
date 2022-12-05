import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/util/enum.dart';
import 'package:hi_doctor_v2/app/data/api_response.dart';
import 'package:hi_doctor_v2/app/data/response_model.dart';
import 'package:hi_doctor_v2/app/modules/notification/models/notification.dart';
import 'package:hi_doctor_v2/app/modules/notification/providers/api_notification.dart';

class NotificationController extends GetxController {
  late final ApiNotificationImpl apiNotification;
  late final ScrollController scrollController;
  final Rx<Status> _rxStatus = Status.init.obs;
  RxList<NotificationModel> notifications = <NotificationModel>[].obs;
  RxInt currentPage = 1.obs;

  Status get status => _rxStatus.value;

  void setStatus(Status status) {
    _rxStatus.value = status;
    update();
  }

  Future<void> fetchNotifications({int page = 1, int limit = 10}) async {
    notifications.clear();
    setStatus(Status.loading);
    final result = await apiNotification.getUserNotifications(page: page, limit: limit);
    final Map<String, dynamic> response = ApiResponse.getResponse(result);
    final ResponseModel2 model = ResponseModel2.fromMap(response);
    // Check if fetch full of the list
    if (notifications.length >= model.totalItems!) {
      setStatus(Status.success);
      return;
    }
    // check is the last page or not
    if (model.nextPage != null) {
      currentPage.value = model.nextPage!;
    }
    // model.toJson().debugLog('NotificationController');
    var data = model.data as List<dynamic>;
    notifications += data.map((e) => NotificationModel.fromMap(e)).toList();
    setStatus(Status.success);
  }

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
    apiNotification = Get.put(ApiNotificationImpl());
    fetchNotifications();
  }

  @override
  void dispose() {
    scrollController.dispose();
    _rxStatus.close();
    notifications.close();
    currentPage.close();
    super.dispose();
  }
}
