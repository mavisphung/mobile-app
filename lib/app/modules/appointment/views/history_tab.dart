import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/modules/appointment/controllers/history_controller.dart';
import 'package:hi_doctor_v2/app/modules/appointment/widgets/appointment_tile.dart';
import 'package:hi_doctor_v2/app/modules/appointment/widgets/filter_button.dart';
import 'package:hi_doctor_v2/app/modules/widgets/response_status_widget.dart';

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
              controller: widget.histController.scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.sp),
                child: Column(
                  children: [
                    SizedBox(
                      height: 18.sp,
                    ),
                    Row(
                      children: const [
                        Spacer(),
                        FilterButton(),
                      ],
                    ),
                    //--------------------------------------------------------
                    if (widget.histController.historyList.isEmpty) ...[
                      const NoDataWidget(message: 'Bạn không có cuộc hẹn nào trong lịch sử.'),
                    ] else
                      ...widget.histController.historyList
                          .map((e) => HistoryAppointmentTile(
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
