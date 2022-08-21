import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../data/api_retry_controller.dart';

class BaseWidget extends StatelessWidget {
  final Widget child;

  const BaseWidget({
    Key? key,
    required this.child,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      // child: GetBuilder<ApiRetryController>(
      //   builder: (controller) => Stack(
      //     children: [
      //       Positioned.fill(child: child),
      //       Visibility(
      //         visible: controller.retry != null && controller.error != null,
      //         child: Positioned.fill(child: child),
      //       ),
      //     ],
      //   ),
      // ),
      child: child,
    );
  }
}
