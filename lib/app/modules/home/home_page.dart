import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:hi_doctor_v2/app/modules/home/controllers/home_controller.dart';
import 'package:hi_doctor_v2/app/modules/home/views/category_item.dart';
import 'package:hi_doctor_v2/app/modules/home/views/doctor_item.dart';
import 'package:hi_doctor_v2/app/modules/home/views/reminder_card.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_icon_button.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final _categoriesList = categoriesList;
  final _doctorList = doctorList;

  final HomeController homeController = Get.put(HomeController());

  Widget _getTitle(String title) => Padding(
        padding: EdgeInsets.only(
          top: 20.sp,
          bottom: 12.sp,
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 17.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    homeController.getDoctorList();
    return GetBuilder(
      init: homeController,
      builder: (HomeController controller) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(40.sp),
            child: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.5,
              actions: [
                SizedBox(
                  width: 40.sp,
                  child: CustomIconButton(
                    onPressed: () => showSearch(
                      context: context,
                      delegate: CustomSearcDelegate(),
                    ),
                    icon: Icon(
                      CupertinoIcons.search,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                Container(
                  width: 40.sp,
                  margin: EdgeInsets.only(right: 10.sp),
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
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                left: 10.sp,
                right: 10.sp,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _getTitle(Strings.upcomingAppointment.tr),
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
                  _getTitle(Strings.category.tr),
                  SizedBox(
                    // height: 120.sp,
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.sp,
                        mainAxisSpacing: 10.sp,
                        childAspectRatio: 2.5,
                      ),
                      itemBuilder: (_, index) => CategoryItem(
                        label: _categoriesList[index].label,
                        image: _categoriesList[index].image,
                      ),
                      itemCount: _categoriesList.length,
                    ),
                  ),
                  _getTitle(Strings.latestSearchDoctor.tr),
                  SizedBox(
                    height: 150.sp,
                    width: double.infinity,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _doctorList.length,
                      itemBuilder: (_, index) {
                        var doctor = _doctorList[index];
                        if (index == 0) {
                          var realDoctor = controller.doctorList[index];
                          return DoctorItem2(
                            doctor: realDoctor,
                          );
                        }
                        return DoctorItem(
                          fullName: doctor.fullName,
                          service: doctor.service,
                          experienceYears: doctor.experienceYears,
                          rating: doctor.rating,
                          reviewNumber: doctor.reviewNumber,
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 50.sp,
                  )
                ],
              ),
            ),
          ),
        );
      },
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
