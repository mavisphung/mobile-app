import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/util/status.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/modules/message/controllers/message_controller.dart';

class MessagePage extends StatelessWidget {
  MessagePage({Key? key}) : super(key: key);

  final MessageController _controller = Get.put(MessageController());
  final itemCount = 101;

  Widget buildWhenSuccess() {
    return Container(
      width: Get.width,
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: _controller.itemCount,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.symmetric(vertical: 12.0.sp),
                height: Get.height.sp * 0.1,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      width: Get.width.sp * 0.2,
                      height: Get.width.sp * 0.2,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              'Bs. Hello Wolf ád ádas',
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17.0.sp,
                              ),
                            ),
                          ),
                          const Spacer(flex: 1),
                          Expanded(
                            child: Text(
                              'This is the message from huy phung',
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              style: TextStyle(
                                fontSize: 14.0.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Spacer(flex: 1),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '21/10/2022\n 10:00 AM',
                          textAlign: TextAlign.end,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Map<Status, Widget> widgets = {
      // Status.init: Container(
      //   width: Get.width,
      //   height: Get.height * 0.8,
      //   child: Center(
      //     child: Text('Init page'),
      //   ),
      // ),
      Status.init: buildWhenSuccess(),
      Status.loading: Container(
        width: Get.width,
        height: Get.height,
        child: Center(
          child: Text('Loading...'),
        ),
      ),
      Status.success: buildWhenSuccess(),
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Trò chuyện',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0.sp,
      ),
      body: GetBuilder(
        init: _controller,
        builder: (MessageController controller) => Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0.sp),
          child: RefreshIndicator(
            onRefresh: () async {
              Get.snackbar('Refresh indicator', 'Reloading...');
              controller.loadingStatus = Status.loading;
              await Future.delayed(const Duration(seconds: 1));
              controller.loadingStatus = Status.success;
            },
            child: SingleChildScrollView(
              controller: controller.scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              child: Container(
                child: widgets[controller.loadingStatus],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
