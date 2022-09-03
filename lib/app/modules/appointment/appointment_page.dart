import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/modules/appointment/controllers/appointment_controller.dart';
import 'package:hi_doctor_v2/app/modules/appointment/views/history_tab.dart';
import 'package:hi_doctor_v2/app/modules/appointment/views/incoming_tab.dart';
import 'package:hi_doctor_v2/app/modules/appointment/views/incoming_tab2.dart';

import '../../common/values/colors.dart';
import './controllers/tab_controller.dart';

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
        child: Wrap(
          spacing: 12.0.sp,
          children: [
            const Icon(
              Icons.calendar_today,
            ),
            Text(
              'Incoming',
              style: TextStyle(fontSize: 16.0.sp),
            ),
          ],
        ),
      ),
      Tab(
        child: Wrap(
          spacing: 12.0.sp,
          children: [
            const Icon(
              Icons.check_circle,
            ),
            Text(
              'History',
              style: TextStyle(fontSize: 16.0.sp),
            ),
          ],
        ),
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
          body: DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                title: const Text(
                  "Appointments",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                bottom: TabBar(
                  indicatorColor: AppColors.primary,
                  labelColor: AppColors.primary,
                  unselectedLabelColor: Colors.grey,
                  controller: tabx.controller,
                  tabs: tabx.tabs,
                ),
                backgroundColor: Colors.white,
                elevation: 0.0.sp,
              ),
              body: TabBarView(
                controller: tabx.controller,
                children: [
                  IncomingTab(),
                  HistoryTab(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
