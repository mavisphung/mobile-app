import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/util/enum.dart';
import 'package:hi_doctor_v2/app/models/contract.dart';
import 'package:hi_doctor_v2/app/modules/appointment/widgets/filter_button.dart';
import 'package:hi_doctor_v2/app/modules/contract/controllers/contract_history_controller.dart';
import 'package:hi_doctor_v2/app/modules/contract/tabs/history_contract_tile.dart';
import 'package:hi_doctor_v2/app/modules/widgets/loading_widget.dart';
import 'package:hi_doctor_v2/app/modules/widgets/response_status_widget.dart';

class ContractHistoryTab extends StatefulWidget {
  const ContractHistoryTab({Key? key}) : super(key: key);

  @override
  State<ContractHistoryTab> createState() => _ContractHistoryTabState();
}

class _ContractHistoryTabState extends State<ContractHistoryTab> with AutomaticKeepAliveClientMixin {
  final _cContractHistory = Get.put(ContractHistoryController());
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: () async {
        _cContractHistory.clearHistoryList();
        _cContractHistory.getHistoryContracts();
      },
      child: SingleChildScrollView(
        controller: _cContractHistory.scrollController,
        primary: false,
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.sp),
          child: Column(
            children: [
              SizedBox(
                height: 18.sp,
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _cContractHistory.clearHistoryList();
                    },
                    child: const Text('Clear'),
                  ),
                  const Spacer(),
                  const FilterButton(),
                ],
              ),
              //--------------------------------------------------------
              ObxValue<RxList<Contract>>(
                (data) {
                  if (data.isNotEmpty) {
                    return Column(
                      children: data.map((e) => HistoryContractTile(data: e)).toList(),
                    );
                  } else if (data.isEmpty && _cContractHistory.loadingStatus.value == Status.success) {
                    return const NoDataWidget(message: 'Bạn không có hợp đồng nào trong lịch sử');
                  }
                  return const LoadingWidget();
                },
                _cContractHistory.historyList,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
