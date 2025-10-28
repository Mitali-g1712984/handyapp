import 'package:get/get.dart';
import 'package:handy/ui/confirm_booking_screen/controller/confirm_booking_controller.dart';
import 'package:handy/ui/history_screen/controller/history_screen_controller.dart';

class ConfirmBookingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConfirmBookingController>(() => ConfirmBookingController());
    Get.lazyPut<HistoryScreenController>(() => HistoryScreenController());
  }
}
