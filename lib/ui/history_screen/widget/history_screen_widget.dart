import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:handy/custom/app_bar/custom_app_bar.dart';
import 'package:handy/custom/no_data_found/no_data_found.dart';
import 'package:handy/ui/history_screen/controller/history_screen_controller.dart';
import 'package:handy/ui/history_screen/model/get_wallet_history_model.dart';
import 'package:handy/utils/app_asset.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/constant.dart';
import 'package:handy/utils/enums.dart';
import 'package:handy/utils/font_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/utils/shimmers.dart';

/// =================== App Bar =================== ///
class HistoryAppBarView extends StatelessWidget {
  const HistoryAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: EnumLocale.txtWalletHistory.name.tr,
      showLeadingIcon: true,
    );
  }
}

/// =================== Title =================== ///
class HistoryTitleView extends StatelessWidget {
  const HistoryTitleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              EnumLocale.txtPaymentHistory.name.tr,
              style: AppFontStyle.fontStyleW900(
                fontSize: 16,
                fontColor: AppColors.appButton,
              ),
            ),
            GetBuilder<HistoryScreenController>(
              id: Constant.idSelectMonth,
              builder: (logic) {
                return GestureDetector(
                  onTap: () {
                    logic.onClickMonth();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.divider,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                    child: Row(
                      children: [
                        Text(
                          logic.selectedMonth.toString(),
                          style: AppFontStyle.fontStyleW700(
                            fontSize: 12,
                            fontColor: AppColors.tabUnselectText,
                          ),
                        ).paddingOnly(right: 5),
                        Image.asset(
                          AppAsset.icArrowDown,
                          height: 15,
                          color: AppColors.tabUnselectText,
                        )
                      ],
                    ),
                  ),
                );
              },
            )
          ],
        )
      ],
    ).paddingOnly(top: 15, left: 15, right: 15);
  }
}

/// =================== List View =================== ///
class HistoryListView extends StatelessWidget {
  const HistoryListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HistoryScreenController>(
      id: Constant.idGetWalletHistory,
      builder: (logic) {
        return logic.getWalletHistory.isEmpty
            ? logic.isLoading
                ? Shimmers.walletHistoryShimmer()
                : NoDataFound(
                    image: AppAsset.icNoDataAppointment,
                    imageHeight: 150,
                    text: EnumLocale.noDataFoundWalletHistory.name.tr,
                    padding: const EdgeInsets.only(top: 7),
                  )
            : RefreshIndicator(
                onRefresh: () => logic.onWalletHistoryRefresh(),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: logic.getWalletHistory.length,
                        controller: logic.scrollController,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return AnimationConfiguration.staggeredGrid(
                            position: index,
                            duration: const Duration(milliseconds: 800),
                            columnCount: logic.getWalletHistory.length,
                            child: SlideAnimation(
                              child: FadeInAnimation(
                                child: HistoryListItemView(
                                  index: index,
                                  getWalletHistoryData: logic.getWalletHistory[index],
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

class HistoryListItemView extends StatelessWidget {
  final int index;
  final GetWalletHistoryData getWalletHistoryData;

  const HistoryListItemView({super.key, required this.index, required this.getWalletHistoryData});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      width: Get.width,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(width: 0.8, color: AppColors.divider),
      ),
      padding: const EdgeInsets.only(left: 7, right: 10),
      margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
      child: Row(
        children: [
          Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              color: getWalletHistoryData.type == 1 ? AppColors.walletAddBox : AppColors.redBox1,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.asset(getWalletHistoryData.type == 1 ? AppAsset.icWalletAdd : AppAsset.icWalletMinus).paddingAll(7),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                getWalletHistoryData.type == 1 ? EnumLocale.txtAddWallet.name.tr : "Pay to agency",
                style: AppFontStyle.fontStyleW900(
                  fontSize: 14,
                  fontColor: getWalletHistoryData.type == 1 ? AppColors.primaryAppColor1 : AppColors.redBox,
                ),
              ),
              Text(
                getWalletHistoryData.uniqueId ?? "",
                style: AppFontStyle.fontStyleW700(
                  fontSize: 12,
                  fontColor: AppColors.categoryText,
                ),
              ),
              Text(
                "${getWalletHistoryData.date ?? ""}  ${getWalletHistoryData.time?.toUpperCase() ?? ""}",
                style: AppFontStyle.fontStyleW600(
                  fontSize: 11,
                  fontColor: AppColors.viewAll,
                ),
              ),
            ],
          ).paddingOnly(top: 10, bottom: 10, left: 10),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: getWalletHistoryData.type == 1 ? AppColors.walletAddBox : AppColors.redBox1,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              getWalletHistoryData.type == 1 ? "+ ${getWalletHistoryData.amount}" : "- ${getWalletHistoryData.amount}",
              style: AppFontStyle.fontStyleW900(
                fontSize: 16,
                fontColor: getWalletHistoryData.type == 1 ? AppColors.primaryAppColor1 : AppColors.redBox,
              ),
            ),
          )
        ],
      ),
    );
  }
}
