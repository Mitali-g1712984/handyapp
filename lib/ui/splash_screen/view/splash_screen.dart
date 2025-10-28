// import 'package:flutter/material.dart';
// import 'package:handy/ui/splash_screen/widget/splash_screen_widget.dart';

// class SplashScreen extends StatelessWidget {
//   const SplashScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: SplashLogoView(),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:handy/routes/app_routes.dart';
import 'package:handy/ui/splash_screen/widget/splash_screen_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final box = GetStorage();

  @override
  void initState() {
    super.initState();
    _navigateNext();
  }

  void _navigateNext() async {
    // Simulate splash delay
    await Future.delayed(const Duration(seconds: 2));

    bool onboardingDone = box.read('onboarding_done') ?? false;
    bool loggedIn = box.read('logged_in') ?? false;

    if (!onboardingDone) {
      Get.offNamed(AppRoutes.onBoarding);
    } else if (!loggedIn) {
      Get.offNamed(AppRoutes.login);
    } else {
      Get.offNamed(AppRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SplashLogoView(),
    );
  }
}
