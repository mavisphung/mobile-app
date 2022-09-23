import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/util/status.dart';

class MessageController extends GetxController {
  ScrollController scrollController = ScrollController();
  Rx<Status> _rxLoadingStatus = Status.init.obs;
  int itemCount = 20;

  Status get loadingStatus => _rxLoadingStatus.value;
  set loadingStatus(Status status) {
    _rxLoadingStatus.value = status;
    update();
  }
}
