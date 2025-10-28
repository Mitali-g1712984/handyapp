import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/custom/bottom_bar/salomon_bottom_bar.dart';
import 'package:handy/ui/bottom_bar/controller/bottom_bar_controller.dart';
import 'package:handy/utils/app_asset.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/constant.dart';

class BottomBarView extends StatelessWidget {
  const BottomBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomBarController>(
      id: Constant.idBottomBar,
      builder: (logic) {
        return Container(
          height: Platform.isIOS ? 85 : 65,
          decoration: BoxDecoration(
            color: AppColors.appButton,
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withOpacity(0.5),
                offset: const Offset(
                  6.0,
                  6.0,
                ),
                blurRadius: 6.0,
                spreadRadius: 2.0,
              ), //BoxShadow
            ],
          ),
          child: OverflowBox(
            maxHeight: double.infinity,
            maxWidth: double.infinity,
            child: SalomonBottomBar(
              currentIndex: logic.selectIndex,
              onTap: (value) async {
                logic.onClick(value);
              },
              curve: Curves.easeInOut,
              margin: EdgeInsets.only(left: 10, right: 10, top: Platform.isIOS ? 10 : 0),
              selectedColorOpacity: 1,
              items: [
                bottomBarItemView(
                  index: 0,
                  selectIndex: logic.selectIndex,
                  selectedImage: AppAsset.icHomeFilled,
                  unSelectedImage: AppAsset.icHomeOutline,
                ),
                bottomBarItemView(
                  index: 1,
                  selectIndex: logic.selectIndex,
                  selectedImage: AppAsset.icAppointmentFilled,
                  unSelectedImage: AppAsset.icAppointmentOutline,
                ),
                bottomBarItemView(
                  index: 2,
                  selectIndex: logic.selectIndex,
                  selectedImage: AppAsset.icChatFilled,
                  unSelectedImage: AppAsset.icChatOutline,
                ),
                bottomBarItemView(
                  index: 3,
                  selectIndex: logic.selectIndex,
                  selectedImage: AppAsset.icSaveFilled,
                  unSelectedImage: AppAsset.icSaveOutline,
                ),
                bottomBarItemView(
                  index: 4,
                  selectIndex: logic.selectIndex,
                  selectedImage: AppAsset.icProfileFilled,
                  unSelectedImage: AppAsset.icProfileOutline,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

SalomonBottomBarItem bottomBarItemView({
  required final int index,
  required final int selectIndex,
  required final String selectedImage,
  required final String unSelectedImage,
}) {
  return SalomonBottomBarItem(
    icon: selectIndex == index
        ? Image.asset(selectedImage, height: 25, width: 25)
        : Image.asset(unSelectedImage, height: 25, width: 25),
    selectedColor: AppColors.primaryAppColor1,
  );
}
