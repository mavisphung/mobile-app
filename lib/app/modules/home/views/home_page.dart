import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/storage/storage.dart';
import '../../../routes/app_pages.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
          child: Column(
        children: [
          const Text('HOME'),
          ElevatedButton(
              onPressed: () async {
                await Storage.clearStorage();
                Get.offNamed(Routes.LOGIN);
              },
              child: const Text('LOG OUT')),
        ],
      )),
    );
  }
}
