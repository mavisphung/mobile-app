import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common/values/colors.dart';
import './reminder_card.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final _headlineTextStyle = TextStyle(
    fontSize: 17.sp,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Stack(
            children: [
              Container(
                height: 100.sp,
                alignment: Alignment.topCenter,
                padding: EdgeInsets.all(20.sp),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.sp),
                    bottomRight: Radius.circular(20.sp),
                  ),
                ),
                child: SizedBox(
                  height: 50.sp,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 45.sp,
                            height: 45.sp,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage('https://cuu-be.s3.amazonaws.com/cuu-be/2022/6/28/O2VWFV.png'),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5.sp, left: 10.sp),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Hi, Mi Mi',
                                  style: TextStyle(color: AppColors.white),
                                ),
                                Text(
                                  'How are you today?',
                                  style: TextStyle(color: AppColors.white),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(left: 10.sp, right: 10.sp, top: 150.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Categories',
                        style: _headlineTextStyle,
                        textAlign: TextAlign.start,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Next appointment',
                            style: _headlineTextStyle,
                          ),
                          InkWell(
                            onTap: () {},
                            child: const Text(
                              'See all',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const ReminderCard(),
                      Text(
                        'Latest searched doctors',
                        style: _headlineTextStyle,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            right: 20.sp,
            top: 20.sp,
            child: ClipOval(
              child: Material(
                color: Colors.transparent,
                child: IconButton(
                  onPressed: () => Get.rawSnackbar(message: 'Noti'),
                  icon: Icon(
                    CupertinoIcons.bell_fill,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 20.sp,
            right: 20.sp,
            top: 80.sp,
            child: TextField(
              readOnly: true,
              onTap: () => showSearch(
                context: context,
                delegate: CustomSearcDelegate(),
              ),
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                hintText: 'Search a doctor or health issue',
                suffixIcon: const Icon(CupertinoIcons.search),
                // contentPadding: EdgeInsets.only(top: 15.sp, bottom: 15.sp, left: 18.sp, right: -18.sp),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.secondary),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.secondary),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.secondary),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CustomSearcDelegate extends SearchDelegate {
  List<String> searchTearms = [
    'Apple',
    'Banana',
    'Pear',
    'Watermelons',
    'Oranges',
    'Blueberries',
    'Strawberries',
    'Rasberries',
  ];
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTearms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemBuilder: (ctx, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
          subtitle: const Text('this is fun'),
        );
      },
      itemCount: matchQuery.length,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTearms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemBuilder: (ctx, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
      itemCount: matchQuery.length,
    );
  }
}
