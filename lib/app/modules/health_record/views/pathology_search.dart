import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/modules/health_record/controllers/edit_health_record_controller.dart';
import 'package:hi_doctor_v2/app/modules/health_record/controllers/search_pathology_controller.dart';
import 'package:hi_doctor_v2/app/modules/widgets/loading_widget.dart';
import 'package:hi_doctor_v2/app/routes/app_pages.dart';

class PathologySearchDelegate extends SearchDelegate {
  final _cSearchPathology = Get.put(SearchPathologyController());
  final _cEditOtherHealthRecord = Get.find<EditOtherHealthRecordController>(tag: 'MAIN');

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
          _cSearchPathology.reset();
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  Future<bool?> search() {
    _cSearchPathology.reset();
    return _cSearchPathology.searchPathology(query.trim());
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
          return const Text('no result found');
        }
        if (snapshot.hasData && snapshot.data == true) {
          return ObxValue<RxInt>(
            (data) {
              return ListView.builder(
                shrinkWrap: true,
                controller: _cSearchPathology.scrollController,
                itemBuilder: (_, index) {
                  var result = _cSearchPathology.searchList[index];
                  return ListTile(
                    onTap: () {
                      final existedItem =
                          _cEditOtherHealthRecord.getPathologies.firstWhereOrNull((e) => e.id == result.id);
                      if (existedItem == null) {
                        Get.toNamed(Routes.EDIT_PATHOLOGY_RECORD, arguments: result, parameters: {'tag': 'Add'});
                        return;
                      }
                      Get.toNamed(Routes.EDIT_PATHOLOGY_RECORD, arguments: existedItem, parameters: {'tag': 'Save'});
                    },
                    title: Row(
                      children: [
                        SizedBox(
                          width: 50.sp,
                          child: Text('${result.code}'),
                        ),
                        Flexible(
                          child: Text(
                            '- ${result.diseaseName}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  );
                },
                itemCount: _cSearchPathology.searchList.length,
                itemExtent: 60,
              );
            },
            _cSearchPathology.searchList.length.obs,
          );
        }
        return const LoadingWidget();
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const SizedBox.shrink();
  }
}
