import 'package:flutter/material.dart';
import 'package:handy/ui/service_wise_agency_screen/widget/service_wise_agency_widget.dart';
import 'package:handy/utils/app_color.dart';

class ServiceWiseAgencyScreen extends StatelessWidget {
  const ServiceWiseAgencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: const ServiceWiseAgencyAppBarView(),
      ),
      body: const Column(
        children: [
          ServiceWiseAgencyTitleView(),
          Expanded(child: ServiceWiseAgencyListView()),
        ],
      ),
    );
  }
}
