import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hi_doctor_v2/app/common/values/colors.dart';
import 'package:hi_doctor_v2/app/modules/contract/tabs/contract_history_tab.dart';
import 'package:hi_doctor_v2/app/modules/contract/tabs/contract_in_progress_tab.dart';
import 'package:hi_doctor_v2/app/modules/contract/tabs/contract_pending_tab.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_appbar.dart';

class ContractListPage extends StatefulWidget {
  const ContractListPage({Key? key}) : super(key: key);

  @override
  State<ContractListPage> createState() => _ContractListPageState();
}

class _ContractListPageState extends State<ContractListPage> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  var _tabs = <Tab>[];

  @override
  void initState() {
    super.initState();

    _tabs = <Tab>[
      Tab(
        height: 29.sp,
        text: 'Đang diễn ra',
      ),
      Tab(
        height: 29.sp,
        text: 'Đang chờ',
      ),
      Tab(
        height: 29.sp,
        text: 'Lịch sử',
      ),
    ];
    _tabController = TabController(vsync: this, length: _tabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MyAppBar(
        title: 'Danh sách hợp đồng',
        hasBackBtn: false,
      ),
      body: Column(
        children: [
          SizedBox(
            width: 350.sp,
            child: TabBar(
              indicatorSize: TabBarIndicatorSize.label,
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(
                  width: 3.sp,
                  color: AppColors.primary,
                ),
              ),
              labelColor: Colors.black87,
              unselectedLabelColor: Colors.black87,
              labelStyle: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
              controller: _tabController,
              tabs: _tabs,
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                ContractInProgressTab(),
                ContractPendingTab(),
                ContractHistoryTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
