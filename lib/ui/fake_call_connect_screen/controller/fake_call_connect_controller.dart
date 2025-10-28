import 'dart:async';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:handy/routes/app_routes.dart';

class FakeCallConnectController extends GetxController {
  dynamic args = Get.arguments;

  String? agencyName;
  String? agencyImage;
  Timer? timer;

  @override
  void onInit() async {
    await getDataFromArgs();
    timer = Timer(
      const Duration(seconds: 5),
      () {
        timer?.cancel();
        Get.back();

        Get.toNamed(
          AppRoutes.fakeVoiceCall,
          arguments: [
            agencyName,
            agencyImage,
          ],
        );
      },
    );

    super.onInit();
  }

  getDataFromArgs() {
    if (args != null) {
      if (args[0] != null || args[1] != null) {
        agencyName = args[0];
        agencyImage = args[1];
      }
      log("Agency Name :: $agencyName");
      log("Agency Image :: $agencyImage");
    }
  }
}
