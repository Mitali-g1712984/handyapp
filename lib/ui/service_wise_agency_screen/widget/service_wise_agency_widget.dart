import 'package:cached_network_image/cached_network_image.dart';
import 'package:handy/custom/app_bar/custom_app_bar.dart';
import 'package:handy/custom/bottom_sheet/agency_filter_bottom_sheet.dart';
import 'package:handy/custom/no_data_found/no_data_found.dart';
import 'package:handy/custom/title/custom_main_title.dart';
import 'package:handy/routes/app_routes.dart';
import 'package:handy/ui/service_wise_agency_screen/controller/service_wise_agency_controller.dart';
import 'package:handy/ui/service_wise_agency_screen/model/get_service_wise_agency_model.dart';
import 'package:handy/utils/api.dart';
import 'package:handy/utils/app_asset.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/constant.dart';
import 'package:handy/utils/font_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/utils/global_variables.dart';
import 'package:handy/utils/shimmers.dart';

/// =================== App Bar =================== ///
class ServiceWiseAgencyAppBarView extends StatelessWidget {
  const ServiceWiseAgencyAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ServiceWiseAgencyController>(
      builder: (logic) {
        return CustomAppBar(
          title: logic.serviceName ?? "",
          showLeadingIcon: true,
        );
      },
    );
  }
}

/// =================== Title =================== ///
class ServiceWiseAgencyTitleView extends StatelessWidget {
  const ServiceWiseAgencyTitleView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomMainTitle(
      title: "Related Agency",
      method: GestureDetector(
        onTap: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return const AgencyFilterBottomSheet();
            },
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          decoration: BoxDecoration(
            color: AppColors.primaryAppColor1,
            borderRadius: BorderRadius.circular(7),
          ),
          child: Image.asset(
            AppAsset.icCategory,
            height: 22,
          ),
        ),
      ),
    ).paddingOnly(left: 15, right: 15, bottom: 10, top: 10);
  }
}

/// =================== List View =================== ///
class ServiceWiseAgencyListView extends StatelessWidget {
  const ServiceWiseAgencyListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ServiceWiseAgencyController>(
      id: Constant.idGetServiceWiseAgency,
      builder: (logic) {
        return logic.isLoading
            ? Shimmers.homeTopRatedAgencyShimmer()
            : logic.getServiceWiseAgencyModel?.data?.isEmpty == true
                ? NoDataFound(
                    image: AppAsset.icNoDataAppointment,
                    imageHeight: 150,
                    text: "No agency found for this service !!",
                    padding: const EdgeInsets.only(top: 10),
                  )
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: logic.getServiceWiseAgencyModel?.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      return ServiceWiseAgencyListItemView(
                        index: index,
                        getServiceWiseAgencyData: logic.getServiceWiseAgencyModel?.data?[index] ?? GetServiceWiseAgencyData(),
                      );
                    },
                  ).paddingOnly(top: 10);
      },
    );
  }
}

class ServiceWiseAgencyListItemView extends StatelessWidget {
  final int index;
  final GetServiceWiseAgencyData getServiceWiseAgencyData;

  const ServiceWiseAgencyListItemView({super.key, required this.index, required this.getServiceWiseAgencyData});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ServiceWiseAgencyController>(
      builder: (logic) {
        return GestureDetector(
          onTap: () {
            Get.toNamed(
              AppRoutes.agencyInfo,
              arguments: [
                logic.colorList,
                logic.textColorList,
                getServiceWiseAgencyData.id,
                logic.serviceId,
                getServiceWiseAgencyData.servicePrice?.toString(),
                getServiceWiseAgencyData.serviceName,
                logic.selectServiceColor,
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
                      imageUrl: "${ApiConstant.BASE_URL}${getServiceWiseAgencyData.profileImage ?? ""}",
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
                        "${getServiceWiseAgencyData.firstName} ${getServiceWiseAgencyData.lastName}",
                        style: AppFontStyle.fontStyleW900(
                          fontSize: 16,
                          fontColor: AppColors.appButton,
                        ),
                      ),
                      Text(
                        "$currency ${getServiceWiseAgencyData.servicePrice?.toString()}",
                        style: AppFontStyle.fontStyleW800(
                          fontSize: 18,
                          fontColor: AppColors.primaryAppColor1,
                        ),
                      ),
                      Row(
                        children: [
                          Image.asset(AppAsset.icStarFilled, height: 14),
                          Text(
                            "  ${getServiceWiseAgencyData.avgRating?.toStringAsFixed(1)}",
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
                const Spacer(),
                GetBuilder<ServiceWiseAgencyController>(
                  id: Constant.idCategoryProviderSaved,
                  builder: (logic) {
                    return GestureDetector(
                      onTap: () {
                        logic.onFavouriteAgency(
                          customerId: Constant.storage.read("customerId"),
                          agencyId: getServiceWiseAgencyData.id ?? "",
                        );
                      },
                      child: logic.isFavouriteAgency[index] == true
                          ? Image.asset(AppAsset.icSavedFilled, height: 24)
                          : Image.asset(AppAsset.icSavedOutline, height: 24),
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
