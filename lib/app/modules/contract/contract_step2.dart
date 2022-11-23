import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/modules/contract/controllers/create_contract_controller.dart';

class ContractStep2 extends StatelessWidget {
  final _c = Get.put(CreateContractController());
  ContractStep2({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(_c.lMonitoredPathology.toString()),
        const SizedBox(height: 50),
        Text(_c.lOtherSharedRecord.toString()),
      ],
    );
  }
}
