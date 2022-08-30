import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/models/appointment.dart';
import 'package:hi_doctor_v2/app/modules/history/controllers/history_controller.dart';
import 'package:hi_doctor_v2/app/modules/history/views/appointment_filter_page.dart';
import 'package:hi_doctor_v2/app/modules/history/widgets/appointment_tile.dart';

class IncomingTab extends StatefulWidget {
  IncomingTab({
    Key? key,
    this.data,
  }) : super(key: key);

  final HistoryController historyController = Get.find<HistoryController>();
  final List<Appointment>? data;

  @override
  State<IncomingTab> createState() => _IncomingTabState();
}

class _IncomingTabState extends State<IncomingTab> with AutomaticKeepAliveClientMixin {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: () async {
        widget.historyController.clearIncomingList();
        widget.historyController.getUserIncomingAppointments();
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
          child: Column(
            children: [
              SizedBox(
                height: 18.0.sp,
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // widget.historyController.getUserIncomingAppointments(page: 1, limit: 10);
                      widget.historyController.clearList();
                      // print(widget.historyController.incomingList.value);
                    },
                    child: const Text('Clear'),
                  ),
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
              //--------------------------------------------------------
              if (widget.data == null || widget.data!.isEmpty) ...[
                Center(
                  heightFactor: 0.06.sw,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'No appointments found!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18.0.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )
              ] else
                ...widget.data!
                    .map((e) => AppointmentTile(
                          data: Appointment(
                            id: e.id,
                            status: e.status,
                            type: e.type,
                            doctor: e.doctor,
                            bookedAt: e.bookedAt,
                            checkInCode: e.checkInCode,
                          ),
                        ))
                    .toList(),
              // ---------------------------------------------------------
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
