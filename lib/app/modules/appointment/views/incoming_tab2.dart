import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/modules/appointment/controllers/incoming_controller.dart';
import '../widgets/appointment_tile.dart';

class IncomingTab2 extends StatefulWidget {
  IncomingTab2({
    Key? key,
  }) : super(key: key);

  final IncomingController incController = Get.put(IncomingController());

  @override
  State<IncomingTab2> createState() => _IncomingTab2State();
}

class _IncomingTab2State extends State<IncomingTab2> with AutomaticKeepAliveClientMixin {
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
          onRefresh: () async {},
          child: ListView.builder(
            controller: widget.incController.scrollController,
            itemCount: widget.incController.incomingList.length + 1,
            itemBuilder: (_, index) {
              final e = widget.incController.incomingList[index];
              if (index < widget.incController.incomingList.length) {
                return AppointmentTile(
                  data: e,
                );
              } else {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 32),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
            },
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
