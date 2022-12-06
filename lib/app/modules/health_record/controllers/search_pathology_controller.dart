import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/data/api_response.dart';
import 'package:hi_doctor_v2/app/data/response_model.dart';
import 'package:hi_doctor_v2/app/models/pathology.dart';
import 'package:hi_doctor_v2/app/modules/health_record/providers/api_health_record.dart';

class SearchPathologyController extends GetxController {
  late final ScrollController scrollController;
  RxList<Pathology> searchList = <Pathology>[].obs;
  late final ApiHealthRecord _apiHealthRecord;
  int _nextPage = 1;
  int _totalItems = 0;
  late String _keyword;

  void reset() {
    searchList.clear();
    _nextPage = 1;
    _totalItems = 0;
  }

  Future<bool?> searchPathology(String keyword, {int page = 1, int limit = 50}) async {
    if (keyword.isEmpty) return null;
    _keyword = keyword;

    final result = await _apiHealthRecord.getPathologySearch(keyword, page: page, limit: limit);
    final Map<String, dynamic> response = ApiResponse.getResponse(result);
    final model = ResponseModel2.fromMap(response);

    if (model.nextPage != null) _nextPage = model.nextPage!;
    if (model.totalItems != null) _totalItems = model.totalItems!;

    final data = model.data as List<dynamic>;
    if (data.isEmpty) return false;
    searchList.value += data.map((e) => Pathology.fromMap(e)).toList();
    return true;
  }

  @override
  void onInit() {
    _apiHealthRecord = Get.put(ApiHealthRecord());
    scrollController = ScrollController();
    scrollController.addListener(
      () async {
        if (scrollController.position.maxScrollExtent == scrollController.offset) {
          if (searchList.length >= _totalItems) return;
          searchPathology(_keyword, page: _nextPage);
        }
      },
    );
    super.onInit();
  }

  @override
  void dispose() {
    searchList.clear();
    searchList.close();
    super.dispose();
  }
}
