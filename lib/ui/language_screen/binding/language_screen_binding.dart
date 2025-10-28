import 'package:get/get.dart';
import 'package:handy/ui/language_screen/controller/language_screen_controller.dart';

class LanguageScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LanguageScreenController>(() => LanguageScreenController());
  }
}
