import 'package:get/get.dart';
import 'package:handy/ui/booking_screen/controller/booking_screen_controller.dart';

class BookingScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookingScreenController>(() => BookingScreenController());
  }
}
