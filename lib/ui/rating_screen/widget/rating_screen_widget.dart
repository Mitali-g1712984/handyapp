import 'package:cached_network_image/cached_network_image.dart';
import 'package:handy/custom/app_bar/custom_app_bar.dart';
import 'package:handy/custom/no_data_found/no_data_found.dart';
import 'package:handy/ui/rating_screen/controller/rating_screen_controller.dart';
import 'package:handy/utils/api.dart';
import 'package:handy/utils/app_asset.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/constant.dart';
import 'package:handy/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:handy/utils/font_style.dart';
import 'package:get/get.dart';
import 'package:handy/utils/shimmers.dart';

import '../model/get_review_model.dart';

/// =================== App Bar =================== ///
class RatingAppBarView extends StatelessWidget {
  const RatingAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: EnumLocale.txtRatings.name.tr,
      showLeadingIcon: true,
    );
  }
}

/// =================== List View =================== ///
class RatingListView extends StatelessWidget {
  const RatingListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RatingScreenController>(
      id: Constant.idGetReview,
      builder: (logic) {
        return logic.isLoading
            ? Shimmers.reviewShimmer()
            : logic.getReviewModel?.reviewsOfProvider?.isEmpty == true
                ? NoDataFound(
                    image: AppAsset.icPlaceholderNoData,
                    imageHeight: 200,
                    text: EnumLocale.noDataFoundReview.name.tr,
                    padding: const EdgeInsets.only(top: 10),
                  ).paddingOnly(bottom: 40)
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: logic.getReviewModel?.reviewsOfProvider?.length ?? 0,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return RatingListItemView(
                        index: index,
                        reviewsOfProvider: logic.getReviewModel?.reviewsOfProvider?[index] ?? ReviewsOfProvider(),
                      );
                    },
                  ).paddingOnly(top: 12, bottom: 12);
      },
    );
  }
}

class RatingListItemView extends StatelessWidget {
  final int index;
  final ReviewsOfProvider reviewsOfProvider;

  const RatingListItemView({super.key, required this.index, required this.reviewsOfProvider});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RatingScreenController>(
      id: Constant.idGetReview,
      builder: (logic) {
        logic.rating = reviewsOfProvider.rating ?? 0.0;
        logic.roundedRating = logic.rating?.round();
        logic.filledStars = logic.roundedRating?.clamp(0, 5);

        return Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppColors.boxShadow.withOpacity(0.1),
                blurRadius: 0.3,
                spreadRadius: 0,
              ),
            ],
          ),
          margin: const EdgeInsets.only(bottom: 13, left: 15, right: 15),
          padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: AppColors.divider.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        imageUrl: "${ApiConstant.BASE_URL}${reviewsOfProvider.profileImage ?? ""}",
                        fit: BoxFit.cover,
                        placeholder: (context, url) {
                          return Image.asset(AppAsset.icPlaceholderProvider).paddingAll(10);
                        },
                        errorWidget: (context, url, error) {
                          return Image.asset(AppAsset.icPlaceholderProvider).paddingAll(10);
                        },
                      ),
                    ),
                  ).paddingOnly(right: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              reviewsOfProvider.name ?? "",
                              style: AppFontStyle.fontStyleW900(
                                fontSize: 16,
                                fontColor: AppColors.appButton,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.primaryAppColor1,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                                child: Text(
                                  reviewsOfProvider.time ?? "",
                                  style: AppFontStyle.fontStyleW700(
                                    fontSize: 12,
                                    fontColor: AppColors.appButton,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Get.height * 0.03,
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              if (index < logic.filledStars!) {
                                return Image.asset(AppAsset.icStarFilled, height: 18, width: 18).paddingOnly(right: 5);
                              } else {
                                return Image.asset(AppAsset.icStarOutline, height: 18, width: 18).paddingOnly(right: 5);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ).paddingOnly(bottom: 8),
              Text(
                reviewsOfProvider.review ?? "",
                style: AppFontStyle.fontStyleW400(
                  fontSize: 12,
                  fontColor: AppColors.description,
                ),
              ).paddingOnly(bottom: 8)
            ],
          ),
        );
      },
    );
  }
}
