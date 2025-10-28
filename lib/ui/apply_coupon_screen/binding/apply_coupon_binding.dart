import 'package:get/get.dart';
import 'package:handy/ui/apply_coupon_screen/controller/apply_coupon_controller.dart';
import 'package:handy/ui/confirm_booking_screen/controller/confirm_booking_controller.dart';

class ApplyCouponBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApplyCouponController>(() => ApplyCouponController());
    Get.lazyPut<ConfirmBookingController>(() => ConfirmBookingController());
  }
}
