
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/models/appointment.dart';
import 'package:hi_doctor_v2/app/modules/history/views/appointment_filter_page.dart';
import 'package:hi_doctor_v2/app/modules/history/widgets/appointment_tile.dart';

class IncomingTab extends StatefulWidget {
  IncomingTab({
    Key? key,
    required this.date,
  }) : super(key: key);

  final String date;

  @override
  State<IncomingTab> createState() => _IncomingTabState();
}

class _IncomingTabState extends State<IncomingTab> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
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
            AppointmentTile(
              data: Appointment2(
                bookedAt: widget.date,
                doctor: 5,
                checkInCode: '123456-5-6-3',
                status: AppointmentStatus.pending.label,
                type: AppointmentType.online.label,
              ),
            ),
            AppointmentTile(
              data: Appointment2(
                bookedAt: widget.date,
                doctor: 5,
                checkInCode: '123456-5-6-3',
                status: AppointmentStatus.pending.label,
                type: AppointmentType.online.label,
              ),
            ),
            AppointmentTile(
              data: Appointment2(
                bookedAt: widget.date,
                doctor: 5,
                checkInCode: '123456-5-6-3',
                status: AppointmentStatus.pending.label,
                type: AppointmentType.online.label,
              ),
            ),
            AppointmentTile(
              data: Appointment2(
                bookedAt: widget.date,
                doctor: 5,
                checkInCode: '123456-5-6-3',
                status: AppointmentStatus.pending.label,
                type: AppointmentType.online.label,
              ),
            ),
            AppointmentTile(
              data: Appointment2(
                bookedAt: widget.date,
                doctor: 5,
                checkInCode: '123456-5-6-3',
                status: AppointmentStatus.pending.label,
                type: AppointmentType.online.label,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
