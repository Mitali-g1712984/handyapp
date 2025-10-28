import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/custom/progress_indicator/progress_dialog.dart';
import 'package:handy/ui/edit_profile_screen/controller/edit_profile_controller.dart';
import 'package:handy/ui/edit_profile_screen/widget/edit_profile_widget.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/constant.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: Constant.storage.read("isMobileLogin") == true ? false : true,
      onPopInvoked: (bool didPop) {
        if (didPop) {
          return;
        }
      },
      child: GetBuilder<EditProfileController>(
        id: Constant.idEditCustomer,
        builder: (logic) {
          return ProgressDialog(
            inAsyncCall: logic.isLoading,
            child: Scaffold(
              backgroundColor: AppColors.white,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                flexibleSpace: const EditProfileAppBarView(),
              ),
              bottomNavigationBar: const EditProfileSavedButtonView(),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    const EditProfileImageView(),
                    Divider(height: 0.7, color: AppColors.profileDivider).paddingOnly(top: 12, bottom: 12),
                    const EditProfileAddDataView(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
