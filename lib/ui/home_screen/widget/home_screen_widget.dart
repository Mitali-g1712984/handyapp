import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:handy/custom/bottom_sheet/upcoming_appointment_bottom_sheet.dart';
import 'package:handy/custom/map/choose_map_screen.dart';
import 'package:handy/custom/title/custom_main_title.dart';
import 'package:handy/custom/view_all_text/view_all.dart';
import 'package:handy/routes/app_routes.dart';
import 'package:handy/ui/home_screen/controller/home_screen_controller.dart';
import 'package:handy/ui/home_screen/model/get_service_model.dart';
import 'package:handy/ui/home_screen/model/get_top_rated_agency_model.dart';
import 'package:handy/utils/api.dart';
import 'package:handy/utils/app_asset.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/constant.dart';
import 'package:handy/utils/enums.dart';
import 'package:handy/utils/font_style.dart';
import 'package:handy/utils/global_variables.dart';
import 'package:handy/utils/shimmers.dart';
import 'package:handy/utils/utils.dart';
import 'package:scroll_page_view/scroll_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

/// =================== Top View =================== ///
class HomeTopView extends StatelessWidget {
  const HomeTopView({super.key});

  @override
  Widget build(BuildContext context) {
    final String customerImage = (Constant.storage.read("customerImage") ?? "").toString();
    final String customerImageUrl = customerImage.isNotEmpty ? "${ApiConstant.BASE_URL}$customerImage" : "";

    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryAppColor1,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // prevents forcing a large height (fix overflow)
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 18, left: 15, right: 15, bottom: 8),
            child: Row(
              children: [
                // Avatar
                Container(
                  height: 52,
                  width: 52,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.white,
                    boxShadow: const [
                      BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
                    ],
                  ),
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: customerImageUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Image.asset(AppAsset.icPlaceholderImage).paddingAll(10),
                      errorWidget: (context, url, error) => Image.asset(AppAsset.icPlaceholderImage).paddingAll(10),
                    ),
                  ),
                ).paddingOnly(right: 12),

                // Name & Address
                Expanded(
                  child: GetBuilder<HomeScreenController>(
                    id: Constant.idGetLocation,
                    builder: (logic) {
                      final String name = (Constant.storage.read("customerName") ?? "").toString();
                      final String address = (Constant.storage.read("userAddress") ?? "").toString();

                      return GestureDetector(
                        onTap: () {
                          Get.to(
                            const ChooseMapScreen(isDirect: false),
                          )?.then((_) => logic.onRefreshData());
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${EnumLocale.txtHello.name.tr} ${name}',
                              style: AppFontStyle.fontStyleW800(
                                fontSize: 18,
                                fontColor: AppColors.white,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (address.isNotEmpty)
                              Row(
                                children: [
                                  Image.asset(AppAsset.icLocation, height: 14, color: AppColors.white).paddingOnly(right: 6),
                                  Flexible(
                                    child: Text(
                                      address,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppFontStyle.fontStyleW400(
                                        fontSize: 13,
                                        fontColor: AppColors.white.withOpacity(0.95),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // Notification Icon
                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.notification);
                  },
                  child: Container(
                    height: 46,
                    width: 46,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Image.asset(AppAsset.icNotification),
                  ),
                ),
              ],
            ),
          ),

          // Search view (kept as original visual, but space optimized)
          const HomeSearchView().paddingOnly(left: 15, right: 15, bottom: 14),
        ],
      ),
    );
  }
}

/// =================== Upcoming Appointment =================== ///
class MyAppointmentTitleView extends StatelessWidget {
  const MyAppointmentTitleView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
      id: Constant.idGetUpcomingAppointment,
      builder: (logic) {
        return CustomMainTitle(
          title: EnumLocale.txtUpcomingAppointment.name.tr,
          method: GestureDetector(
            onTap: () => Get.toNamed(AppRoutes.upcomingAppointment),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
              decoration: BoxDecoration(
                color: AppColors.primaryAppColor1,
                borderRadius: BorderRadius.circular(7),
              ),
              child: const ViewAllTitle(),
            ),
          ),
        ).paddingOnly(left: 15, right: 15, top: 12, bottom: 8);
      },
    );
  }
}

class MyAppointmentItemView extends StatelessWidget {
  const MyAppointmentItemView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
      id: Constant.idGetUpcomingAppointment,
      builder: (logic) {
        final int itemCount = (logic.getUpcomingAppointmentModel?.data?.length ?? 0) > 5 ? 5 : (logic.getUpcomingAppointmentModel?.data?.length ?? 0);

        return SizedBox(
          height: 200,
          child: logic.isLoading
              ? Shimmers.upcomingAppointmentShimmer()
              : PageView.builder(
                  itemCount: itemCount,
                  controller: logic.pageController,
                  itemBuilder: (context, index) {
                    final item = logic.getUpcomingAppointmentModel?.data?[index];
                    final provider = item?.provider;
                    final providerImage = (provider?.profileImage ?? "").toString();
                    final providerImageUrl = providerImage.isNotEmpty ? "${ApiConstant.BASE_URL}$providerImage" : "";

                    return GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (BuildContext context) {
                            return UpcomingAppointmentBottomSheet(
                              profileImage: provider?.profileImage ?? "",
                              providerName: provider?.name ?? "",
                              serviceName: item?.service?.name ?? "",
                              serviceProviderFee: (item?.serviceProviderFee ?? "").toString(),
                              rating: provider?.avgRating?.toStringAsFixed(1) ?? "",
                              time: item?.time ?? "",
                              date: item?.date ?? "",
                              providerId: provider?.id ?? "",
                              appointmentUniqueId: item?.appointmentId ?? "",
                              appointmentId: item?.id ?? "",
                              isViewAll: false,
                            );
                          },
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: AppColors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
                          ],
                          border: Border.all(color: AppColors.serviceBorder, width: 0.8),
                        ),
                        child: Column(
                          children: [
                            // Top Row of card
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Provider Image
                                  Container(
                                    height: 92,
                                    width: 92,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: AppColors.divider.withOpacity(0.5),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: CachedNetworkImage(
                                        imageUrl: providerImageUrl,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => Image.asset(AppAsset.icPlaceholderProvider).paddingAll(10),
                                        errorWidget: (context, url, error) => Image.asset(AppAsset.icPlaceholderProvider).paddingAll(10),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: Get.width * 0.03),

                                  // Details
                                  Expanded(
                                    child: SizedBox(
                                      height: 92,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            provider?.name ?? "",
                                            style: AppFontStyle.fontStyleW900(
                                              fontSize: 16,
                                              fontColor: AppColors.appButton,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),

                                          // Service tag
                                          Container(
                                            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(6),
                                              color: AppColors.colorList[index % AppColors.colorList.length],
                                            ),
                                            child: Text(
                                              item?.service?.name ?? "",
                                              style: AppFontStyle.fontStyleW600(
                                                fontSize: 12,
                                                fontColor: AppColors.textColorList[index % AppColors.textColorList.length],
                                              ),
                                            ),
                                          ),

                                          // Fee
                                          Text(
                                            "$currency ${item?.serviceProviderFee ?? ""}",
                                            style: AppFontStyle.fontStyleW800(
                                              fontSize: 16,
                                              fontColor: AppColors.primaryAppColor1,
                                            ),
                                          ),

                                          // Rating
                                          Row(
                                            children: [
                                              Image.asset(AppAsset.icStarFilled, height: 14),
                                              const SizedBox(width: 6),
                                              Text(
                                                provider?.avgRating?.toStringAsFixed(1) ?? "0.0",
                                                style: AppFontStyle.fontStyleW800(
                                                  fontSize: 14,
                                                  fontColor: AppColors.rating,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  // Appointment id small box
                                  Container(
                                    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: AppColors.divider,
                                    ),
                                    child: Text(
                                      item?.appointmentId ?? "",
                                      style: AppFontStyle.fontStyleW600(
                                        fontSize: 12,
                                        fontColor: AppColors.tabUnselectText,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Bottom Row : Time & Date
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.divider,
                                borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundColor: AppColors.primaryAppColor1,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(AppAsset.icAppointmentFilled, color: AppColors.white),
                                    ),
                                  ).paddingOnly(right: 12),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item?.time ?? "",
                                        style: AppFontStyle.fontStyleW900(fontSize: 14, fontColor: AppColors.appButton),
                                      ),
                                      Text(
                                        EnumLocale.txtBookingTiming.name.tr,
                                        style: AppFontStyle.fontStyleW600(fontSize: 12, fontColor: AppColors.categoryText),
                                      )
                                    ],
                                  ),
                                  const Spacer(),
                                  Container(height: 36, width: 2, color: AppColors.serviceBorder),
                                  const Spacer(),
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundColor: AppColors.primaryAppColor1,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(AppAsset.icClock),
                                    ),
                                  ).paddingOnly(right: 12),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item?.date ?? "",
                                        style: AppFontStyle.fontStyleW900(fontSize: 14, fontColor: AppColors.appButton),
                                      ),
                                      Text(
                                        EnumLocale.txtBookingDate.name.tr,
                                        style: AppFontStyle.fontStyleW600(fontSize: 12, fontColor: AppColors.categoryText),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    );
                    },
                ),
        );
      },
    );
  }
}

class MyAppointmentIndicator extends StatelessWidget {
  const MyAppointmentIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
      id: Constant.idGetUpcomingAppointment,
      builder: (logic) {
        final count = (logic.getUpcomingAppointmentModel?.data?.length ?? 0) > 5 ? 5 : (logic.getUpcomingAppointmentModel?.data?.length ?? 0);
        return logic.isLoading || count == 0
            ? const SizedBox()
            : Center(
                child: SmoothPageIndicator(
                  controller: logic.pageController,
                  count: count,
                  effect: SwapEffect(
                    spacing: 8,
                    radius: 6,
                    dotWidth: 10,
                    dotHeight: 10,
                    paintStyle: PaintingStyle.fill,
                    strokeWidth: 1.2,
                    dotColor: Colors.grey.shade300,
                    activeDotColor: AppColors.primaryAppColor1,
                  ),
                ).paddingOnly(top: 8),
              );
      },
    );
  }
}

/// =================== Search =================== ///
class HomeSearchView extends StatelessWidget {
  const HomeSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.search),
      child: Container(
        height: 47,
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.searchBox,
          boxShadow: [BoxShadow(color: Colors.black12.withOpacity(0.02), blurRadius: 6)],
        ),
        child: Row(
          children: [
            Image.asset(AppAsset.icSearch, height: 20).paddingOnly(left: 10, right: 8),
            VerticalDivider(endIndent: 13, indent: 13, thickness: 1.25, color: AppColors.appButton.withOpacity(0.25)),
            Text(
              EnumLocale.txtFindOurServices.name.tr,
              style: AppFontStyle.fontStyleW600(fontSize: 15, fontColor: AppColors.appButton),
            ).paddingOnly(left: 6),
            const Spacer(),
            Image.asset(AppAsset.icCategory, height: 20).paddingOnly(right: 10),
          ],
        ),
      ).paddingOnly(left: 15, right: 15, top: 5, bottom: 10),
    );
  }
}

/// =================== Banner =================== ///
class HomeBannerTitleView extends StatelessWidget {
  const HomeBannerTitleView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomMainTitle(title: EnumLocale.txtSpecialOffers.name.tr, method: const SizedBox()).paddingOnly(left: 15, bottom: 6, top: 12);
  }
}

class HomeBannerView extends StatelessWidget {
  const HomeBannerView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
      id: Constant.idGetBanner,
      builder: (logic) {
        logic.bannersImages = logic.getBannerModel?.data?.map((item) => item.image).toList();
        logic.type = logic.getBannerModel?.data?.map((item) => item.type).toList();

        final banners = logic.bannersImages ?? [];

        if (banners.isEmpty) return const SizedBox.shrink();
        if (logic.isLoading) return Shimmers.homeBannerShimmer();

        return Container(
          height: Get.height * 0.24,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(14), color: AppColors.divider),
          child: ScrollPageView(
            controller: ScrollPageController(),
            indicatorColor: AppColors.bannerIndicator,
            checkedIndicatorColor: AppColors.primaryAppColor1,
            indicatorAlign: Alignment.bottomCenter,
            indicatorPadding: const EdgeInsets.all(6),
            indicatorRadius: 8,
            duration: const Duration(milliseconds: 1400),
            children: banners.asMap().entries.map((entry) {
              final int index = entry.key;
              final String image = entry.value ?? "";
              final imageUrl = image.isNotEmpty ? "${ApiConstant.BASE_URL}$image" : "";

              return GestureDetector(
                onTap: () {
                  if (logic.type != null && logic.type!.isNotEmpty && index < logic.type!.length) {
                    if (logic.type?[index] == 2) {
                      Utils.launchURL(logic.getBannerModel?.data?[index].url ?? "");
                    } else if (logic.type?[index] == 1) {
                      Get.toNamed(AppRoutes.serviceWiseAgency, arguments: [
                        logic.getBannerModel?.data?[index].service?.name,
                        logic.getBannerModel?.data?[index].service?.id,
                        AppColors.colorList[index % AppColors.colorList.length],
                        AppColors.textColorList[index % AppColors.textColorList.length],
                        index,
                      ]);
                    }
                  }
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.cover,
                    placeholder: (c, u) => Shimmers.homeBannerShimmer(),
                    errorWidget: (c, u, e) => Container(color: AppColors.divider),
                  ),
                ),
              );
            }).toList(),
          ),
        ).paddingOnly(left: 12, right: 12);
      },
    );
  }
}

/// =================== Category =================== ///
class HomeCategoryTitleView extends StatelessWidget {
  const HomeCategoryTitleView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomMainTitle(
      title: EnumLocale.txtOurServices.name.tr,
      method: GestureDetector(
        onTap: () => Get.toNamed(AppRoutes.category),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          decoration: BoxDecoration(color: AppColors.primaryAppColor1, borderRadius: BorderRadius.circular(7)),
          child: const ViewAllTitle(),
        ),
      ),
    ).paddingOnly(left: 15, right: 15, top: 12, bottom: 8);
  }
}

class HomeCategoryView extends StatelessWidget {
  const HomeCategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
      id: Constant.idGetService,
      builder: (logic) {
        if (logic.isLoading) return Shimmers.homeServiceShimmer();

        final items = logic.getServiceModel?.data ?? [];

        return GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: items.length > 8 ? 8 : items.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 0.62,
            crossAxisSpacing: 12,
            mainAxisSpacing: 6,
          ),
          itemBuilder: (context, index) {
            return AnimationConfiguration.staggeredGrid(
              position: index,
              duration: const Duration(milliseconds: 500),
              columnCount: items.length > 8 ? 8 : items.length,
              child: ScaleAnimation(
                child: FadeInAnimation(
                  child: HomeCategoryItemView(
                    index: index,
                    getServiceData: items[index] ?? GetServiceData(),
                  ),
                ),
              ),
            );
          },
        ).paddingOnly(left: 11, right: 11, top: 6);
      },
    );
  }
}

class HomeCategoryItemView extends StatelessWidget {
  final int index;
  final GetServiceData getServiceData;

  const HomeCategoryItemView({super.key, required this.index, required this.getServiceData});

  @override
  Widget build(BuildContext context) {
    final img = (getServiceData.image ?? "").toString();
    final imageUrl = img.isNotEmpty ? "${ApiConstant.BASE_URL}$img" : "";

    return GetBuilder<HomeScreenController>(
      id: Constant.idGetService,
      builder: (logic) {
        return SizedBox(
          height: Get.height * 0.15,
          child: GestureDetector(
            onTap: () => Get.toNamed(AppRoutes.serviceWiseAgency, arguments: [
              getServiceData.name,
              getServiceData.id,
              AppColors.colorList[index % AppColors.colorList.length],
              AppColors.textColorList[index % AppColors.textColorList.length],
              index,
            ]),
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: AppColors.white,
                border: Border.all(color: AppColors.serviceBorder, width: 0.8),
                boxShadow: [BoxShadow(color: Colors.black12.withOpacity(0.03), blurRadius: 6, offset: Offset(0, 2))],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: Get.width * 0.17,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.colorList[index % AppColors.colorList.length],
                    ),
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.contain,
                      placeholder: (c, u) => Image.asset(AppAsset.icPlaceholderService).paddingAll(2),
                      errorWidget: (c, u, e) => Image.asset(AppAsset.icPlaceholderService).paddingAll(2),
                    ),
                  ).paddingOnly(top: 8),
                  const SizedBox(height: 6),
                  Flexible(
                    child: SizedBox(
                      width: Get.width * 0.15,
                      child: Center(
                        child: Text(
                          getServiceData.name ?? "",
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: AppFontStyle.fontStyleW700(fontSize: 12, fontColor: AppColors.categoryText),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

/// =================== Top Rated Agency =================== ///
class HomeTopRatedTitleView extends StatelessWidget {
  const HomeTopRatedTitleView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomMainTitle(
      title: "Top Rated Agency",
      method: GestureDetector(
        onTap: () => Get.toNamed(AppRoutes.topRatedAgency),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          decoration: BoxDecoration(color: AppColors.primaryAppColor1, borderRadius: BorderRadius.circular(7)),
          child: const ViewAllTitle(),
        ),
      ),
    ).paddingOnly(left: 15, right: 15, bottom: 10, top: 10);
  }
}

class HomeTopRatedListView extends StatelessWidget {
  const HomeTopRatedListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
      id: Constant.idGetTopRatedAgency,
      builder: (logic) {
        if (logic.isLoading) return Shimmers.homeTopRatedAgencyShimmer();

        final items = logic.getTopRatedAgencyModel?.data ?? [];

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: items.length > 7 ? 7 : items.length,
          itemBuilder: (context, index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 600),
              child: SlideAnimation(
                child: FadeInAnimation(
                  child: HomeTopRatedListItemView(
                    index: index,
                    getTopRatedAgencyData: items[index] ?? GetTopRatedAgencyData(),
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

class HomeTopRatedListItemView extends StatelessWidget {
  final int index;
  final GetTopRatedAgencyData getTopRatedAgencyData;

  const HomeTopRatedListItemView({
    super.key,
    required this.index,
    required this.getTopRatedAgencyData,
  });

  @override
  Widget build(BuildContext context) {
    final img = (getTopRatedAgencyData.profileImage ?? "").toString();
    final imageUrl = img.isNotEmpty ? "${ApiConstant.BASE_URL}$img" : "";

    return GetBuilder<HomeScreenController>(
      id: Constant.idGetTopRatedAgency,
      builder: (logic) {
        final fullName = "${getTopRatedAgencyData.firstName ?? ""} ${getTopRatedAgencyData.lastName ?? ""}".trim();

        bool isFav = (logic.isFavouriteAgency.isNotEmpty && index < logic.isFavouriteAgency.length) ? logic.isFavouriteAgency[index] : false;

        return GestureDetector(
          onTap: () => Get.toNamed(AppRoutes.agencyInfo, arguments: [
            AppColors.colorList[index % AppColors.colorList.length],
            AppColors.textColorList[index % AppColors.textColorList.length],
            getTopRatedAgencyData.id,
            "",
            "",
            "",
            index,
          ]),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.divider, width: 0.4),
              boxShadow: [BoxShadow(color: Colors.black12.withOpacity(0.03), blurRadius: 6, offset: Offset(0, 2))],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Agency image
                Container(
                  height: 92,
                  width: 92,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: AppColors.divider.withOpacity(0.5)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                      placeholder: (c, u) => Image.asset(AppAsset.icPlaceholderProvider).paddingAll(10),
                      errorWidget: (c, u, e) => Image.asset(AppAsset.icPlaceholderProvider).paddingAll(10),
                    ),
                  ),
                ),
                SizedBox(width: Get.width * 0.03),

                // Info
                Expanded(
                  child: SizedBox(
                    height: 92,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 2),
                        Text(
                          fullName,
                          style: AppFontStyle.fontStyleW900(fontSize: 16, fontColor: AppColors.appButton),
                          overflow: TextOverflow.ellipsis,
                        ),

                        // Services pill
                        ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: Get.width * 0.55),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: AppColors.colorList[index % AppColors.colorList.length],
                            ),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text(
                                getTopRatedAgencyData.service?.map((s) => s.name).join(", ") ?? "",
                                style: AppFontStyle.fontStyleW600(fontSize: 12, fontColor: AppColors.textColorList[index % AppColors.textColorList.length]),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),

                        // Rating
                        Row(
                          children: [
                            Image.asset(AppAsset.icStarFilled, height: 14),
                            const SizedBox(width: 6),
                            Text(
                              getTopRatedAgencyData.avgRating?.toStringAsFixed(1) ?? "0.0",
                              style: AppFontStyle.fontStyleW800(fontSize: 15, fontColor: AppColors.rating),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                      ],
                    ),
                  ),
                ),

                // Favorite icon
                GestureDetector(
                  onTap: () => logic.onFavouriteAgency(customerId: Constant.storage.read("customerId"), agencyId: getTopRatedAgencyData.id ?? ""),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: isFav ? Image.asset(AppAsset.icSavedFilled, height: 26) : Image.asset(AppAsset.icSavedOutline, height: 26),
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









