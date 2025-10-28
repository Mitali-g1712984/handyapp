import 'package:handy/ui/confirm_booking_screen/controller/confirm_booking_controller.dart';
import 'package:handy/ui/history_screen/controller/history_screen_controller.dart';
import 'package:handy/ui/my_wallet_screen/controller/my_wallet_controller.dart';
import 'package:get/get.dart';

class MyWalletBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyWalletController>(() => MyWalletController());
    Get.lazyPut<ConfirmBookingController>(() => ConfirmBookingController());
    Get.lazyPut<HistoryScreenController>(() => HistoryScreenController());
  }
}
