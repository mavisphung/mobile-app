import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/models/appointment.dart';
import 'package:hi_doctor_v2/app/modules/appointment/controllers/incoming_controller.dart';
import 'package:hi_doctor_v2/app/modules/appointment/widgets/appointment_tile.dart';

class IncomingTab extends StatefulWidget {
  IncomingTab({
    Key? key,
  }) : super(key: key);

  final IncomingController incController = Get.put(IncomingController());

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
    return GetBuilder<IncomingController>(
      init: widget.incController,
      builder: (IncomingController controller) {
        return RefreshIndicator(
          onRefresh: () async {
            widget.incController.clearIncomingList();
            widget.incController.getUserIncomingAppointments();
          },
          child: SingleChildScrollView(
            controller: widget.incController.scrollController,
            primary: false,
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.sp),
              child: Column(
                children: [
                  SizedBox(
                    height: 18.sp,
                  ),
                  // Row(
                  //   children: [
                  //     ElevatedButton(
                  //       onPressed: () {
                  //         widget.incController.clearIncomingList();
                  //       },
                  //       child: const Text('Clear'),
                  //     ),
                  //     const Spacer(),
                  //   ],
                  // ),
                  //--------------------------------------------------------
                  if (widget.incController.incomingList.isEmpty) ...[
                    Center(
                      heightFactor: 0.06.sw,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Hiện tại chưa có cuộc hẹn nào!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )
                  ] else
                    ...widget.incController.incomingList
                        .map((e) => AppointmentTile(
                              data: Appointment(
                                id: e.id,
                                status: e.status,
                                category: e.category,
                                doctor: e.doctor,
                                bookedAt: e.bookedAt,
                                checkInCode: e.checkInCode,
                              ),
                            ))
                        .toList(),
                  // ---------------------------------------------------------
                  // if (widget.incController.)
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
