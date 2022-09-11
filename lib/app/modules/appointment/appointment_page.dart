import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/modules/appointment/controllers/appointment_controller.dart';
import 'package:hi_doctor_v2/app/modules/appointment/views/history_tab.dart';
import 'package:hi_doctor_v2/app/modules/appointment/views/incoming_tab.dart';

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

    tabs = const <Tab>[
      Tab(
        child: Text(
          'Incoming',
        ),
      ),
      Tab(
        child: Text(
          'History',
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
                backgroundColor: Colors.white,
                elevation: 0.0.sp,
              ),
              body: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 12.0.sp),
                    padding: EdgeInsets.symmetric(vertical: 2.8.sp, horizontal: 3.8.sp),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE0E5FB),
                      borderRadius: BorderRadius.circular(12.8.sp),
                    ),
                    child: TabBar(
                      indicatorColor: Colors.white,
                      indicator: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.sp),
                      ),
                      labelColor: Colors.indigo,
                      unselectedLabelColor: Colors.white,
                      labelStyle: TextStyle(
                        fontSize: 14.sp,
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
            ),
          ),
        );
      },
    );
  }
}
