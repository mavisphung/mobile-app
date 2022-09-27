import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/util/status.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/modules/message/controllers/message_controller.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_appbar.dart';

class MessagePage extends StatelessWidget {
  MessagePage({Key? key}) : super(key: key);

  final MessageController _controller = Get.put(MessageController());

  final _textStyle = TextStyle(
    color: Colors.grey[700],
  );

  Widget buildWhenSuccess() {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: _controller.itemCount,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, __) {
        return Container(
          height: 75.sp,
          padding: EdgeInsets.all(12.sp),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(Constants.textFieldRadius.sp),
          ),
          child: Row(
            children: [
              Container(
                width: 55.sp,
                height: 55.sp,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(width: 10.sp),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Bs. Hello Wolf ád dfsdfsdfsd fsdfsdfsf',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 6.sp,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'This is the message from huy phung',
                            overflow: TextOverflow.ellipsis,
                            style: _textStyle,
                          ),
                        ),
                        Text(
                          '10:00 pm',
                          style: _textStyle,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (_, __) => SizedBox(height: 7.sp),
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
      backgroundColor: AppColors.background,
      appBar: const MyAppBar(
        title: 'Tin nhắn',
        hasBackBtn: false,
      ),
      body: GetBuilder(
        init: _controller,
        builder: (MessageController controller) => RefreshIndicator(
          onRefresh: () async {
            Get.snackbar('Refresh indicator', 'Reloading...');
            controller.loadingStatus = Status.loading;
            await Future.delayed(const Duration(seconds: 1));
            controller.loadingStatus = Status.success;
          },
          child: SingleChildScrollView(
            controller: controller.scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(Constants.padding.sp),
              child: widgets[controller.loadingStatus],
            ),
          ),
        ),
      ),
    );
  }
}
