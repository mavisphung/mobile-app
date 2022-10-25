import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class MessageSkeleton extends StatelessWidget {
  const MessageSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SkeletonListView();
  }
}
