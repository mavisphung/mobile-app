import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/values/colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // leading: Container(
        //   width: ScreenUtil().screenWidth / 2,
        //   color: Colors.amber,
        // child: ListTile(
        //   minLeadingWidth: 280.sp,
        //   // leading: Container(
        //   //   width: 53.0.sp,
        //   //   height: 53.0.sp,
        //   //   decoration: const BoxDecoration(
        //   //     shape: BoxShape.circle,
        //   //     image: DecorationImage(
        //   //       image: NetworkImage('https://cuu-be.s3.amazonaws.com/cuu-be/2022/6/28/O2VWFV.png'),
        //   //     ),
        //   //   ),
        //   // ),
        //   title: const Text('Hi, Mi Mi'),
        //   subtitle: const Text('How are you today?'),
        // ),
        // child: Text('HELOOOOODFKDSNFSNDFDLJFSFSMFKSDFKSFNS'),

        // ),
        title: SizedBox(
          height: 100.sp,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: ScreenUtil().screenWidth / 2,
                color: Colors.amber,
                child: ListTile(
                  // minLeadingWidth: 280.sp,
                  leading: Container(
                    width: 40.sp,
                    height: 40.sp,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage('https://cuu-be.s3.amazonaws.com/cuu-be/2022/6/28/O2VWFV.png'),
                      ),
                    ),
                  ),
                  title: const Text('Hi, Mi Mi'),
                  subtitle: const Text('How are you today?'),
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(CupertinoIcons.search),
          ),
          IconButton(
            onPressed: () {},
            color: AppColors.hightLight,
            icon: const Icon(CupertinoIcons.bell),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.sp),
              ),
              leading: Container(
                width: 53.0.sp,
                height: 53.0.sp,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage('https://cuu-be.s3.amazonaws.com/cuu-be/2022/6/28/O2VWFV.png'),
                  ),
                ),
              ),
              title: const Text('Dr.Lalalalalala'),
              subtitle: const Text('Dental Specials'),
            ),
          ],
        ),
      ),
    );
  }
}
