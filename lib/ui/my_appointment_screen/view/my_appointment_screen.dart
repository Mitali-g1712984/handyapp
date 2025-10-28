import 'package:flutter/material.dart';
import 'package:handy/ui/my_appointment_screen/widget/my_appointment_widget.dart';
import 'package:handy/utils/app_color.dart';

class MyAppointmentScreen extends StatelessWidget {
  const MyAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: const MyAppointmentAppBarView(),
      ),
      body: const Column(
        children: [
          MyAppointmentTitleView(),
          Expanded(child: MyAppointmentListView()),
        ],
      ),
    );
  }
}
