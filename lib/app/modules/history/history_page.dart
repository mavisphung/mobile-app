import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/common/util/utils.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/models/appointment.dart';
import 'package:hi_doctor_v2/app/modules/history/controllers/history_controller.dart';
import 'package:hi_doctor_v2/app/modules/history/controllers/tab_controller.dart';
import 'package:hi_doctor_v2/app/modules/history/views/appointment_filter_page.dart';
import 'package:hi_doctor_v2/app/modules/history/views/incoming_tab.dart';
import 'package:hi_doctor_v2/app/modules/history/widgets/appointment_tile.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final HistoryController _controller = Get.put(HistoryController());
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
      builder: (HistoryController controller) {
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
