import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/common/util/enum.dart';
import 'package:hi_doctor_v2/app/data/api_response.dart';
import 'package:hi_doctor_v2/app/data/response_model.dart';
import 'package:hi_doctor_v2/app/models/contract.dart';
import 'package:hi_doctor_v2/app/models/paging.dart';
import 'package:hi_doctor_v2/app/modules/contract/providers/api_contract.dart';

class ContractHistoryController extends GetxController {
  late final ScrollController scrollController;
  RxList<Contract> historyList = <Contract>[].obs;
  Rx<Status> loadingStatus = Status.init.obs;
  RxInt currentPage = 1.obs;
  int totalItems = 0;

  late ApiContract _apiContract;
  TextEditingController textController = TextEditingController();
  RxString rxReason = CancelReason.item1.obs;

  void clearHistoryList() {
    totalItems = 0;
    currentPage.value = 1;
    historyList.clear();
  }

  void getHistoryContracts({int page = 1, int limit = 10}) async {
    loadMore();
    'loading history contracts'.debugLog('HistoryTab');
    Response result = await _apiContract.getFilterContract(CONTRACT_STATUS.CANCELLED.name, page: page, limit: limit);
    var response = ApiResponse.getResponse(result); // Map
    PagingModel pageModel = PagingModel.fromMap(response);

    totalItems = pageModel.totalItems ?? 0;

    if (pageModel.nextPage != null) {
      currentPage.value = pageModel.nextPage!;
    }
    response[Constants.currentPage].toString().debugLog('Current Page');
    ResponseModel2 model = ResponseModel2.fromMap(response);
    var data = model.data as List<dynamic>;
    final tmp = historyList.toList();
    tmp.addAll(data.map((e) {
      final contract = Contract.fromMap(e);
      return contract;
    }).toList());
    historyList.value = tmp;
    complete();
    historyList.length.toString().debugLog('Items in list');
  }

  void loadMore() {
    loadingStatus.value = Status.loading;
  }

  void complete() {
    loadingStatus.value = Status.success;
  }

  bool validateCancelReason() {
    loadMore();
    return textController.text.isNotEmpty;
  }

  @override
  void onInit() {
    super.onInit();
    _apiContract = Get.find<ApiContract>();
    scrollController = ScrollController();
    scrollController.addListener(
      () async {
        if (scrollController.position.maxScrollExtent == scrollController.offset) {
          if (historyList.length >= totalItems) return;
          loadMore();
          loadingStatus.value.toString().debugLog('loading status');
          getHistoryContracts(page: currentPage.value);
          complete();
        }
      },
    );
    getHistoryContracts(page: 1, limit: 10);
  }

  @override
  void dispose() {
    historyList.close();
    _apiContract.dispose();
    scrollController.dispose();
    textController.dispose();
    rxReason.close();
    super.dispose();
  }
}
