import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hi_doctor_v2/app/common/util/transformation.dart';

import 'package:hi_doctor_v2/app/models/patient.dart';

class PatientTile extends StatelessWidget {
  final Patient patient;
  const PatientTile({
    Key? key,
    required this.patient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: Container(
        width: 50.sp,
        height: 50.sp,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: NetworkImage(patient.avatar!),
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(Tx.getFullName(patient.lastName, patient.firstName)),
      subtitle: Text('${patient.gender}'),
    );
  }
}
