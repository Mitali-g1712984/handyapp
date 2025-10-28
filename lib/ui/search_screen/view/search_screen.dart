import 'package:get/get.dart';
import 'package:handy/custom/progress_indicator/progress_dialog.dart';
import 'package:handy/ui/search_screen/controller/search_screen_controller.dart';
import 'package:handy/ui/search_screen/widget/search_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/constant.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: GetBuilder<SearchScreenController>(
        id: Constant.idGetFilterWiseAgency,
        builder: (logic) {
          return ProgressDialog(
            inAsyncCall: logic.isLoading,
            child: Column(
              children: [
                const SearchTopBarView().paddingOnly(top: 20),
                const SearchListView(),
              ],
            ),
          );
        },
      ),
    );
  }
}
