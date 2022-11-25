import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/util/enum.dart';
import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/models/doctor.dart';
import 'package:hi_doctor_v2/app/models/patient.dart';
import 'package:hi_doctor_v2/app/modules/contract/models/monitored_pathology.dart';
import 'package:hi_doctor_v2/app/modules/contract/providers/api_contract.dart';

class CreateContractController extends GetxController {
  final _apiContract = Get.put(ApiContract());
  final lMonitoredPathology = <MonitoredPathology>[].obs;
  final lOtherSharedRecord = <Map<String, dynamic>>[].obs;

  final status = Status.init.obs;
  final rxAgreedStatus = false.obs;

  late final Doctor doctor;
  final rxPatient = Rxn<Patient>();
  final rxRecordId = 0.obs;
  final rxPTmpListLength = 0.obs;

  final contractNoteController = TextEditingController();
  final startDateController = TextEditingController();

  Future<bool?> createContract() async {
    status.value = Status.loading;
    final response = await _apiContract.postContract({
      "doctor": doctor.id,
      "patient": rxPatient.value!.id,
      "package": 1,
      "startedAt": "2022-12-28 00:00:00",
      "endedAt": "2022-12-29 00:00:00",
      "prescription": [21, 22],
      "instruction": [],
      "detail": {
        "monitoredPathology": [
          {
            "id": 13570,
            "code": "T51",
            "otherCode": "T51",
            "generalName": "Ngộ độc cồn",
            "diseaseName": "Ngộ độc cồn",
            "tickets": [
              {
                "typeId": 0,
                "typeName": "Phiếu điện tim",
                "details": ["https: //...", "http://..."]
              }
            ]
          }
        ],
        "otherSharedTickets": [
          {
            "typeId": 0,
            "typeName": "Phiếu điện tim",
            "details": ["https: //...", "http://..."]
          }
        ]
      }
    }).futureValue();

    if (response != null) {
      if (response.isSuccess == true && response.statusCode == Constants.successPostStatusCode) {
        return true;
      } else {
        return false;
      }
    }
    return null;
  }

  @override
  void dispose() {
    lMonitoredPathology.clear();
    lMonitoredPathology.close();
    status.close();
    rxAgreedStatus.close();
    lOtherSharedRecord.clear();
    lOtherSharedRecord.close();
    rxPatient.close();
    rxRecordId.close();
    rxPTmpListLength.close();
    contractNoteController.dispose();
    startDateController.dispose();
    super.dispose();
  }
}
