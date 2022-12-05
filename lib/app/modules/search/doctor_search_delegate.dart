import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/constants.dart';

import 'package:hi_doctor_v2/app/models/doctor.dart';
import 'package:hi_doctor_v2/app/models/result_doctor.dart';
import 'package:hi_doctor_v2/app/modules/home/controllers/home_controller.dart';
import 'package:hi_doctor_v2/app/modules/home/views/doctor_item.dart';
import 'package:hi_doctor_v2/app/modules/home/views/doctor_item_skeleton.dart';
import 'package:hi_doctor_v2/app/modules/search/controllers/search_controller.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom/doctor_item2.dart';
import 'package:hi_doctor_v2/app/modules/widgets/loading_widget.dart';

class DoctorSearchDelegate extends SearchDelegate {
  // final Booking tag;
  final _cSearch = Get.put(SearchController());
  final _homeController = Get.put(HomeController());

  // DoctorSearchDelegate(this.tag) : super();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
          _cSearch.reset();
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  Future<bool?> search() {
    _cSearch.reset();
    return _cSearch.searchDoctor(query.trim());
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
    return FutureBuilder(
      future: search(),
      builder: (_, AsyncSnapshot<bool?> snapshot) {
        if (!snapshot.hasData) return const SizedBox.shrink();
        if (snapshot.hasData && snapshot.data == false) {
          return Center(
            child: Padding(
              padding: EdgeInsets.only(top: 50.sp),
              child: Column(
                children: [
                  SvgPicture.asset(
                    'assets/icons/no_search_found.svg',
                    width: 50.sp,
                    height: 50.sp,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.sp),
                    child: Text(
                      'Không tìm thấy kết quả nào.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        if (snapshot.hasData && snapshot.data == true) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: Constants.padding.sp, horizontal: Constants.padding.sp),
            child: ObxValue<RxList<ResultDoctor>>(
              (data) {
                if (data.isNotEmpty) {
                  return ListView.separated(
                    shrinkWrap: true,
                    controller: _cSearch.scrollController,
                    itemBuilder: (_, index) {
                      var doctor = _cSearch.searchList[index];
                      return DoctorItem2(doctor: doctor);
                    },
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemCount: data.length,
                  );
                }
                return const Text('LOADING');
              },
              _cSearch.searchList,
            ),
          );
        }
        return const LoadingWidget();
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return SizedBox(
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
    );
  }
}
