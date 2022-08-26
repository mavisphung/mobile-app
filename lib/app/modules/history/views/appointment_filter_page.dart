import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/modules/history/controllers/history_controller.dart';

class AppointmentFilterPage extends StatelessWidget {
  AppointmentFilterPage({Key? key}) : super(key: key);
  final HistoryController historyControler = Get.find<HistoryController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: historyControler,
        builder: (HistoryController controller) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              elevation: 0.0,
              title: const Text(
                'Filter',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              backgroundColor: Colors.transparent,
              leading: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
              child: Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Types',
                        style: TextStyle(
                          fontSize: 18.0.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Chip(
                            elevation: 5.0.sp,
                            padding: EdgeInsets.all(2),
                            backgroundColor: Colors.greenAccent[100],
                            shadowColor: Colors.black,
                            avatar: Container(
                              height: 12.0.sp,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                              ),
                            ), //CircleAvatar
                            label: SizedBox(
                              width: 80.0.sp,
                              child: Row(
                                children: [
                                  Text(
                                    'Online',
                                    style: TextStyle(fontSize: 12.0.sp),
                                  ),
                                  const Spacer(),
                                  const Icon(Icons.close_sharp),
                                ],
                              ),
                            ), //Text
                          ),
                        ],
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1.0.sp,
                  ),
                  Column(
                    children: [
                      Text(
                        'Status',
                        style: TextStyle(
                          fontSize: 18.0.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
