import 'package:flutter/material.dart';
import 'package:handy/ui/upcoming_appointment_screen/widget/upcoming_appointment_widget.dart';

class UpcomingAppointmentScreen extends StatelessWidget {
  const UpcomingAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: const UpcomingAppointmentAppBarView(),
      ),
      body: const UpcomingAppointmentListView(),
    );
  }
}
