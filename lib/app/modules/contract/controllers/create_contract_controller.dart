import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/util/enum.dart';
import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/models/doctor.dart';
import 'package:hi_doctor_v2/app/models/patient.dart';
import 'package:hi_doctor_v2/app/modules/contract/models/monitored_pathology.dart';
import 'package:hi_doctor_v2/app/modules/contract/providers/api_contract.dart';
import 'package:intl/intl.dart';

class CreateContractController extends GetxController {
  final _apiContract = Get.put(ApiContract());
  final lMonitoredPathology = <MonitoredPathology>[].obs;
  final lOtherSharedRecord = <Map<String, dynamic>>[].obs;
  final lPrescription = <int>[].obs;

  final status = Status.init.obs;
  final rxAgreedStatus = false.obs;

  late final Doctor doctor;
  final rxPatient = Rxn<Patient>();
  final rxRecordId = 0.obs;
  final rxPTmpListLength = 0.obs;

  final contractNoteController = TextEditingController();
  final startDateController = TextEditingController();
  Rx<DateTime> rxSelectedDate = DateTime.now().add(const Duration(days: 5)).obs;

  Future<bool?> createContract() async {
    status.value = Status.loading;
    final tmp1 = lMonitoredPathology.map((e) => e.toMap()).toList();
    final tmp2 = lOtherSharedRecord
        .map((e) => {
              "typeId": e['typeId'],
              "typeName": e['typeName'],
              "details": e['details'],
            })
        .toList();
    final startDate = DateFormat('yyyy-MM-dd').format(rxSelectedDate.value);
    final endDate = DateFormat('yyyy-MM-dd').format(rxSelectedDate.value.add(const Duration(days: 7)));

    final intSet = <int>{};
    List<int> tmp3 = lPrescription.where((e) => intSet.add(e)).toList();
    final reqModel = {
      "doctor": doctor.id,
      "patient": rxPatient.value!.id,
      "package": 9,
      "startedAt": "$startDate 00:00:00",
      "endedAt": "$endDate 00:00:00",
      "prescription": tmp3,
      "instruction": [],
      "detail": {
        "monitoredPathology": tmp1,
        "otherSharedTickets": tmp2,
      }
    };
    print('REGMODEL: ${reqModel.toString()}');
    final response = await _apiContract.postContract(reqModel).futureValue();

    if (response != null) {
      if (response.isSuccess == true) {
        status.value = Status.success;
        return true;
      } else {
        status.value = Status.fail;
        return false;
      }
    }
    status.value = Status.fail;
    return null;
  }

  @override
  void dispose() {
    lMonitoredPathology.clear();
    lMonitoredPathology.close();
    lOtherSharedRecord.clear();
    lOtherSharedRecord.close();
    lPrescription.clear();
    lPrescription.close();
    status.close();
    rxAgreedStatus.close();
    rxPatient.close();
    rxRecordId.close();
    rxPTmpListLength.close();
    contractNoteController.dispose();
    startDateController.dispose();
    super.dispose();
  }
}
