import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/common/constants.dart';
import 'package:hi_doctor_v2/app/common/util/extensions.dart';
import 'package:hi_doctor_v2/app/models/contract.dart';
import 'package:hi_doctor_v2/app/modules/contract/providers/api_contract.dart';

class ContractController extends GetxController {
  final ApiContract _apiContract = Get.put(ApiContract());

  late Contract _contract;
  Contract get contract => _contract;

  Future<bool?> getContractWithId(int contractId) async {
    final response = await _apiContract.getContractWithId(contractId).futureValue();
    print('RESP: $response');
    if (response != null && response.isSuccess && response.statusCode == Constants.successGetStatusCode) {
      _contract = Contract.fromMap(response.data);
      return true;
    } else if (response != null && !response.isSuccess) {
      return false;
    }
    return null;
  }

  @override
  void dispose() {
    _apiContract.dispose();
    super.dispose();
  }
}
