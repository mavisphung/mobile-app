import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/models/patient.dart';
import 'package:hi_doctor_v2/app/modules/contract/models/monitored_pathology.dart';

class CreateContractController extends GetxController {
  final lMonitoredPathology = <MonitoredPathology>[].obs;

  final rxPatient = Rxn<Patient>();

  @override
  void dispose() {
    lMonitoredPathology.close();
    rxPatient.close();
    super.dispose();
  }
}
