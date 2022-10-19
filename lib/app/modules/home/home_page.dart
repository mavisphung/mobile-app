import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:hi_doctor_v2/app/modules/home/controllers/home_controller.dart';
import 'package:hi_doctor_v2/app/modules/home/views/category_item.dart';
import 'package:hi_doctor_v2/app/modules/home/views/doctor_item.dart';
import 'package:hi_doctor_v2/app/modules/home/views/reminder_card.dart';
import 'package:hi_doctor_v2/app/modules/settings/controllers/settings_controller.dart';
import 'package:hi_doctor_v2/app/modules/widgets/base_page.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_container.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_icon_button.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_title_section.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final HomeController _homeController = Get.put(HomeController());
  final _settingsController = Get.put(SettingsController());

  final _spacing = SizedBox(
    height: 18.sp,
  );

  @override
  Widget build(BuildContext context) {
    final userInfo = _settingsController.userInfo.value;
    return BasePage(
      appBar: null,
      paddingTop: 18.sp,
      body: Column(
        children: [
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
              Obx(
                () => CustomContainer(
                  height: 80.sp,
                  child: _homeController.specialistList.isNotEmpty
                      ? ListView.separated(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (_, index) {
                            var temp = _homeController.specialistList[index];
                            return CategoryItem(
                              label: temp.name!,
                              image: 'assets/icons/specs/cardio2.svg',
                            );
                          },
                          separatorBuilder: (_, __) => SizedBox(
                            width: 3.sp,
                          ),
                          itemCount: _homeController.specialistList.length,
                        )
                      : const Center(child: CircularProgressIndicator()),
                ),
              ),
              _spacing,
              const CustomTitleSection(title: 'Bác sĩ gần khu vực'),
              Obx(
                () => SizedBox(
                  height: 135.sp,
                  width: double.infinity,
                  child: _homeController.nearestList.isNotEmpty
                      ? ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: _homeController.nearestList.length,
                          itemBuilder: (_, index) {
                            var realDoctor = _homeController.nearestList[index];
                            return DoctorItem(
                              doctor: realDoctor,
                            );
                          },
                          separatorBuilder: (_, __) => SizedBox(
                            width: 10.sp,
                          ),
                        )
                      : const Center(child: CircularProgressIndicator()),
                ),
              ),
              _spacing,
              CustomTitleSection(title: Strings.latestSearchDoctor.tr),
              FutureBuilder(
                future: _homeController.getDoctors(),
                builder: (_, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return GetBuilder(
                      init: _homeController,
                      builder: (_) {
                        return SizedBox(
                          height: 125.sp,
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
