import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/storage/storage.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:hi_doctor_v2/app/models/user_info.dart';
import 'package:hi_doctor_v2/app/modules/home/controllers/doctor_controller.dart';
import 'package:hi_doctor_v2/app/modules/home/controllers/home_controller.dart';
import 'package:hi_doctor_v2/app/modules/home/views/category_item.dart';
import 'package:hi_doctor_v2/app/modules/home/views/doctor_item.dart';
import 'package:hi_doctor_v2/app/modules/home/views/reminder_card.dart';
import 'package:hi_doctor_v2/app/modules/settings/controllers/settings_controller.dart';
import 'package:hi_doctor_v2/app/modules/widgets/base_page.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_icon_button.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_title_section.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final _categoriesList = categoriesList;

  final HomeController _homeController = Get.put(HomeController());
  final DoctorController _doctorController = Get.put(DoctorController());
  final _settingsController = Get.put(SettingsController());

  final _spacing = SizedBox(
    height: 18.sp,
  );

  @override
  Widget build(BuildContext context) {
    final userInfo = _settingsController.userInfo.value;
    return BasePage(
      appBar: null,
      body: Column(
        children: [
          _spacing,
          Row(
            children: [
              Container(
                width: 37.sp,
                height: 37.sp,
                margin: EdgeInsets.only(right: 10.sp),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(userInfo.avatar ?? Constants.defaultAvatar),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Material(
                  borderRadius: BorderRadius.circular(Constants.textFieldRadius.sp),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(Constants.textFieldRadius.sp),
                    onTap: () => showSearch(
                      context: context,
                      delegate: CustomSearcDelegate(),
                    ),
                    child: Ink(
                      padding: EdgeInsets.symmetric(vertical: 12.sp, horizontal: 12.sp),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(Constants.textFieldRadius.sp),
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
          _spacing,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomTitleSection(title: Strings.upcomingAppointment.tr),
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
              CustomTitleSection(title: Strings.category.tr),
              SizedBox(
                height: 80.sp,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (_, index) => CategoryItem(
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
              CustomTitleSection(title: Strings.latestSearchDoctor.tr),
              FutureBuilder(
                future: _homeController.getDoctors(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return GetBuilder(
                      init: _homeController,
                      builder: (_) {
                        return SizedBox(
                          height: 150.sp,
                          width: double.infinity,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: _homeController.doctorList.length,
                            itemBuilder: (_, index) {
                              var realDoctor = _homeController.doctorList[index];
                              // realDoctor.toJson().debugLog('Doctor');
                              // 'Build again $index'.debugLog('DoctorList');
                              return DoctorItem(
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
                            separatorBuilder: (_, __) => SizedBox(
                              width: 10.sp,
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return const CircularProgressIndicator();
                },
              ),
              SizedBox(
                height: 50.sp,
              ),
            ],
          ),
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
