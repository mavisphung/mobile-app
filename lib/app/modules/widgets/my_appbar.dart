import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor = Colors.red;
  final String title;

  /// you can add more fields that meet your needs

  const MyAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(color: Colors.black),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      // leading: const Icon(Icons.chevron_left, color: Colors.black,),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
