import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:handy/custom/app_bar/custom_app_bar.dart';
import 'package:handy/custom/no_data_found/no_data_found.dart';
import 'package:handy/ui/help_desk_history_screen/controller/help_desk_history_controller.dart';
import 'package:handy/ui/help_desk_history_screen/model/get_complain_model.dart';
import 'package:handy/utils/app_asset.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/constant.dart';
import 'package:handy/utils/enums.dart';
import 'package:handy/utils/font_style.dart';
import 'package:handy/utils/shimmers.dart';

class HelpDeskHistoryAppBarView extends StatelessWidget {
  const HelpDeskHistoryAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: EnumLocale.txtHistory.name.tr,
      showLeadingIcon: true,
    );
  }
}

/// =================== List View =================== ///
class HelpDeskHistoryListView extends StatelessWidget {
  const HelpDeskHistoryListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HelpDeskHistoryController>(
      id: Constant.idGetComplain,
      builder: (logic) {
        return logic.getComplain.isEmpty
            ? logic.isLoading
                ? Shimmers.helpDeskHistoryShimmer()
                : NoDataFound(
                    image: AppAsset.icNoDataAppointment,
                    imageHeight: 150,
                    text: EnumLocale.noDataFoundComplain.name.tr,
                    padding: const EdgeInsets.only(top: 7),
                  )
            : RefreshIndicator(
                onRefresh: () => logic.onRefresh(),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: logic.getComplain.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return AnimationConfiguration.staggeredGrid(
                            position: index,
                            duration: const Duration(milliseconds: 800),
                            columnCount: 7,
                            child: SlideAnimation(
                              child: FadeInAnimation(
                                child: HelpDeskHistoryListItemView(
                                  getComplainData: logic.getComplain[index],
                                ),
                              ),
                            ),
                          );
                        },
                      ).paddingOnly(bottom: 15),
                    ),
                    logic.isLoading1
                        ? CircularProgressIndicator(
                            color: AppColors.primaryAppColor1,
                          ).paddingOnly(bottom: 10)
                        : const SizedBox()
                  ],
                ),
              );
      },
    );
  }
}

class HelpDeskHistoryListItemView extends StatelessWidget {
  final GetComplainData getComplainData;

  const HelpDeskHistoryListItemView({super.key, required this.getComplainData});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HelpDeskHistoryController>(
      builder: (logic) {
        return Container(
          height: 65,
          width: Get.width,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(width: 0.7, color: AppColors.divider),
          ),
          padding: const EdgeInsets.only(left: 8, right: 10),
          margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
          child: Row(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: AppColors.historyBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Image.asset(
                  AppAsset.icComplain,
                ).paddingAll(10),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          getComplainData.type == 1 ? EnumLocale.txtComplain.name.tr : EnumLocale.txtSuggestion.name.tr,
                          style: AppFontStyle.fontStyleW900(
                            fontSize: 17,
                            fontColor: AppColors.appButton,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.walletAddBox,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 10,
                                width: 10,
                                decoration: BoxDecoration(
                                  color: AppColors.primaryAppColor1,
                                  shape: BoxShape.circle,
                                ),
                              ).paddingOnly(right: 10),
                              Text(
                                getComplainData.status == 1 ? EnumLocale.txtPending.name.tr : EnumLocale.txtSloved.name.tr,
                                style: AppFontStyle.fontStyleW700(
                                  fontSize: 10,
                                  fontColor: AppColors.primaryAppColor1,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              AppAsset.icAppointmentOutline,
                              height: 18,
                              width: 18,
                              color: AppColors.categoryText,
                            ).paddingOnly(right: 3),
                            Text(
                              logic.formatedDate(getComplainData.date ?? ""),
                              style: AppFontStyle.fontStyleW700(
                                fontSize: 12,
                                fontColor: AppColors.categoryText,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Image.asset(
                              AppAsset.icClock,
                              height: 18,
                              width: 18,
                              color: AppColors.categoryText,
                            ).paddingOnly(right: 3, left: 15),
                            Text(
                              logic.formatedTime(getComplainData.date ?? ""),
                              style: AppFontStyle.fontStyleW700(
                                fontSize: 12,
                                fontColor: AppColors.categoryText,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ).paddingOnly(top: 10, bottom: 10, left: 10),
              ),
            ],
          ),
        );
      },
    );
  }
}
