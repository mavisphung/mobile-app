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

class ContractPendingController extends GetxController {
  late final ScrollController scrollController;
  RxList<Contract> pendingList = <Contract>[].obs;
  Rx<Status> loadingStatus = Status.init.obs;
  RxInt currentPage = 1.obs;
  int totalItems = 0;

  late ApiContract _apiContract;
  TextEditingController textController = TextEditingController();
  RxString rxReason = CancelReason.item1.obs;

  void clearPendingList() {
    totalItems = 0;
    currentPage.value = 1;
    pendingList.clear();
  }

  Future<void> getPendingContracts({int page = 1, int limit = 10}) async {
    'loading pending contract'.debugLog('Pending Tab');
    Response result = await _apiContract.getFilterContract(CONTRACT_STATUS.PENDING.name, page: page, limit: limit);
    var response = ApiResponse.getResponse(result); // Map
    PagingModel pageModel = PagingModel.fromMap(response);

    totalItems = pageModel.totalItems ?? 0;
    if (pageModel.nextPage != null) {
      currentPage.value = pageModel.nextPage!;
    }
    response[Constants.currentPage].toString().debugLog('Current Page');
    ResponseModel2 model = ResponseModel2.fromMap(response);
    var data = model.data as List<dynamic>;
    pendingList.value += data.map((e) {
      final contract = Contract.fromMap(e);
      return contract;
    }).toList();
    data.length.toString().debugLog('Items in PENDING list');
  }

  Future<void> getApprovedContracts({int page = 1, int limit = 10}) async {
    'loading approved contract'.debugLog('Pending Tab');
    Response result = await _apiContract.getFilterContract(CONTRACT_STATUS.APPROVED.name, page: page, limit: limit);
    var response = ApiResponse.getResponse(result); // Map
    PagingModel pageModel = PagingModel.fromMap(response);

    totalItems = pageModel.totalItems ?? 0;
    if (pageModel.nextPage != null) {
      currentPage.value = pageModel.nextPage!;
    }
    response[Constants.currentPage].toString().debugLog('Current Page');
    ResponseModel2 model = ResponseModel2.fromMap(response);
    var data = model.data as List<dynamic>;
    pendingList.value += data.map((e) {
      final contract = Contract.fromMap(e);
      return contract;
    }).toList();
    data.length.toString().debugLog('Items in APPROVED list');
  }

  Future<void> getSignedContracts({int page = 1, int limit = 10}) async {
    'loading signed contract'.debugLog('Pending Tab');
    Response result = await _apiContract.getFilterContract(CONTRACT_STATUS.SIGNED.name, page: page, limit: limit);
    var response = ApiResponse.getResponse(result); // Map
    PagingModel pageModel = PagingModel.fromMap(response);

    totalItems = pageModel.totalItems ?? 0;
    if (pageModel.nextPage != null) {
      currentPage.value = pageModel.nextPage!;
    }
    response[Constants.currentPage].toString().debugLog('Current Page');
    ResponseModel2 model = ResponseModel2.fromMap(response);
    var data = model.data as List<dynamic>;
    pendingList.value += data.map((e) {
      final contract = Contract.fromMap(e);
      return contract;
    }).toList();
    data.length.toString().debugLog('Items in SIGNED list');
  }

  // Future<bool> cancelAppointment(int appId, String reason) async {
  //   var response = await _apiContract.cancelAppointment(appId, reason);
  //   response.body.toString().debugLog('IncomingController#cancelAppointment: ');
  //   if (response.isOk) {
  //     incomingList.removeWhere((element) => element.id == appId);
  //   }
  //   return response.isOk == true;
  // }

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

  void init() async {
    loadMore();
    await getPendingContracts(page: 1, limit: 10);
    await getApprovedContracts(page: 1, limit: 10);
    await getSignedContracts(page: 1, limit: 10);
    complete();
  }

  @override
  void onInit() {
    super.onInit();
    _apiContract = Get.put(ApiContract());
    scrollController = ScrollController();
    // scrollController.addListener(
    //   () async {
    //     if (scrollController.position.maxScrollExtent == scrollController.offset) {
    //       if (pendingList.length >= totalItems) return;
    //       loadMore();
    //       loadingStatus.value.toString().debugLog('loading status');
    //       getPendingContracts(page: currentPage.value);
    //       getApprovedContracts(page: currentPage.value);
    //       getSignedContracts(page: currentPage.value);
    //       complete();
    //     }
    //   },
    // );
    init();
  }

  @override
  void dispose() {
    _apiContract.dispose();
    pendingList.close();
    scrollController.dispose();
    textController.dispose();
    rxReason.close();
    super.dispose();
  }
}
