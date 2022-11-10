import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/common/values/strings.dart';
import 'package:hi_doctor_v2/app/models/doctor.dart';
import 'package:hi_doctor_v2/app/models/specialist.dart';
import 'package:hi_doctor_v2/app/modules/home/controllers/home_controller.dart';
import 'package:hi_doctor_v2/app/modules/home/views/category_item.dart';
import 'package:hi_doctor_v2/app/modules/home/views/doctor_item.dart';
import 'package:hi_doctor_v2/app/modules/home/views/doctor_item_skeleton.dart';
import 'package:hi_doctor_v2/app/modules/home/views/reminder_card.dart';
import 'package:hi_doctor_v2/app/modules/search/search_delegate.dart';
import 'package:hi_doctor_v2/app/modules/settings/controllers/settings_controller.dart';
import 'package:hi_doctor_v2/app/modules/widgets/base_page.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_container.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_icon_button.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_title_section.dart';
import 'package:hi_doctor_v2/app/modules/widgets/image_container.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key) {
    _homeController = Get.put(HomeController());
    _settingsController = Get.put(SettingsController());
    _isNearestLoaded = _homeController.getNearestDoctorsApi();
  }

  late final HomeController _homeController;
  late final SettingsController _settingsController;
  late Future<bool> _isNearestLoaded;

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
              ImageContainer(
                width: 45,
                height: 45,
                imgUrl: userInfo.avatar,
              ).circle(),
              SizedBox(width: 10.sp),
              Expanded(
                child: Material(
                  borderRadius: BorderRadius.circular(Constants.textFieldRadius.sp),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(Constants.textFieldRadius.sp),
                    onTap: () => showSearch(
                      context: context,
                      delegate: CustomSearchDelegate(),
                    ),
                    child: Ink(
                      padding: EdgeInsets.symmetric(vertical: 12.sp, horizontal: 12.sp),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEBEBEB),
                        borderRadius: BorderRadius.circular(Constants.textFieldRadius.sp),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Expanded(
                            child: Text(
                              'Tìm bác sĩ hoặc bệnh lý',
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
              CustomIconButton(
                onPressed: () {},
                icon: Icon(
                  CupertinoIcons.bell_fill,
                  color: AppColors.primary,
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
                  CustomTitleSection(title: Strings.upcomingAppointment),
                  InkWell(
                    onTap: () {},
                    child: const Text(
                      'Xem tất cả',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const ReminderCard(),
              _spacing,
              CustomTitleSection(title: Strings.category),
              ObxValue<RxList<Specialist>>(
                (data) => CustomContainer(
                  height: 80.sp,
                  child: data.isNotEmpty
                      ? ListView.separated(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (_, index) {
                            return CategoryItem(spec: data[index]);
                          },
                          separatorBuilder: (_, __) => SizedBox(
                            width: 3.sp,
                          ),
                          itemCount: data.length,
                        )
                      : const SpecialistSkeleton(),
                ),
                _homeController.specialistList,
              ),
              _spacing,
              const CustomTitleSection(title: 'Bác sĩ gần khu vực'),
              SizedBox(
                height: 135.sp,
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
                            separatorBuilder: (_, __) => SizedBox(width: 10.sp),
                          )
                        : const DoctorItemSkeleton();
                  },
                  _homeController.nearestList,
                ),
              ),
              _spacing,
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
