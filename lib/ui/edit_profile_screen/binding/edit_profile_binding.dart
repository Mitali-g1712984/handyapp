import 'package:get/get.dart';
import 'package:handy/ui/edit_profile_screen/controller/edit_profile_controller.dart';
import 'package:handy/ui/profile_screen/controller/profile_screen_controller.dart';

class EditProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditProfileController>(() => EditProfileController());
    Get.lazyPut<ProfileScreenController>(() => ProfileScreenController());
  }
}
