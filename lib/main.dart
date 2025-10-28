import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:handy/localization/locale_constant.dart';
import 'package:handy/localization/localizations_delegate.dart';
import 'package:handy/routes/app_pages.dart';
import 'package:handy/routes/app_routes.dart';
import 'package:handy/services/location_service/location_service.dart';
import 'package:handy/services/notification_services/notification_services.dart';
import 'package:handy/utils/constant.dart';
import 'package:handy/utils/global_variables.dart';
import 'package:handy/utils/preference.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();

  /// Get FCM Token
  try {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    await messaging.getToken().then((value) {
      fcmToken = value ?? '';
      log("Fcm Token :: $fcmToken");
    });
  } catch (e) {
    log("Error FCM token: $e");
  }

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  /// Background Notification
  if (Constant.storage.read("notification") == true) {
    FirebaseMessaging.onBackgroundMessage(NotificationServices.backgroundNotification);
  } else {
    log("Notification Permission not allowed");
  }

  /// ---------- Get Location Permission ---------- ///
  permissions();

  Permission.locationAlways.request();

  /// For Cover Safe Area
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  Permission.microphone.request();

  /// Preference
  await Preference().instance();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        log("didChangeDependencies Preference Revoked ${locale.languageCode}");
        log("didChangeDependencies GET LOCALE Revoked ${Get.locale!.languageCode}");
        Get.updateLocale(locale);
      });
    });
    super.didChangeDependencies();
  }

  void didChangeAppLifecycleState(AppLifecycleState state) async {
    log("Did Change App Lifecycle State :: $state");

    if (state == AppLifecycleState.paused) {
      FlutterRingtonePlayer().stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          currentFocus.focusedChild?.unfocus();
        }
      },
      child: GetMaterialApp( 
        theme: Theme.of(context).copyWith(
          appBarTheme: Theme.of(context).appBarTheme.copyWith(
                systemOverlayStyle: SystemUiOverlayStyle.light,
              ),
        ),
        debugShowCheckedModeBanner: false,
        locale: const Locale("en"),
        translations: AppLanguages(),
        initialRoute: AppRoutes.initial,
        getPages: AppPages.list,
        title: "Handy Customer",
        defaultTransition: Transition.fade,
        transitionDuration: const Duration(milliseconds: 200),
      ),
    );
  }
}
