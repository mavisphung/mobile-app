import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/modules/contract/models/monitored_pathology.dart';

class CreateContractController extends GetxController {
  final lMonitoredPathology = <MonitoredPathology>[].obs;

  @override
  void dispose() {
    lMonitoredPathology.close();
    super.dispose();
  }
}
