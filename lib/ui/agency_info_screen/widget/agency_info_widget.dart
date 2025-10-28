import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:handy/custom/app_button/primary_app_button.dart';
import 'package:handy/custom/no_data_found/no_data_found.dart';
import 'package:handy/routes/app_routes.dart';
import 'package:handy/ui/agency_info_screen/controller/agency_info_controller.dart';
import 'package:handy/ui/agency_info_screen/model/get_agency_info_model.dart';
import 'package:handy/ui/agency_info_screen/model/get_service_specific_add_on_model.dart';
import 'package:handy/ui/provider_list_screen/model/get_agency_wise_provider_model.dart';
import 'package:handy/utils/api.dart';
import 'package:handy/utils/app_asset.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/constant.dart';
import 'package:handy/utils/enums.dart';
import 'package:handy/utils/font_style.dart';
import 'package:handy/utils/global_variables.dart';
import 'package:handy/utils/shimmers.dart';

/// =================== App Bar =================== ///
class AgencyInfoAppBarView extends StatelessWidget {
  const AgencyInfoAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GetBuilder<AgencyInfoController>(
          id: Constant.idGetAgencyInfo,
          builder: (logic) {
            return logic.isLoading
                ? Shimmers.providerImageShimmer()
                : Container(
                    height: Get.height * 0.35,
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: AppColors.divider.withOpacity(0.5),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: "${ApiConstant.BASE_URL}${logic.getAgencyInfoModel?.agencyInfo?.profileImage ?? ""}",
                      fit: BoxFit.cover,
                      placeholder: (context, url) {
                        return Image.asset(AppAsset.icPlaceholderProvider).paddingAll(40);
                      },
                      errorWidget: (context, url, error) {
                        return Image.asset(AppAsset.icPlaceholderProvider).paddingAll(40);
                      },
                    ),
                  );
          },
        ),
        GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(
              color: AppColors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.only(left: 15, top: 15),
            child: Image.asset(AppAsset.icArrowRight),
          ).paddingOnly(top: 20),
        ),
      ],
    );
  }
}

/// =================== Information =================== ///
class AgencyInfoInfoView extends StatelessWidget {
  const AgencyInfoInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AgencyInfoController>(
      id: Constant.idGetAgencyInfo,
      builder: (logic) {
        return logic.isLoading
            ? Shimmers.providerDesShimmer()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${logic.getAgencyInfoModel?.agencyInfo?.firstName} ${logic.getAgencyInfoModel?.agencyInfo?.lastName}",
                        style: AppFontStyle.fontStyleW900(
                          fontSize: 20,
                          fontColor: AppColors.appButton,
                        ),
                      ),
                      // logic.getAgencyInfoModel?.agencyInfo?.isFavorite == true
                      //     ? Image.asset(AppAsset.icSavedFilled, height: 23)
                      //     : Image.asset(AppAsset.icSavedOutline, height: 23)
                    ],
                  ).paddingOnly(left: 15, right: 15, top: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(
                            AppRoutes.providerList,
                            arguments: [
                              logic.getAgencyInfoModel?.agencyInfo?.id,
                            ],
                          );
                        },
                        child: SizedBox(
                          width: Get.width * 0.21,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 45,
                                width: 45,
                                decoration: BoxDecoration(
                                  color: AppColors.primaryAppColor1,
                                  shape: BoxShape.circle,
                                ),
                                padding: const EdgeInsets.all(12),
                                margin: const EdgeInsets.only(bottom: 3),
                                child: Image.asset(
                                  AppAsset.icPlaceholderUser,
                                  color: AppColors.white,
                                ),
                              ),
                              Text(
                                logic.getAgencyInfoModel?.agencyInfo?.totalAgencyUnderPro.toString() ?? "",
                                style: AppFontStyle.fontStyleW800(
                                  fontSize: 15,
                                  fontColor: AppColors.mainTitleText,
                                ),
                              ),
                              Text(
                                "Provider",
                                style: AppFontStyle.fontStyleW600(
                                  fontSize: 12,
                                  fontColor: AppColors.categoryText,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: Get.width * 0.21,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                color: AppColors.primaryAppColor1,
                                shape: BoxShape.circle,
                              ),
                              padding: const EdgeInsets.all(12),
                              margin: const EdgeInsets.only(bottom: 3),
                              child: Image.asset(AppAsset.icHappy),
                            ),
                            Text(
                              logic.getAgencyInfoModel?.agencyInfo?.totalCustomers.toString() ?? "",
                              style: AppFontStyle.fontStyleW800(
                                fontSize: 15,
                                fontColor: AppColors.mainTitleText,
                              ),
                            ),
                            Text(
                              "Customer",
                              overflow: TextOverflow.ellipsis,
                              style: AppFontStyle.fontStyleW600(
                                fontSize: 12,
                                fontColor: AppColors.categoryText,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: Get.width * 0.21,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                color: AppColors.primaryAppColor1,
                                shape: BoxShape.circle,
                              ),
                              padding: const EdgeInsets.all(8),
                              margin: const EdgeInsets.only(bottom: 3),
                              child: Image.asset(AppAsset.icRating),
                            ),
                            Text(
                              logic.getAgencyInfoModel?.agencyInfo?.avgRating?.toStringAsFixed(1) ?? "",
                              style: AppFontStyle.fontStyleW800(
                                fontSize: 15,
                                fontColor: AppColors.mainTitleText,
                              ),
                            ),
                            Text(
                              EnumLocale.txtRatings.name.tr,
                              style: AppFontStyle.fontStyleW600(
                                fontSize: 12,
                                fontColor: AppColors.categoryText,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: Get.width * 0.21,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                color: AppColors.primaryAppColor1,
                                shape: BoxShape.circle,
                              ),
                              padding: const EdgeInsets.all(12),
                              margin: const EdgeInsets.only(bottom: 3),
                              child: Image.asset(AppAsset.icReview),
                            ),
                            Text(
                              logic.getAgencyInfoModel?.agencyInfo?.reviewCount.toString() ?? "",
                              style: AppFontStyle.fontStyleW800(
                                fontSize: 15,
                                fontColor: AppColors.mainTitleText,
                              ),
                            ),
                            Text(
                              EnumLocale.txtReviews.name.tr,
                              style: AppFontStyle.fontStyleW600(
                                fontSize: 12,
                                fontColor: AppColors.categoryText,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ).paddingOnly(left: 15, right: 15, top: 12),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 0.5,
                        color: AppColors.divider,
                      ),
                    ),
                  ).paddingOnly(top: 10),
                ],
              );
      },
    );
  }
}

/// =================== Tab Bar =================== ///
class AgencyInfoTabView extends StatelessWidget {
  const AgencyInfoTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        AgencyInfoTabBarView(),
        AgencyInfoTabBarItemView(),
      ],
    );
  }
}

class AgencyInfoTabBarView extends StatelessWidget {
  const AgencyInfoTabBarView({super.key});

  @override
  Widget build(BuildContext context) {
    var tabs = [
      const Tab(text: "All Services"),
      const Tab(text: "Packages"),
      const Tab(text: "Providers"),
      const Tab(text: "About"),
    ];

    return GetBuilder<AgencyInfoController>(
      builder: (logic) {
        return Align(
          alignment: Alignment.centerLeft,
          child: TabBar(
            controller: logic.tabController,
            tabs: tabs,
            labelStyle: AppFontStyle.fontStyleW700(
              fontSize: 15,
              fontColor: AppColors.white,
            ),
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
            indicatorPadding: const EdgeInsets.all(8),
            indicator: BoxDecoration(borderRadius: BorderRadius.circular(8), color: AppColors.appButton),
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: AppColors.white,
            unselectedLabelStyle: AppFontStyle.fontStyleW700(
              fontSize: 15,
              fontColor: AppColors.tabUnselectText,
            ),
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            dividerColor: Colors.transparent,
            overlayColor: WidgetStatePropertyAll(AppColors.transparent),
          ),
        );
      },
    );
  }
}

class AgencyInfoTabBarItemView extends StatelessWidget {
  const AgencyInfoTabBarItemView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GetBuilder<AgencyInfoController>(
        builder: (logic) {
          return TabBarView(
            physics: const BouncingScrollPhysics(),
            controller: logic.tabController,
            children: const [
              AgencyInfoAllServiceListView(),
              AgencyInfoPackageListView(),
              AgencyInfoProviderListView(),
              AgencyInfoAboutView(),
            ],
          );
        },
      ),
    );
  }
}

/// =================== Service =================== ///
class AgencyInfoAllServiceListView extends StatelessWidget {
  const AgencyInfoAllServiceListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AgencyInfoController>(
      id: Constant.idGetAgencyInfo,
      builder: (logic) {
        final services = logic.getAgencyInfoModel?.agencyInfo?.service;
        if (services == null || services.isEmpty) return const SizedBox();

        // Filter the services by serviceId, matching logic.selectedServiceId
        final filteredServices = logic.selectedServiceId != null
            ? services.where((service) => service.serviceId == logic.selectedServiceId).toList()
            : services;

        return logic.isLoading
            ? Shimmers.homeTopRatedAgencyShimmer()
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // If a service is selected, show a "Selected Service" section.
                    if (logic.selectedServiceId != null) ...[
                      if (filteredServices.isNotEmpty)
                        AgencyInfoAllServiceListItemView(
                          getAgencyInfoService: filteredServices.first,
                          index: logic.selectServiceColor,
                        ).paddingOnly(bottom: 12, left: 15, right: 15),
                    ] else
                      AnimationLimiter(
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: filteredServices.length,
                          itemBuilder: (context, index) {
                            return AnimationConfiguration.staggeredGrid(
                              position: index,
                              duration: const Duration(milliseconds: 600),
                              columnCount: filteredServices.length,
                              child: SlideAnimation(
                                child: FadeInAnimation(
                                  child: AgencyInfoAllServiceListItemView(
                                    getAgencyInfoService: filteredServices[index],
                                    index: index,
                                  ).paddingOnly(bottom: 12),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    // Show add-on services if any exist after selects a service.
                    logic.getServiceSpecificAddOnModel?.matchingAddOnServices?.isEmpty == true
                        ? const SizedBox()
                        : const AddOnServiceListView(),
                  ],
                ),
              );
      },
    );
  }
}

class AgencyInfoAllServiceListItemView extends StatelessWidget {
  final AgencyInfoService getAgencyInfoService;
  final int index;
  const AgencyInfoAllServiceListItemView({
    super.key,
    required this.getAgencyInfoService,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AgencyInfoController>(
      id: Constant.idGetAgencyInfo,
      builder: (logic) {
        bool isSelected = logic.selectedServiceId == getAgencyInfoService.serviceId;

        return GestureDetector(
          onTap: () {
            logic.selectService(
              serviceId: getAgencyInfoService.serviceId ?? "",
              price: getAgencyInfoService.price.toString(),
              name: getAgencyInfoService.name ?? "",
              index: index,
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: isSelected ? AppColors.primaryAppColor1 : AppColors.greyText.withOpacity(0.3),
                width: 0.8,
              ),
            ),
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Container(
                  height: 95,
                  width: 95,
                  decoration: BoxDecoration(
                    color: AppColors.colorList[index % AppColors.colorList.length],
                    borderRadius: BorderRadius.circular(13),
                  ),
                  padding: const EdgeInsets.all(18),
                  child: CachedNetworkImage(
                    imageUrl: "${ApiConstant.BASE_URL}${getAgencyInfoService.image ?? ""}",
                    placeholder: (context, url) {
                      return Image.asset(AppAsset.icPlaceholderImage).paddingAll(15);
                    },
                    errorWidget: (context, url, error) {
                      return Image.asset(AppAsset.icPlaceholderImage).paddingAll(15);
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        getAgencyInfoService.name ?? "",
                        style: AppFontStyle.fontStyleW600(
                          fontSize: 15,
                          fontColor: AppColors.mainTitleText,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Duration: ${getAgencyInfoService.duration ?? ""} min",
                        style: AppFontStyle.fontStyleW500(
                          fontSize: 12,
                          fontColor: AppColors.grey.withOpacity(0.6),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "$currency ${getAgencyInfoService.price ?? "0.00"}",
                        style: AppFontStyle.fontStyleW700(
                          fontSize: 15,
                          fontColor: AppColors.primaryAppColor1,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Image.asset(AppAsset.icStarFilled, height: 14),
                          Text(
                            "  ${getAgencyInfoService.avgRating?.toStringAsFixed(1)}",
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
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primaryAppColor1 : Colors.transparent,
                    border: Border.all(
                      color: isSelected ? AppColors.primaryAppColor1 : AppColors.accountLogin,
                      width: 1.5,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: isSelected
                      ? Icon(
                          Icons.check,
                          color: AppColors.white,
                          size: 14,
                        )
                      : null,
                ).paddingOnly(right: 5),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// =================== Add-on Service =================== ///
class AddOnServiceListView extends StatelessWidget {
  const AddOnServiceListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AgencyInfoController>(
      id: Constant.idGetAgencyInfo,
      builder: (logic) {
        return logic.getServiceSpecificAddOnModel?.matchingAddOnServices == null
            ? const SizedBox()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Add-ons",
                    style: AppFontStyle.fontStyleW600(
                      fontSize: 17,
                      fontColor: AppColors.mainTitleText,
                    ),
                  ).paddingOnly(left: 15, bottom: 12),
                  SizedBox(
                    height: 185,
                    child: ListView.builder(
                      itemCount: logic.getServiceSpecificAddOnModel?.matchingAddOnServices?.length ?? 0,
                      scrollDirection: Axis.horizontal,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return SizedBox(
                          width: 180,
                          child: AddOnServiceListItemView(
                            matchingAddOnServices:
                                logic.getServiceSpecificAddOnModel?.matchingAddOnServices?[index] ?? MatchingAddOnServices(),
                          ).paddingOnly(right: 12),
                        );
                      },
                    ).paddingOnly(left: 15),
                  ),
                ],
              );
      },
    );
  }
}

class AddOnServiceListItemView extends StatelessWidget {
  final MatchingAddOnServices matchingAddOnServices;
  const AddOnServiceListItemView({super.key, required this.matchingAddOnServices});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AgencyInfoController>(
      id: Constant.idGetAgencyInfo,
      builder: (logic) {
        bool isSelected = logic.selectedAddOnServiceIds.contains(matchingAddOnServices.id);

        return Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: AppColors.greyText.withOpacity(0.3),
                  width: 0.8,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: "${ApiConstant.BASE_URL}${matchingAddOnServices.image ?? ""}",
                      height: 100,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) {
                        return Image.asset(
                          AppAsset.icPlaceholderImage,
                          height: 100,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        );
                      },
                      errorWidget: (context, url, error) {
                        return Image.asset(
                          AppAsset.icPlaceholderImage,
                          height: 100,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            matchingAddOnServices.addOnServiceName ?? "",
                            style: AppFontStyle.fontStyleW600(
                              fontSize: 15,
                              fontColor: AppColors.mainTitleText,
                            ),
                          ),
                        ),
                        const SizedBox(height: 3),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  matchingAddOnServices.service?.name ?? "",
                                  style: AppFontStyle.fontStyleW500(
                                    fontSize: 12,
                                    fontColor: AppColors.grey.withOpacity(0.6),
                                  ),
                                ),
                                Text(
                                  "$currency ${matchingAddOnServices.price ?? "0.00"}",
                                  style: AppFontStyle.fontStyleW700(
                                    fontSize: 15,
                                    fontColor: AppColors.primaryAppColor1,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                logic.toggleAddOnService(matchingAddOnServices);
                              },
                              child: Container(
                                height: 28,
                                width: 28,
                                decoration: BoxDecoration(
                                  color: AppColors.primaryAppColor1,
                                  shape: BoxShape.circle,
                                ),
                                child: isSelected
                                    ? Image.asset(
                                        AppAsset.icCheck,
                                        color: AppColors.white,
                                      ).paddingAll(8)
                                    : Image.asset(
                                        AppAsset.icAdd,
                                        color: AppColors.white,
                                      ).paddingAll(5),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

/// =================== Packages =================== ///
class AgencyInfoPackageListView extends StatelessWidget {
  const AgencyInfoPackageListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AgencyInfoController>(
      id: Constant.idGetAgencyInfo,
      builder: (logic) {
        return logic.getAgencyInfoModel?.agencyInfo?.matchingPackages?.isEmpty == true
            ? const SizedBox()
            : AnimationLimiter(
                child: ListView.builder(
                  itemCount: logic.getAgencyInfoModel?.agencyInfo?.matchingPackages?.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return AnimationConfiguration.staggeredGrid(
                      position: index,
                      duration: const Duration(milliseconds: 600),
                      columnCount: logic.getAgencyInfoModel?.agencyInfo?.matchingPackages?.length ?? 0,
                      child: SlideAnimation(
                        child: FadeInAnimation(
                          child: PackagesListItemView(
                            matchingPackage: logic.getAgencyInfoModel?.agencyInfo?.matchingPackages?[index] ?? MatchingPackage(),
                          ).paddingOnly(bottom: 10),
                        ),
                      ),
                    );
                  },
                ).paddingOnly(left: 15, right: 15).paddingOnly(top: 5),
              );
      },
    );
  }
}

class PackagesListItemView extends StatelessWidget {
  final MatchingPackage matchingPackage;

  const PackagesListItemView({super.key, required this.matchingPackage});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AgencyInfoController>(
      id: Constant.idGetAgencyInfo,
      builder: (logic) {
        int discountPercentage = matchingPackage.listedPrice == 0
            ? 0
            : (((matchingPackage.listedPrice)! - (matchingPackage.price)!) / (matchingPackage.listedPrice)! * 100).toInt();

        return Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: AppColors.boxShadow.withOpacity(0.2),
                blurRadius: 1,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 110,
                width: 110,
                decoration: BoxDecoration(
                  color: AppColors.greyText.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: CachedNetworkImage(
                    imageUrl: "${ApiConstant.BASE_URL}${matchingPackage.image ?? ""}",
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Padding(
                      padding: const EdgeInsets.all(15),
                      child: Image.asset(AppAsset.icPlaceholderImage),
                    ),
                    errorWidget: (context, url, error) => Padding(
                      padding: const EdgeInsets.all(15),
                      child: Image.asset(AppAsset.icPlaceholderImage),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      matchingPackage.packageName ?? "",
                      overflow: TextOverflow.ellipsis,
                      style: AppFontStyle.fontStyleW600(
                        fontSize: 15,
                        fontColor: AppColors.mainTitleText,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Text(
                          "$currency ${matchingPackage.price?.toStringAsFixed(2) ?? ""}",
                          style: AppFontStyle.fontStyleW700(
                            fontSize: 14,
                            fontColor: AppColors.primaryAppColor1,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "-$currency ${matchingPackage.listedPrice?.toStringAsFixed(2) ?? ""}",
                          style: AppFontStyle.fontStyleW700(
                              fontSize: 10.5,
                              fontColor: AppColors.mainTitleText.withOpacity(0.3),
                              textDecoration: TextDecoration.lineThrough,
                              decorationColor: AppColors.mainTitleText.withOpacity(0.3)),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "$discountPercentage% off",
                          style: AppFontStyle.fontStyleW700(
                            fontSize: 10.5,
                            fontColor: AppColors.green,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.toNamed(
                            AppRoutes.purchasePackage,
                            arguments: [
                              matchingPackage,
                            ],
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryAppColor1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                        ),
                        child: Text(
                          "Purchase",
                          style: AppFontStyle.fontStyleW800(
                            fontSize: 17,
                            fontColor: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// =================== Provider List View =================== ///
class AgencyInfoProviderListView extends StatelessWidget {
  const AgencyInfoProviderListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AgencyInfoController>(
      id: Constant.idGetAgencyWiseProvider,
      builder: (logic) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: logic.isLoading
              ? Shimmers.getAgencyServiceListShimmer()
              : logic.getAgencyWiseProviders.isEmpty == true
                  ? NoDataFound(
                      image: AppAsset.icNoDataAppointment,
                      imageHeight: 150,
                      text: "No Data found for provider!!",
                      padding: const EdgeInsets.only(top: 7),
                    )
                  : AnimationLimiter(
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 3 / 2.5,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        padding: EdgeInsets.zero,
                        itemCount: logic.getAgencyWiseProviderModel?.providers?.length ?? 0,
                        itemBuilder: (context, index) {
                          return AnimationConfiguration.staggeredGrid(
                            position: index,
                            duration: const Duration(milliseconds: 600),
                            columnCount: logic.getAgencyWiseProviders.length,
                            child: ScaleAnimation(
                              child: FadeInAnimation(
                                child: AgencyInfoProviderListItemView(
                                  getAgencyWiseProviders: logic.getAgencyWiseProviders[index],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
        );
      },
    );
  }
}

class AgencyInfoProviderListItemView extends StatelessWidget {
  final GetAgencyWiseProviders getAgencyWiseProviders;
  const AgencyInfoProviderListItemView({super.key, required this.getAgencyWiseProviders});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AgencyInfoController>(
      builder: (logic) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color: AppColors.boxShadow.withOpacity(0.2),
                blurRadius: 1,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: "${ApiConstant.BASE_URL}${getAgencyWiseProviders.profileImage}",
                      fit: BoxFit.cover,
                      height: 115,
                      width: Get.width,
                      placeholder: (context, url) {
                        return Image.asset(AppAsset.icPlaceholderProvider).paddingAll(7);
                      },
                      errorWidget: (context, url, error) {
                        return Image.asset(AppAsset.icPlaceholderProvider).paddingAll(7);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                getAgencyWiseProviders.name ?? "",
                style: AppFontStyle.fontStyleW600(
                  fontColor: AppColors.appButton,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// =================== About Agency =================== ///
class AgencyInfoAboutView extends StatelessWidget {
  const AgencyInfoAboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AgencyInfoController>(
      id: Constant.idGetAgencyInfo,
      builder: (logic) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  AppAsset.icAboutMe,
                  height: 25,
                  width: 25,
                ).paddingOnly(right: 8),
                Text(
                  EnumLocale.txtAboutMe.name.tr,
                  style: AppFontStyle.fontStyleW800(
                    fontSize: 15,
                    fontColor: AppColors.appButton,
                  ),
                )
              ],
            ).paddingOnly(left: 15),
            Container(
              width: Get.width,
              padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
              child: Text(
                logic.getAgencyInfoModel?.agencyInfo?.yourSelf ?? "",
                style: AppFontStyle.fontStyleW500(
                  fontSize: 13,
                  fontColor: AppColors.appText,
                ),
              ),
            ),
          ],
        ).paddingOnly(top: 15);
      },
    );
  }
}

/// =================== Bottom Bar =================== ///
class AgencyInfoBottomView extends StatelessWidget {
  const AgencyInfoBottomView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AgencyInfoController>(
      id: Constant.idGetAgencyInfo,
      builder: (logic) {
        return GestureDetector(
          onTap: () {
            logic.onBookNowClick();
          },
          child: PrimaryAppButton(
            text: "${EnumLocale.txtBookNow.name.tr} $currency ${logic.servicePrice ?? 0.0}",
            textStyle: AppFontStyle.fontStyleW900(
              fontSize: 17,
              fontColor: AppColors.primaryAppColor1,
            ),
          ).paddingOnly(left: 15, right: 15, bottom: 15),
        );
      },
    );
  }
}
