import 'package:handy/ui/category_screen/controller/category_screen_controller.dart';
import 'package:get/get.dart';
import 'package:handy/ui/home_screen/controller/home_screen_controller.dart';

class CategoryScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoryScreenController>(() => CategoryScreenController());
    Get.lazyPut<HomeScreenController>(() => HomeScreenController());
  }
}
