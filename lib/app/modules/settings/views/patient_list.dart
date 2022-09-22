import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hi_doctor_v2/app/modules/settings/controllers/patient_profile_controller.dart';
import 'package:hi_doctor_v2/app/modules/settings/widgets/patient_item.dart';
import 'package:hi_doctor_v2/app/modules/widgets/my_appbar.dart';

class PatientListPage extends StatelessWidget {
  const PatientListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _c = Get.put(PatientProfileController());
    return Scaffold(
      appBar: const MyAppBar(title: 'Patient profile'),
      body: Column(
        children: [
          OutlinedButton(
            onPressed: () {},
            child: const Text('Add new patient profile'),
          ),
          Expanded(
            child: FutureBuilder(
              future: _c.getPatientList(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data == true) {
                    return ListView.builder(
                      itemCount: _c.patientList.length,
                      itemBuilder: (_, index) {
                        var patient = _c.patientList[index];
                        return PatientItem(
                          patient: patient,
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: Text('No patient yet'),
                    );
                  }
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}
