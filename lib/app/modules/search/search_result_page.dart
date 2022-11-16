import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:hi_doctor_v2/app/models/doctor.dart';

import 'package:hi_doctor_v2/app/modules/home/controllers/home_controller.dart';
import 'package:hi_doctor_v2/app/modules/home/views/doctor_item.dart';
import 'package:hi_doctor_v2/app/modules/home/views/doctor_item_skeleton.dart';
import 'package:hi_doctor_v2/app/modules/search/controllers/search_controller.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_title_section.dart';

class SearchResultPage extends StatelessWidget {
  final _cSearch = Get.put(SearchController());
  final _homeController = Get.put(HomeController());

  SearchResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTitleSection(title: Strings.latestSearchDoctor),
            SizedBox(
              height: 125.sp,
              child: ObxValue<RxList<Doctor>>(
                (data) {
                  return data.isNotEmpty
                      ? ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: data.length,
                          itemBuilder: (_, index) {
                            var realDoctor = data[index];
                            return DoctorItem(
                              doctor: realDoctor,
                            );
                          },
                          separatorBuilder: (_, __) => SizedBox(
                            width: 10.sp,
                          ),
                        )
                      : const DoctorItemSkeleton();
                },
                _homeController.doctorList,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
