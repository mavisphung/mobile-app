import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/util/enum.dart';
import 'package:hi_doctor_v2/app/models/contract.dart';

import 'package:hi_doctor_v2/app/modules/contract/controllers/contract_pending_controller.dart';
import 'package:hi_doctor_v2/app/modules/contract/tabs/pending_contract_tile.dart';
import 'package:hi_doctor_v2/app/modules/widgets/loading_widget.dart';
import 'package:hi_doctor_v2/app/modules/widgets/response_status_widget.dart';

class ContractPendingTab extends StatefulWidget {
  const ContractPendingTab({Key? key}) : super(key: key);

  @override
  State<ContractPendingTab> createState() => _ContractPendingTabState();
}

class _ContractPendingTabState extends State<ContractPendingTab> with AutomaticKeepAliveClientMixin {
  final _cContractPending = Get.put(ContractPendingController());
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: () async {
        _cContractPending.clearPendingList();
        _cContractPending.init();
      },
      child: SingleChildScrollView(
        controller: _cContractPending.scrollController,
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
                      _cContractPending.clearPendingList();
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
                      children: data.map((e) => PendingContractTile(data: e)).toList(),
                    );
                  } else if (data.isEmpty && _cContractPending.loadingStatus.value == Status.success) {
                    return const NoDataWidget(message: 'Bạn không có hợp đồng nào đang chờ.');
                  }
                  return const LoadingWidget();
                },
                _cContractPending.pendingList,
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
