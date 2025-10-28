import 'package:get/get.dart';
import 'package:handy/ui/appointment_screen/controller/appointment_screen_controller.dart';
import 'package:handy/ui/bottom_bar/controller/bottom_bar_controller.dart';
import 'package:handy/ui/chat_screen/controller/chat_screen_controller.dart';
import 'package:handy/ui/home_screen/controller/home_screen_controller.dart';
import 'package:handy/ui/profile_screen/controller/profile_screen_controller.dart';
import 'package:handy/ui/favorite_agency_screen/controller/favorite_agency_controller.dart';

class BottomBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomBarController>(() => BottomBarController());
    Get.lazyPut<HomeScreenController>(() => HomeScreenController(), fenix: true);
    Get.lazyPut<AppointmentScreenController>(() => AppointmentScreenController(), fenix: true);
    Get.lazyPut<ChatScreenController>(() => ChatScreenController(), fenix: true);
    Get.lazyPut<FavoriteAgencyController>(() => FavoriteAgencyController(), fenix: true);
    Get.lazyPut<ProfileScreenController>(() => ProfileScreenController(), fenix: true);
  }
}
