import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoInternetWidget extends StatelessWidget {
  final VoidCallback refresh;
  const NoInternetWidget(this.refresh, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SvgPicture.asset('assets/icons/no_internet.svg'),
          const Text('A network error occurs, please tap the button to reload'),
          OutlinedButton(onPressed: refresh, child: const Text('Try again')),
        ],
      ),
    );
  }
}
