import 'package:flutter/material.dart';

class NoInternetWidget extends StatelessWidget {
  final VoidCallback refresh;
  const NoInternetWidget(this.refresh, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text('No internet connection'),
          OutlinedButton(onPressed: refresh, child: const Text('Try again')),
        ],
      ),
    );
  }
}
