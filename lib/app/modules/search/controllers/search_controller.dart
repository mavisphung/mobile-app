import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/data/api_response.dart';
import 'package:hi_doctor_v2/app/data/response_model.dart';
import 'package:hi_doctor_v2/app/models/result_doctor.dart';
import 'package:hi_doctor_v2/app/modules/search/providers/api_search.dart';

class SearchController extends GetxController {
  late final ScrollController scrollController;
  late final ApiSearch _apiSearch;
  RxList<ResultDoctor> searchList = <ResultDoctor>[].obs;

  int _nextPage = 1;
  int _totalItems = 0;
  String _keyword = '';

  void reset() {
    searchList.clear();
    _nextPage = 1;
    _totalItems = 0;
  }

  Future<bool?> searchDoctor(String keyword, {int page = 1, int limit = 10}) async {
    if (keyword.isEmpty) return null;
    _keyword = keyword;

    final result = await _apiSearch.getSearchDoctors(query: keyword, page: page, limit: limit);
    final Map<String, dynamic> response = ApiResponse.getResponse(result);
    final model = ResponseModel2.fromMap(response);

    if (model.nextPage != null) _nextPage = model.nextPage!;
    if (model.totalItems != null) _totalItems = model.totalItems!;

    final data = model.data as List<dynamic>;
    if (data.isEmpty) return false;
    searchList.value += data.map((e) => ResultDoctor.fromMap(e)).toList();
    return true;
  }

  @override
  void onInit() {
    _apiSearch = Get.put(ApiSearch());
    scrollController = ScrollController();
    scrollController.addListener(
      () async {
        if (scrollController.position.maxScrollExtent == scrollController.offset) {
          if (searchList.length >= _totalItems) return;
          searchDoctor(_keyword, page: _nextPage);
        }
      },
    );
    super.onInit();
  }

  @override
  void dispose() {
    searchList.clear();
    searchList.close();
    _apiSearch.dispose();
    super.dispose();
  }
}
