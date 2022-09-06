import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/modules/appointment/controllers/incoming_controller.dart';
import '../../../models/appointment.dart';
import '../widgets/appointment_tile.dart';
import 'appointment_filter_page.dart';

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
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0.sp),
              child: Column(
                children: [
                  SizedBox(
                    height: 18.0.sp,
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          widget.incController.clearIncomingList();
                        },
                        child: const Text('Clear'),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
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
                                offset: const Offset(0, 2),
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
                  if (widget.incController.incomingList.isEmpty) ...[
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
                    ...widget.incController.incomingList
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
