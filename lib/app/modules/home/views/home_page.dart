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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Text('HOME'),
            ElevatedButton(
              onPressed: () async {
                await Storage.clearStorage();
                Get.offNamed(Routes.LOGIN);
              },
              child: const Text('LOG OUT'),
            ),
            Container(
              height: 220,
              width: double.infinity,
              color: Colors.blue,
            ),
            Container(
              height: 220,
              width: double.infinity,
              color: Colors.yellow,
            ),
            Container(
              height: 220,
              width: double.infinity,
              color: Colors.red,
            ),
            Container(
              height: 220,
              width: double.infinity,
              color: Colors.purple,
            ),
            Container(
              height: 220,
              width: double.infinity,
              color: Colors.pink,
            ),
            Container(
              height: 220,
              width: double.infinity,
              color: Colors.blue,
            ),
            Container(
              height: 220,
              width: double.infinity,
              color: Colors.green,
            ),
            Container(
              height: 220,
              width: double.infinity,
              color: Colors.orange,
            ),
            Container(
              height: 220,
              width: double.infinity,
              color: Colors.cyan,
            ),
          ],
        ),
      ),
    );
  }
}
