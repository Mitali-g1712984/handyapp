import 'package:get/get.dart';
import 'package:handy/ui/set_password_screen/controller/set_password_controller.dart';

class SetPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SetPasswordController>(() => SetPasswordController());
  }
}
