import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/modules/bottom_navbar/final_nav_bar.dart';

import '../../../common/storage/storage.dart';
import '../../bottom_navbar/nav_bar.dart';
import '../../widgets/no_internet_widget.dart';
import '../controllers/login_controller.dart';
import './login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool? _isLoggedWithToken;
  final _controller = Get.put(LoginController());

  void _isRefresh() {
    setState(() {});
  }

  Future<bool> _initializeSettings() async {
    _isLoggedWithToken = await _controller.loginWithToken();
    return Storage.getValue<bool>(CacheKey.IS_LOGGED.name) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<bool>(
          future: _initializeSettings(),
          builder: (ctx, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data == true) {
                return _isLoggedWithToken == null
                    ? NoInternetWidget(_isRefresh)
                    : _isLoggedWithToken!
                        ? FinalNavBarPage()
                        : LoginPage();
              } else {
                return LoginPage();
              }
            } else {
              return const Center(child: Text('Loading..'));
            }
          },
        ),
      ),
    );
  }
}
