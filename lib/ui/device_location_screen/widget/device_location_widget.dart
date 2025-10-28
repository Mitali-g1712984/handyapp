import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/custom/app_bar/custom_app_bar.dart';
import 'package:handy/custom/map/choose_map_screen.dart';
import 'package:handy/ui/device_location_screen/controller/device_location_controller.dart';
import 'package:handy/utils/app_asset.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/font_style.dart';

/// =================== App Bar =================== ///
class DeviceLocationAppBarView extends StatelessWidget {
  const DeviceLocationAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: "Select Location",
      showLeadingIcon: false,
    );
  }
}

class DeviceLocationSearchLocationView extends StatelessWidget {
  const DeviceLocationSearchLocationView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          const ChooseMapScreen(
            isDirect: true,
          ),
        );
      },
      child: Container(
        height: 50,
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.searchBox,
          border: Border.all(
            color: AppColors.appButton.withOpacity(0.1),
            width: 0.8,
          ),
        ),
        child: Row(
          children: [
            Image.asset(AppAsset.icSearch, height: 20).paddingOnly(left: 10, right: 5),
            VerticalDivider(
              endIndent: 13,
              indent: 13,
              thickness: 1.5,
              color: AppColors.appButton,
            ),
            Text(
              "Search your Location",
              style: AppFontStyle.fontStyleW600(
                fontSize: 17,
                fontColor: AppColors.appButton,
              ),
            ).paddingOnly(left: 5),
          ],
        ),
      ).paddingAll(15),
    );
  }
}

class DeviceLocationMiddleView extends StatelessWidget {
  const DeviceLocationMiddleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          AppAsset.imLocationOff,
          height: 120,
        ),
        const SizedBox(height: 20),
        Text(
          "Your device location is off",
          style: AppFontStyle.fontStyleW800(
            fontSize: 20,
            fontColor: AppColors.appButton,
          ),
        ),
        Text(
          "Turn on your GPS to get your current location",
          style: AppFontStyle.fontStyleW500(
            fontSize: 15,
            fontColor: AppColors.appButton.withOpacity(0.5),
          ),
        ),
        const SizedBox(height: 20),
        GetBuilder<DeviceLocationController>(builder: (logic) {
          return GestureDetector(
            onTap: () {
              logic.checkPermissionAndGetLocation();
            },
            child: Container(
              height: 50,
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.appButton,
                border: Border.all(
                  color: AppColors.appButton.withOpacity(0.1),
                  width: 0.8,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.my_location,
                    size: 25,
                    color: AppColors.primaryAppColor1,
                  ).paddingOnly(left: 10, right: 5),
                  Text(
                    "Current Location",
                    style: AppFontStyle.fontStyleW600(
                      fontSize: 17,
                      fontColor: AppColors.primaryAppColor1,
                    ),
                  ).paddingOnly(left: 5),
                ],
              ),
            ).paddingOnly(left: 15, right: 15),
          );
        }),
      ],
    );
  }
}
