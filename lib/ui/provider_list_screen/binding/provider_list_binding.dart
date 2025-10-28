import 'package:get/get.dart';
import 'package:handy/ui/provider_list_screen/controller/provider_list_controller.dart';

class ProviderListBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ProviderListController>(() => ProviderListController());
  }
}