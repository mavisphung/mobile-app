import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/modules/history/controllers/history_controller.dart';

class HistoryPage extends StatelessWidget {
  HistoryPage({Key? key}) : super(key: key);
  final HistoryController _controller = Get.put(HistoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Text('History page'),
    );
  }
}
