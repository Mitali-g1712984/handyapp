import 'package:flutter/material.dart';
import 'package:handy/ui/confirm_appointment_screen/widget/confirm_appointment_widget.dart';
import 'package:handy/utils/app_color.dart';

class ConfirmAppointmentScreen extends StatelessWidget {
  const ConfirmAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      bottomNavigationBar: const ConfirmAppointmentBottomView(),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            ConfirmAppointmentPaymentView(),
            ConfirmAppointmentInfoView(),
            ConfirmAppointmentServiceView(),
          ],
        ),
      ),
    );
  }
}
