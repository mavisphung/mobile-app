import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/modules/appointment/controllers/appointment_controller.dart';
import 'package:hi_doctor_v2/app/modules/appointment/controllers/tab_controller.dart';
import 'package:hi_doctor_v2/app/modules/appointment/views/history_tab.dart';
import 'package:hi_doctor_v2/app/modules/appointment/views/incoming_tab.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_appbar.dart';

class AppoinmentPage extends StatefulWidget {
  const AppoinmentPage({Key? key}) : super(key: key);

  @override
  State<AppoinmentPage> createState() => _AppoinmentPageState();
}

class _AppoinmentPageState extends State<AppoinmentPage> with SingleTickerProviderStateMixin {
  final AppointmentController _controller = Get.put(AppointmentController());
  late final MyTabController tabx;
  var tabs = <Tab>[];

  @override
  void initState() {
    super.initState();

    tabs = <Tab>[
      Tab(
        height: 29.sp,
        text: 'Đang chờ',
      ),
      Tab(
        height: 29.sp,
        text: 'Lịch sử',
      ),
    ];
    tabx = Get.put(MyTabController(length: tabs.length, tabs: tabs));
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: _controller,
      builder: (AppointmentController controller) {
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: const MyAppBar(
            title: 'Lịch hẹn',
            hasBackBtn: false,
          ),
          body: Column(
            children: [
              SizedBox(
                width: 180.sp,
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                      width: 3.sp,
                      color: AppColors.primary,
                    ),
                  ),
                  labelColor: Colors.black87,
                  unselectedLabelColor: Colors.black87,
                  labelStyle: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  controller: tabx.controller,
                  tabs: tabx.tabs,
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: tabx.controller,
                  children: [
                    IncomingTab(),
                    HistoryTab(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
