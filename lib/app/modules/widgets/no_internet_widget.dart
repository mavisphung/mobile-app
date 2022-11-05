import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
          const Text(
            'A network error occurs.\nPlease tap the button to reload',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black54),
          ),
          const SizedBox(height: 5),
          OutlinedButton(onPressed: refresh, child: const Text('Refresh')),
        ],
      ),
    );
  }
}
