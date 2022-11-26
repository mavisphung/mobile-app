import 'package:flutter/material.dart';
import 'package:hi_doctor_v2/app/modules/widgets/custom_card.dart';

class NoAppointmentCard extends StatelessWidget {
  const NoAppointmentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomCard(
      horizontalPadding: 18,
      child: Text('Không có cuộc hẹn sắp tới nào.'),
    );
  }
}
