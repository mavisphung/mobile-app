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

class ContractInProgressController extends GetxController {
  late final ScrollController scrollController;
  RxList<Contract> inProgressList = <Contract>[].obs;
  Rx<Status> loadingStatus = Status.init.obs;
  RxInt currentPage = 1.obs;
  int totalItems = 0;

  late ApiContract _apiContract;
  TextEditingController textController = TextEditingController();
  RxString rxReason = CancelReason.item1.obs;

  void clearInProgressList() {
    totalItems = 0;
    currentPage.value = 1;
    inProgressList.clear();
  }

  void getInProgressContracts({int page = 1, int limit = 10}) async {
    loadMore();
    'loading in progress contract'.debugLog('InProgressTab');
    Response result = await _apiContract.getFilterContract(CONTRACT_STATUS.IN_PROGRESS.name, page: page, limit: limit);
    var response = ApiResponse.getResponse(result); // Map
    PagingModel pageModel = PagingModel.fromMap(response);

    totalItems = pageModel.totalItems ?? 0;

    if (pageModel.nextPage != null) {
      currentPage.value = pageModel.nextPage!;
    }
    response[Constants.currentPage].toString().debugLog('Current Page');
    ResponseModel2 model = ResponseModel2.fromMap(response);
    var data = model.data as List<dynamic>;
    final tmp = inProgressList.toList();
    tmp.addAll(data.map((e) {
      final contract = Contract.fromMap(e);
      return contract;
    }).toList());
    inProgressList.value = tmp;
    complete();
    inProgressList.length.toString().debugLog('Items in list');
  }

  Future<bool> cancelContract(int appId, String reason) async {
    // var response = await _apiContract.cancelAppointment(appId, reason);
    // response.body.toString().debugLog('IncomingController#cancelAppointment: ');
    // if (response.isOk) {
    //   inProgressList.removeWhere((element) => element.id == appId);
    // }
    // return response.isOk == true;
    return false;
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
    _apiContract = Get.put(ApiContract());
    scrollController = ScrollController();
    scrollController.addListener(
      () async {
        if (scrollController.position.maxScrollExtent == scrollController.offset) {
          if (inProgressList.length >= totalItems) return;
          loadMore();
          loadingStatus.value.toString().debugLog('loading status');
          getInProgressContracts(page: currentPage.value);
          complete();
        }
      },
    );
    getInProgressContracts(page: 1, limit: 10);
  }

  @override
  void dispose() {
    inProgressList.close();
    _apiContract.dispose();
    scrollController.dispose();
    textController.dispose();
    rxReason.close();
    super.dispose();
  }
}
