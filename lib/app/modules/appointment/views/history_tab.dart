import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/models/appointment.dart';
import 'package:hi_doctor_v2/app/modules/appointment/controllers/appointment_controller.dart';
import 'package:hi_doctor_v2/app/modules/appointment/views/appointment_filter_page.dart';
import 'package:hi_doctor_v2/app/modules/appointment/widgets/appointment_tile.dart';
import 'package:hi_doctor_v2/app/modules/settings/views/user_profile_detail.dart';

class HistoryTab extends StatefulWidget {
  HistoryTab({
    Key? key,
    this.data,
  }) : super(key: key);

  final AppointmentController appsController = Get.find<AppointmentController>();
  final List<Appointment>? data;

  @override
  State<HistoryTab> createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: () => Future.sync(() {
        widget.appsController.clearHistoryList();
        widget.appsController.getUserHistoricalAppointments();
      }),
      child: SingleChildScrollView(
        // controller: widget.appsController.historyScrollController,
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
                      widget.appsController.clearHistoryList();
                      'Cleared incoming list'.debugLog('Clear button');
                    },
                    child: const Text('Clear'),
                  ),
                  const Spacer(),
                  Text('${widget.appsController.historyList.length} item(s)'),
                ],
              ),
              //--------------------------------------------------------
              if (widget.appsController.historyTabStatus.value == Status.loading)
                const CircularProgressIndicator()
              else if (widget.data == null || widget.data!.isEmpty) ...[
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
                          data: e,
                        ))
                    .toList(),
              // // ---------------------------------------------------------
              // AppointmentTile(
              //   data: Appointment(
              //     doctor: {
              //       'firstName': 'AKA',
              //       'lastName': '47',
              //     },
              //     bookedAt: '2000-24-24 09:24:00',
              //     status: AppointmentStatus.completed.label,
              //     type: AppointmentType.online.label,
              //   ),
              // ),
              // AppointmentTile(
              //   data: Appointment(
              //     doctor: {
              //       'firstName': 'AKA',
              //       'lastName': '47',
              //     },
              //     bookedAt: '2000-24-24 09:24:00',
              //     status: AppointmentStatus.completed.label,
              //     type: AppointmentType.online.label,
              //   ),
              // ),
              // AppointmentTile(
              //   data: Appointment(
              //     doctor: {
              //       'firstName': 'AKA',
              //       'lastName': '47',
              //     },
              //     bookedAt: '2000-24-24 09:24:00',
              //     status: AppointmentStatus.completed.label,
              //     type: AppointmentType.online.label,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
