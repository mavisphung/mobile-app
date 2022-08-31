import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/util/utils.dart';
import '../../common/values/colors.dart';
import './controllers/tab_controller.dart';
import './views/incoming_tab.dart';
import './controllers/appointment_controller.dart';

class AppoinmentPage extends StatefulWidget {
  const AppoinmentPage({Key? key}) : super(key: key);

  @override
  State<AppoinmentPage> createState() => _AppoinmentPageState();
}

class _AppoinmentPageState extends State<AppoinmentPage> {
  final AppoinmentController _controller = Get.put(AppoinmentController());
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
      builder: (AppoinmentController controller) {
        return Scaffold(
          body: DefaultTabController(
            length: 2,
            child: Scaffold(
              body: NestedScrollView(
                headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      title: const Text(
                        "Appointments",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      floating: true,
                      pinned: true,
                      snap: true,
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
                  ];
                },
                body: TabBarView(
                  controller: tabx.controller,
                  children: [
                    IncomingTab(date: Utils.formatDateTime(DateTime.now()).split(' ')[0]),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
                      child: Column(
                        children: [
                          Container(
                            width: 1.sw,
                            margin: EdgeInsets.symmetric(vertical: 10.0.sp),
                            padding: EdgeInsets.symmetric(vertical: 10.0.sp),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(12.0.sp),
                            ),
                            child: Wrap(
                              children: [
                                Container(
                                  width: 53.0.sp,
                                  height: 53.0.sp,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        'https://cuu-be.s3.amazonaws.com/cuu-be/2022/6/28/O2VWFV.png',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
