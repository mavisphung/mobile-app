import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:hi_doctor_v2/app/common/values/strings.dart';

class NoInternetWidget extends StatelessWidget {
  final VoidCallback refresh;
  const NoInternetWidget(this.refresh, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SvgPicture.asset(
            'assets/icons/no_internet.svg',
            width: 100.sp,
            height: 100.sp,
          ),
          const SizedBox(height: 30),
          Text(
            Strings.noInternetMsg1,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.amber,
            ),
          ),
          const SizedBox(height: 5),
          OutlinedButton(onPressed: refresh, child: Text(Strings.reload)),
        ],
      ),
    );
  }
}

class NoInternetWidget2 extends StatelessWidget {
  const NoInternetWidget2({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 200),
        child: Column(
          children: [
            SvgPicture.asset(
              'assets/icons/no_internet.svg',
              width: 100.sp,
              height: 100.sp,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Text(
                Strings.noInternetMsg2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.orange.shade400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NoDataWidget extends StatelessWidget {
  final String message;
  const NoDataWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 200),
        child: Column(
          children: [
            SvgPicture.asset(
              'assets/icons/empty_box.svg',
              width: 100.sp,
              height: 100.sp,
            ),
            const SizedBox(height: 30),
            Text(
              message,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.amber,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SystemErrorWidget extends StatelessWidget {
  const SystemErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 200),
        child: Column(
          children: [
            SvgPicture.asset(
              'assets/icons/system_error.svg',
              width: 100.sp,
              height: 100.sp,
            ),
            const SizedBox(height: 30),
            Text(
              Strings.systemErrMsg,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.amber,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FailResponeWidget extends StatelessWidget {
  const FailResponeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SvgPicture.asset(
            'assets/icons/cancel_file.svg',
            width: 40.sp,
            height: 40.sp,
          ),
          const SizedBox(height: 20),
          Text(
            Strings.failRespMsg,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.amber,
            ),
          ),
        ],
      ),
    );
  }
}
