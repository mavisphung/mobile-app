import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/models/appointment.dart';
import 'package:hi_doctor_v2/app/modules/appointment/controllers/history_controller.dart';
import 'package:hi_doctor_v2/app/modules/appointment/views/appointment_filter_page.dart';
import 'package:hi_doctor_v2/app/modules/appointment/widgets/appointment_tile.dart';
import 'package:hi_doctor_v2/app/modules/settings/views/user_profile_detail.dart';

import '../../../common/util/status.dart';

class HistoryTab extends StatefulWidget {
  HistoryTab({
    Key? key,
  }) : super(key: key);

  final HistoryController histController = Get.put(HistoryController());

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
    return GetBuilder(
        init: widget.histController,
        builder: (HistoryController controller) {
          return RefreshIndicator(
            onRefresh: () => Future.sync(() {
              widget.histController.clearHistoryList();
              widget.histController.getUserHistoricalAppointments();
            }),
            child: SingleChildScrollView(
              // controller: widget.histController.historyScrollController,
              physics: const AlwaysScrollableScrollPhysics(),
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
                            widget.histController.clearHistoryList();
                            'Cleared history list'.debugLog('Clear button');
                          },
                          child: const Text('Clear'),
                        ),
                        const Spacer(),
                        Text('${widget.histController.historyList.length} item(s)'),
                      ],
                    ),
                    //--------------------------------------------------------
                    if (widget.histController.loadingStatus.value == Status.loading)
                      const CircularProgressIndicator()
                    else if (widget.histController.historyList.isEmpty) ...[
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
                      ...widget.histController.historyList
                          .map((e) => AppointmentTile(
                                data: e,
                              ))
                          .toList(),
                    // ---------------------------------------------------------
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  bool get wantKeepAlive => true;
}
