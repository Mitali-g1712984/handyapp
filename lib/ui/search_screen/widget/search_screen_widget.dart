import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:handy/custom/bottom_sheet/search_filter_bottom_sheet.dart';
import 'package:handy/custom/no_data_found/no_data_found.dart';
import 'package:handy/custom/text_field/custom_text_field.dart';
import 'package:handy/routes/app_routes.dart';
import 'package:handy/ui/search_screen/controller/search_screen_controller.dart';
import 'package:handy/utils/api.dart';
import 'package:handy/utils/app_asset.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/constant.dart';
import 'package:handy/utils/enums.dart';
import 'package:handy/utils/font_style.dart';
import 'package:handy/utils/shimmers.dart';

List genderList = [(EnumLocale.txtFemale.name.tr), (EnumLocale.txtMale.name.tr), (EnumLocale.txtBoth.name.tr)];

/// =================== Top Search Bar =================== ///
class SearchTopBarView extends StatelessWidget {
  const SearchTopBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Image.asset(
            AppAsset.icArrowRight,
            height: 24,
            color: AppColors.appButton,
          ).paddingAll(10),
        ),
        Expanded(
          child: GetBuilder<SearchScreenController>(
            builder: (logic) {
              return CustomTextField(
                hintText: "Search for services, agencies...",
                controller: logic.searchController,
                fillColor: AppColors.divider,
                hintTextSize: 15,
                hintTextColor: AppColors.appButton,
                fontColor: AppColors.appButton,
                filled: true,
                prefixIcon: Image.asset(
                  AppAsset.icSearch,
                  height: 10,
                ).paddingAll(12),
                suffixIcon: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (BuildContext context) {
                        return const SearchFilterBottomSheet();
                      },
                    );
                  },
                  child: Image.asset(
                    AppAsset.icCategory,
                    height: 10,
                    width: 10,
                  ).paddingAll(12),
                ),
                onChanged: (text) {
                  logic.searchBy(text: text ?? "");
                  return null;
                },
              ).paddingOnly(right: 10, top: 10, bottom: 10);
            },
          ),
        ),
      ],
    );
  }
}

/// =================== List View =================== ///
class SearchListView extends StatelessWidget {
  const SearchListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchScreenController>(
      id: Constant.idGetFilterWiseAgency,
      builder: (logic) {
        return logic.getAllSearchAgency.isEmpty
            ? logic.isLoading
                ? Shimmers.homeTopRatedAgencyShimmer()
                : NoDataFound(
                    image: AppAsset.icNoDataAppointment,
                    imageHeight: 150,
                    text: EnumLocale.noDataFoundSearch.name.tr,
                    padding: const EdgeInsets.only(top: 7),
                  ).paddingOnly(top: Get.height * 0.25)
            : Expanded(
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: logic.getAllSearchAgency.length,
                  itemBuilder: (context, index) {
                    return AnimationConfiguration.staggeredGrid(
                      position: index,
                      duration: const Duration(milliseconds: 800),
                      columnCount: logic.getAllSearchAgency.length,
                      child: SlideAnimation(
                        child: FadeInAnimation(
                          child: SearchListItemView(index: index),
                        ),
                      ),
                    );
                  },
                ),
              );
      },
    );
  }
}

class SearchListItemView extends StatelessWidget {
  final int index;

  const SearchListItemView({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchScreenController>(
      id: Constant.idGetFilterWiseAgency,
      builder: (logic) {
        return GestureDetector(
          onTap: () {
            Get.toNamed(
              AppRoutes.agencyInfo,
              arguments: [
                AppColors.colorList[index % AppColors.colorList.length],
                AppColors.textColorList[index % AppColors.textColorList.length],
                logic.getAllSearchAgency[index].id,
                "",
                "",
                "",
                index,
              ],
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: AppColors.divider,
                width: 0.4,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.boxShadow.withOpacity(0.1),
                  blurRadius: 0.3,
                  spreadRadius: 0,
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 7),
            margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.divider.withOpacity(0.5),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl: "${ApiConstant.BASE_URL}${logic.getAllSearchAgency[index].profileImage ?? ""}",
                      fit: BoxFit.cover,
                      placeholder: (context, url) {
                        return Image.asset(AppAsset.icPlaceholderProvider).paddingAll(10);
                      },
                      errorWidget: (context, url, error) {
                        return Image.asset(AppAsset.icPlaceholderProvider).paddingAll(10);
                      },
                    ),
                  ),
                ),
                SizedBox(width: Get.width * 0.02),
                SizedBox(
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 1),
                      Text(
                        "${logic.getAllSearchAgency[index].firstName} ${logic.getAllSearchAgency[index].lastName}",
                        style: AppFontStyle.fontStyleW900(
                          fontSize: 16,
                          fontColor: AppColors.appButton,
                        ),
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: Get.width * 0.55,
                        ),
                        child: IntrinsicWidth(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: AppColors.colorList[index % AppColors.colorList.length],
                            ),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text(
                                logic.getAllSearchAgency[index].service?.map((service) => service.name).join(", ") ?? "",
                                style: AppFontStyle.fontStyleW600(
                                  fontSize: 12,
                                  fontColor: AppColors.textColorList[index % AppColors.textColorList.length],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Image.asset(AppAsset.icStarFilled, height: 14),
                          Text(
                            "  ${logic.getAllSearchAgency[index].avgRating?.toStringAsFixed(1)}",
                            style: AppFontStyle.fontStyleW800(
                              fontSize: 15,
                              fontColor: AppColors.rating,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 1),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
