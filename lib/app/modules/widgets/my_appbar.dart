import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor = Colors.red;
  final String title;
  final List<Widget>? actions;
  bool? centerTitle;

  /// you can add more fields that meet your needs

  MyAppBar({Key? key, required this.title, this.actions, this.centerTitle = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(color: Colors.black),
      ),
      centerTitle: centerTitle,
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      leading: GestureDetector(
        onTap: () => Get.back(),
        child: const Icon(
          Icons.chevron_left,
          color: Colors.black,
        ),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
