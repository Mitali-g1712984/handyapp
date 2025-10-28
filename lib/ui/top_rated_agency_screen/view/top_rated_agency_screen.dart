import 'package:get/get.dart';
import 'package:handy/ui/top_rated_agency_screen/widget/top_rated_agency_widget.dart';
import 'package:flutter/material.dart';
import 'package:handy/utils/app_color.dart';

class TopRatedAgencyScreen extends StatelessWidget {
  const TopRatedAgencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: const TopRatedAgencyAppBarView(),
      ),
      body: const TopRatedAgencyListView().paddingOnly(top: 10, bottom: 10),
    );
  }
}
