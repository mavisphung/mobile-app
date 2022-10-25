import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class HealthRecordsSkeleton extends StatelessWidget {
  const HealthRecordsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (_, __) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(15),
          ),
          child: SkeletonParagraph(
            style: const SkeletonParagraphStyle(lines: 4),
          ),
        );
      },
    );
  }
}
