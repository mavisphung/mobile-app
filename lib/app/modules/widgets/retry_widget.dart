import 'package:flutter/material.dart';

class RetryWidget extends StatelessWidget {
  final String error;
  final VoidCallback onRetry;

  const RetryWidget({
    Key? key,
    this.error = 'Something went wrong',
    required this.onRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        Text(error),
        ElevatedButton(
          onPressed: onRetry,
          child: const Text('Retry'),
        ),
      ]),
    );
  }
}
