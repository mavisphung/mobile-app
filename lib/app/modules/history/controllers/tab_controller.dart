import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyTabController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController controller;
  int length;
  List<Tab> tabs;
  MyTabController({required this.length, required this.tabs});

  @override
  void onInit() {
    super.onInit();
    controller = TabController(vsync: this, length: length);
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}
