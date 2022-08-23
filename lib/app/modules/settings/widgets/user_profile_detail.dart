import 'package:flutter/material.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_appbar.dart';

class UserProfileDetailPage extends StatelessWidget {
  const UserProfileDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('User Profile'),
        elevation: 0,
      ),
    );
  }
}
