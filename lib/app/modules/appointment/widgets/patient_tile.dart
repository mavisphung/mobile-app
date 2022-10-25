import 'package:flutter/material.dart';

import 'package:hi_doctor_v2/app/common/util/transformation.dart';
import 'package:hi_doctor_v2/app/models/patient.dart';
import 'package:hi_doctor_v2/app/modules/widgets/image_container.dart';

class PatientTile extends StatelessWidget {
  final Patient patient;
  const PatientTile({
    Key? key,
    required this.patient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: ImageContainer(
        width: 50,
        height: 50,
        imgUrl: patient.avatar,
      ).circle(),
      title: Text(Tx.getFullName(patient.lastName, patient.firstName)),
      subtitle: Text('${patient.gender}'),
    );
  }
}
