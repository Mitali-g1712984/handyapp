// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:handy/custom/app_bar/custom_app_bar.dart';
import 'package:handy/routes/app_routes.dart';
import 'package:handy/ui/home_screen/controller/home_screen_controller.dart';
import 'package:handy/ui/home_screen/model/get_top_rated_agency_model.dart';
import 'package:handy/utils/api.dart';
import 'package:handy/utils/app_asset.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/constant.dart';
import 'package:handy/utils/font_style.dart';
import 'package:handy/utils/shimmers.dart';

/// =================== Top Rated Agency App Bar =================== ///
class TopRatedAgencyAppBarView extends StatelessWidget {
  const TopRatedAgencyAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: "Top Rated Agency",
      showLeadingIcon: true,
    );
  }
}

/// =================== Top Rated Agency Listview =================== ///
class TopRatedAgencyListView extends StatelessWidget {
  const TopRatedAgencyListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
      id: Constant.idGetTopRatedAgency,
      builder: (logic) {
        return logic.isLoading
            ? Shimmers.homeTopRatedAgencyShimmer()
            : ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: logic.getTopRatedAgencyModel?.data?.length ?? 0,
                itemBuilder: (context, index) {
                  return AnimationConfiguration.staggeredGrid(
                    position: index,
                    duration: const Duration(milliseconds: 600),
                    columnCount: logic.getTopRatedAgencyModel?.data?.length ?? 0,
                    child: SlideAnimation(
                      child: FadeInAnimation(
                        child: TopRatedAgencyListItemView(
                          index: index,
                          getTopRatedAgencyData: logic.getTopRatedAgencyModel?.data?[index] ?? GetTopRatedAgencyData(),
                        ),
                      ),
                    ),
                  );
                },
              );
      },
    );
  }
}

class TopRatedAgencyListItemView extends StatelessWidget {
  final int index;
  final GetTopRatedAgencyData getTopRatedAgencyData;

  const TopRatedAgencyListItemView({
    super.key,
    required this.index,
    required this.getTopRatedAgencyData,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
      id: Constant.idGetTopRatedAgency,
      builder: (logic) {
        return GestureDetector(
          onTap: () {
            Get.toNamed(
              AppRoutes.agencyInfo,
              arguments: [
                AppColors.colorList[index % AppColors.colorList.length],
                AppColors.textColorList[index % AppColors.textColorList.length],
                getTopRatedAgencyData.id,
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
                      imageUrl: "${ApiConstant.BASE_URL}${getTopRatedAgencyData.profileImage ?? ""}",
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
                      Text(
                        "${getTopRatedAgencyData.firstName} ${getTopRatedAgencyData.lastName}",
                        style: AppFontStyle.fontStyleW900(
                          fontSize: 16,
                          fontColor: AppColors.appButton,
                        ),
                      ),
                      Container(
                        width: Get.width * 0.55,
                        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: AppColors.colorList[index % AppColors.colorList.length],
                        ),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            getTopRatedAgencyData.service?.map((service) => service.name).join(", ") ?? "",
                            style: AppFontStyle.fontStyleW600(
                              fontSize: 12,
                              fontColor: AppColors.textColorList[index % AppColors.textColorList.length],
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Image.asset(AppAsset.icStarFilled, height: 14),
                          Text(
                            "  ${getTopRatedAgencyData.avgRating?.toStringAsFixed(1)}",
                            style: AppFontStyle.fontStyleW800(
                              fontSize: 15,
                              fontColor: AppColors.rating,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                GetBuilder<HomeScreenController>(
                  id: Constant.idServiceSaved,
                  builder: (logic) {
                    return GestureDetector(
                      onTap: () {
                        logic.onFavouriteAgency(
                          customerId: Constant.storage.read("customerId"),
                          agencyId: getTopRatedAgencyData.id ?? "",
                        );
                      },
                      child: logic.isFavouriteAgency[index] == true
                          ? Image.asset(AppAsset.icSavedFilled, height: 22)
                          : Image.asset(AppAsset.icSavedOutline, height: 22),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
