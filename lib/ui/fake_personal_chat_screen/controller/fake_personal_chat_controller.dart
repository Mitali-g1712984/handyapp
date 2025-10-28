import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:handy/ui/fake_personal_chat_screen/model/fake_personal_chat_model.dart';
import 'package:get/get.dart';

class FakePersonalChatController extends GetxController {
  dynamic args = Get.arguments;

  String? agencyName;
  String? agencyImage;
  String? serviceName;

  ValueNotifier<bool> isDialOpen = ValueNotifier(false);
  TextEditingController chatController = TextEditingController();

  List<FakePersonalChatMessage> chatMessages = [
    FakePersonalChatMessage(
      message: "Hello, I'd like to schedule a home cleaning service.",
      time: DateTime.now().subtract(const Duration(minutes: 50)),
      isSentByMe: true,
    ),
    FakePersonalChatMessage(
      message: "Hi! Sure, we can help with that. When would you like us to come?",
      time: DateTime.now().subtract(const Duration(minutes: 48)),
      isSentByMe: false,
    ),
    FakePersonalChatMessage(
      message: "Is tomorrow morning at 10 AM available?",
      time: DateTime.now().subtract(const Duration(minutes: 45)),
      isSentByMe: true,
    ),
    FakePersonalChatMessage(
      message: "Let me check... Yes, we have an opening at 10 AM tomorrow.",
      time: DateTime.now().subtract(const Duration(minutes: 42)),
      isSentByMe: false,
    ),
    FakePersonalChatMessage(
      message: "Great! Please book it.",
      time: DateTime.now().subtract(const Duration(minutes: 40)),
      isSentByMe: true,
    ),
    FakePersonalChatMessage(
      message: "It's confirmed! Can you provide your address?",
      time: DateTime.now().subtract(const Duration(minutes: 38)),
      isSentByMe: false,
    ),
    FakePersonalChatMessage(
      message: "Sure, it's 123 Main Street, Apartment 4B.",
      time: DateTime.now().subtract(const Duration(minutes: 35)),
      isSentByMe: true,
    ),
    FakePersonalChatMessage(
      message: "Thank you! Do you have any specific cleaning requests?",
      time: DateTime.now().subtract(const Duration(minutes: 33)),
      isSentByMe: false,
    ),
    FakePersonalChatMessage(
      message: "Yes, I'd like a deep cleaning of the kitchen and bathrooms.",
      time: DateTime.now().subtract(const Duration(minutes: 30)),
      isSentByMe: true,
    ),
    FakePersonalChatMessage(
      message: "Noted! Our team will bring all necessary supplies.",
      time: DateTime.now().subtract(const Duration(minutes: 28)),
      isSentByMe: false,
    ),
    FakePersonalChatMessage(
      message: "Perfect. How long will the cleaning take?",
      time: DateTime.now().subtract(const Duration(minutes: 25)),
      isSentByMe: true,
    ),
    FakePersonalChatMessage(
      message: "It should take about 3-4 hours for a deep clean.",
      time: DateTime.now().subtract(const Duration(minutes: 23)),
      isSentByMe: false,
    ),
    FakePersonalChatMessage(
      message: "Got it. Should I be home during the cleaning?",
      time: DateTime.now().subtract(const Duration(minutes: 20)),
      isSentByMe: true,
    ),
    FakePersonalChatMessage(
      message: "It's up to you! We can clean while you're out if you prefer.",
      time: DateTime.now().subtract(const Duration(minutes: 18)),
      isSentByMe: false,
    ),
    FakePersonalChatMessage(
      message: "I’ll be home. Do you accept card payments?",
      time: DateTime.now().subtract(const Duration(minutes: 15)),
      isSentByMe: true,
    ),
    FakePersonalChatMessage(
      message: "Yes, we accept all major credit cards.",
      time: DateTime.now().subtract(const Duration(minutes: 12)),
      isSentByMe: false,
    ),
    FakePersonalChatMessage(
      message: "Great, thank you! Looking forward to the service tomorrow.",
      time: DateTime.now().subtract(const Duration(minutes: 10)),
      isSentByMe: true,
    ),
    FakePersonalChatMessage(
      message: "You're welcome! See you tomorrow at 10 AM.",
      time: DateTime.now().subtract(const Duration(minutes: 8)),
      isSentByMe: false,
    ),
  ];

  @override
  void onInit() async {
    await getDataFromArgs();

    super.onInit();
  }

  getDataFromArgs() {
    if (args != null) {
      if (args[0] != null || args[1] != null || args[2] != null) {
        agencyName = args[0];
        agencyImage = args[1];
        serviceName = args[2];
      }
      log("Agency Name :: $agencyName");
      log("Agency Image :: $agencyImage");
      log("Service Name :: $serviceName");
    }
  }

  String formatTime(DateTime time) {
    return "${time.hour}:${time.minute.toString().padLeft(2, '0')}";
  }
}
