import 'package:flutter/material.dart';
import 'package:handy/ui/confirm_booking_screen/widget/confirm_booking_widget.dart';
import 'package:handy/utils/app_color.dart';

class ConfirmBookingScreen extends StatelessWidget {
  const ConfirmBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: const ConfirmBookingAppBarView(),
      ),
      bottomNavigationBar: const ConfirmBookingBottomView(),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            ConfirmBookingInfoView(),
            ConfirmBookingAppointmentView(),
            ConfirmBookingPaymentView(),
            ConfirmBookingCouponView()
          ],
        ),
      ),
    );
  }
}
