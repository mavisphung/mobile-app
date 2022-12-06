import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/util/enum.dart';
import 'package:hi_doctor_v2/app/models/contract.dart';

import 'package:hi_doctor_v2/app/modules/contract/controllers/contract_inprogress_controller.dart';
import 'package:hi_doctor_v2/app/modules/contract/tabs/in_progress_contract_tile.dart';
import 'package:hi_doctor_v2/app/modules/widgets/loading_widget.dart';
import 'package:hi_doctor_v2/app/modules/widgets/response_status_widget.dart';

class ContractInProgressTab extends StatefulWidget {
  const ContractInProgressTab({Key? key}) : super(key: key);

  @override
  State<ContractInProgressTab> createState() => _ContractInProgressTabState();
}

class _ContractInProgressTabState extends State<ContractInProgressTab> with AutomaticKeepAliveClientMixin {
  final _cContractInProgress = Get.put(ContractInProgressController());
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: () async {
        _cContractInProgress.clearInProgressList();
        _cContractInProgress.getInProgressContracts();
      },
      child: SingleChildScrollView(
        controller: _cContractInProgress.scrollController,
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
                      _cContractInProgress.clearInProgressList();
                    },
                    child: const Text('Clear'),
                  ),
                  const Spacer(),
                ],
              ),
              //--------------------------------------------------------
              ObxValue<RxList<Contract>>(
                (data) {
                  if (data.isNotEmpty) {
                    return Column(
                      children: data.map((e) => InProgressContractTile(data: e)).toList(),
                    );
                  } else if (data.isEmpty && _cContractInProgress.loadingStatus.value == Status.success) {
                    return const NoDataWidget(message: 'Bạn không có hợp đồng nào đang diễn ra.');
                  }
                  return const LoadingWidget();
                },
                _cContractInProgress.inProgressList,
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
