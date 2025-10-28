import 'package:flutter/material.dart';
import 'package:handy/ui/purchase_package_screen/widget/purchase_package_widget.dart';
import 'package:handy/utils/app_color.dart';

class PurchasePackageScreen extends StatelessWidget {
  const PurchasePackageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: const PurchasePackageAppBarView(),
      ),
      bottomNavigationBar: const PurchasePackageBottomView(),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PurchasePackageImageView(),
          PurchasePackageDescriptionView(),
          PurchasePackageServiceTitleView(),
          PurchasePackageServiceListView(),
        ],
      ),
    );
  }
}
