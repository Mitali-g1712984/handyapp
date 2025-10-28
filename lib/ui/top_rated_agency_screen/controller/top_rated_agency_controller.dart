import 'package:handy/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopRatedAgencyController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController? tabController;
  late List<bool> isSaved = List.generate(5, (index) => false);

  @override
  void onInit() {
    tabController = TabController(initialIndex: 0, length: 6, vsync: this);
    super.onInit();
  }

  onDoctorSaved(int index, value) {
    isSaved[index] = value;
    update([Constant.idTopSpecialistSaved]);
  }

  var tabs = [
    const Tab(text: "General"),
    const Tab(text: "Dentist"),
    const Tab(text: "Nutrition"),
    const Tab(text: "Pediatric"),
    const Tab(text: "Radiology"),
    const Tab(text: "Cardiologist"),
  ];
}
