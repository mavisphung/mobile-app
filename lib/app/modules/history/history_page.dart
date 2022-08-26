import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/colors.dart';
import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/util/utils.dart';
import 'package:hi_doctor_v2/app/models/appointment.dart';
import 'package:hi_doctor_v2/app/modules/history/controllers/history_controller.dart';
import 'package:hi_doctor_v2/app/modules/history/controllers/tab_controller.dart';
import 'package:hi_doctor_v2/app/modules/history/views/appointment_filter_page.dart';
import 'package:hi_doctor_v2/app/modules/history/widgets/appointment_tile.dart';

class HistoryPage extends StatefulWidget {
  HistoryPage({Key? key}) : super(key: key);

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
                        indicatorColor: AppColor.primary,
                        labelColor: AppColor.primary,
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
                  children: tabx.tabs.map(
                    (e) {
                      switch (tabs.indexOf(e)) {
                        case 0:
                          String datetime = Utils.formatDateTime(DateTime.now());
                          String date = datetime.split(' ')[0];
                          String time = datetime.split(' ')[1];
                          return SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 18.0.sp,
                                  ),
                                  Row(
                                    children: [
                                      const Spacer(),
                                      GestureDetector(
                                        onTap: () {
                                          print('Open filter page');
                                          Get.to(() => AppointmentFilterPage(), fullscreenDialog: true);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 8.0.sp,
                                            vertical: 5.0.sp,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(5.0.sp),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(0.12),
                                                offset: const Offset(0, 4),
                                                blurRadius: 4.0.sp,
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: Row(
                                              // direction: Axis.horizontal,
                                              children: [
                                                Text(
                                                  'Filter',
                                                  style: TextStyle(
                                                    fontSize: 16.0.sp,
                                                  ),
                                                ),
                                                SvgPicture.asset(
                                                  'assets/images/ic_filter_black.svg',
                                                  width: 24.0.sp,
                                                  height: 24.0.sp,
                                                  fit: BoxFit.fill,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  // DropdownButtonFormField2(
                                  //   buttonWidth: 12.0.sp,
                                  //   buttonHeight: 60.0.sp,
                                  //   decoration: InputDecoration(
                                  //     // labelText: 'Gender',
                                  //     // floatingLabelAlignment: FloatingLabelAlignment.center,
                                  //     //Add isDense true and zero Padding.
                                  //     //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                  //     isDense: true,
                                  //     contentPadding: EdgeInsets.zero,
                                  //     border: OutlineInputBorder(
                                  //       borderRadius: BorderRadius.circular(2),
                                  //     ),
                                  //     //Add more decoration as you want here
                                  //     //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                                  //   ),
                                  //   isExpanded: true,
                                  //   hint: const Text(
                                  //     'Type',
                                  //     style: TextStyle(fontSize: 14),
                                  //   ),
                                  //   value: controller.types[0],
                                  //   icon: const Icon(
                                  //     Icons.arrow_drop_down,
                                  //     color: Colors.black45,
                                  //   ),
                                  //   // value: genderList.firstWhere((item) => item == controller.profile.gender),
                                  //   iconSize: 30,
                                  //   buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                                  //   dropdownDecoration: BoxDecoration(
                                  //     borderRadius: BorderRadius.circular(2),
                                  //   ),
                                  //   items: controller.types
                                  //       .map(
                                  //         (e) => DropdownMenuItem(
                                  //           value: e,
                                  //           child: Text(e.toLowerCase().capitalize!),
                                  //         ),
                                  //       )
                                  //       .toList(),
                                  //   validator: (value) {
                                  //     if (value == null) {
                                  //       return 'Please select gender.';
                                  //     }
                                  //     return null;
                                  //   },
                                  //   onChanged: (String? value) {
                                  //     //Do something when changing the item if you want.
                                  //     print('$value');
                                  //   },
                                  //   onSaved: (value) {},
                                  // ),
                                  AppointmentTile(
                                    data: Appointment2(
                                      bookedAt: date,
                                      doctor: 5,
                                      checkInCode: '123456-5-6-3',
                                      status: 'PENDING'.toLowerCase().capitalize,
                                      type: 'ONLINE'.toLowerCase().capitalize,
                                    ),
                                  ),
                                  AppointmentTile(
                                    data: Appointment2(
                                      bookedAt: date,
                                      doctor: 5,
                                      checkInCode: '123456-5-6-3',
                                      status: 'PENDING'.toLowerCase().capitalize,
                                      type: 'ONLINE'.toLowerCase().capitalize,
                                    ),
                                  ),
                                  AppointmentTile(
                                    data: Appointment2(
                                      bookedAt: date,
                                      doctor: 5,
                                      checkInCode: '123456-5-6-3',
                                      status: 'PENDING'.toLowerCase().capitalize,
                                      type: 'OFFLINE'.toLowerCase().capitalize,
                                    ),
                                  ),
                                  AppointmentTile(
                                    data: Appointment2(
                                      bookedAt: date,
                                      doctor: 5,
                                      checkInCode: '123456-5-6-3',
                                      status: 'PENDING'.toLowerCase().capitalize,
                                      type: 'ONLINE'.toLowerCase().capitalize,
                                    ),
                                  ),
                                  AppointmentTile(
                                    data: Appointment2(
                                      bookedAt: date,
                                      doctor: 5,
                                      checkInCode: '123456-5-6-3',
                                      status: 'PENDING'.toLowerCase().capitalize,
                                      type: 'ONLINE'.toLowerCase().capitalize,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        default:
                          return Padding(
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
                          );
                      }
                    },
                  ).toList(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
