import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/storage/storage.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:hi_doctor_v2/app/modules/home/controllers/doctor_controller.dart';
import 'package:hi_doctor_v2/app/modules/home/controllers/home_controller.dart';
// import 'package:hi_doctor_v2/app/modules/home/views/category_item.dart';
import 'package:hi_doctor_v2/app/modules/home/views/category_item2.dart';
import 'package:hi_doctor_v2/app/modules/home/views/doctor_item.dart';
import 'package:hi_doctor_v2/app/modules/home/views/reminder_card.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_icon_button.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_section_title.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final _categoriesList = categoriesList;
  final _doctorList = doctorList;

  final HomeController homeController = Get.put(HomeController());
  final DoctorController doctorController = Get.put(DoctorController());

  final _spacing = SizedBox(
    height: 18.sp,
  );

  @override
  Widget build(BuildContext context) {
    final userInfo = Storage.getValue<Map<String, dynamic>>(CacheKey.USER_INFO.name);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 12.sp, left: 10.sp, right: 5.sp),
                child: Row(
                  children: [
                    Container(
                      width: 37.sp,
                      height: 37.sp,
                      margin: EdgeInsets.only(right: 5.sp),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(userInfo?['avatar']),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Material(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(15.sp),
                          onTap: () => showSearch(
                            context: context,
                            delegate: CustomSearcDelegate(),
                          ),
                          child: Ink(
                            padding: EdgeInsets.symmetric(vertical: 12.sp, horizontal: 15.sp),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(15.sp),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Expanded(
                                  child: Text(
                                    'Search doctor or health issue',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Icon(CupertinoIcons.search),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 45.sp,
                      child: CustomIconButton(
                        onPressed: () {},
                        icon: Icon(
                          CupertinoIcons.bell_fill,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              _spacing,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MySectionTitle(title: Strings.upcomingAppointment.tr),
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
                    _spacing,
                    MySectionTitle(title: Strings.category.tr),
                    SizedBox(
                      height: 70.sp,
                      // child: GridView.builder(
                      //   physics: const NeverScrollableScrollPhysics(),
                      //   shrinkWrap: true,
                      //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      //     crossAxisCount: 3,
                      //     crossAxisSpacing: 5.sp,
                      //     mainAxisSpacing: 5.sp,
                      //     childAspectRatio: 1.6,
                      //   ),
                      //   itemBuilder: (_, index) => CategoryItem2(
                      //     label: _categoriesList[index].label,
                      //     image: _categoriesList[index].image,
                      //   ),
                      //   itemCount: _categoriesList.length,
                      // ),
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (_, index) => CategoryItem2(
                          label: _categoriesList[index].label,
                          image: _categoriesList[index].image,
                        ),
                        separatorBuilder: (_, __) => SizedBox(
                          width: 3.sp,
                        ),
                        itemCount: _categoriesList.length,
                      ),
                    ),
                    _spacing,
                    MySectionTitle(title: Strings.latestSearchDoctor.tr),
                    FutureBuilder(
                      future: homeController.getDoctors(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return GetBuilder(
                            init: homeController,
                            builder: (_) {
                              return SizedBox(
                                height: 150.sp,
                                width: double.infinity,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: homeController.doctorList.length,
                                  itemBuilder: (_, index) {
                                    var realDoctor = homeController.doctorList[index];
                                    // realDoctor.toJson().debugLog('Doctor');
                                    // 'Build again $index'.debugLog('DoctorList');
                                    return DoctorItem2(
                                      doctor: realDoctor,
                                    );
                                    // var doctor = _doctorList[index];
                                    // return DoctorItem(
                                    //   fullName: doctor.fullName,
                                    //   service: doctor.service,
                                    //   experienceYears: doctor.experienceYears,
                                    //   rating: doctor.rating,
                                    //   reviewNumber: doctor.reviewNumber,
                                    // );
                                  },
                                ),
                              );
                            },
                          );
                        }
                        return CircularProgressIndicator();
                      },
                    ),
                    SizedBox(
                      height: 50.sp,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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
