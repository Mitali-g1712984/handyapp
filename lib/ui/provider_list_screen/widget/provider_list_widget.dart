import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:handy/custom/app_bar/custom_app_bar.dart';
import 'package:handy/custom/no_data_found/no_data_found.dart';
import 'package:handy/ui/provider_list_screen/controller/provider_list_controller.dart';
import 'package:handy/ui/provider_list_screen/model/get_agency_wise_provider_model.dart';
import 'package:handy/utils/api.dart';
import 'package:handy/utils/app_asset.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/constant.dart';
import 'package:handy/utils/font_style.dart';
import 'package:handy/utils/shimmers.dart';

/// =================== Top View =================== ///
class ProviderListTopView extends StatelessWidget {
  const ProviderListTopView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProviderListController>(
      builder: (logic) {
        return CustomAppBar(
          title: "Provider List",
          showLeadingIcon: true,
        );
      },
    );
  }
}

/// =================== Provider List View =================== ///
class ProviderListView extends StatelessWidget {
  const ProviderListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProviderListController>(
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
                        itemCount: logic.getAgencyWiseProviderModel?.providers?.length ?? 0,
                        itemBuilder: (context, index) {
                          return AnimationConfiguration.staggeredGrid(
                            position: index,
                            duration: const Duration(milliseconds: 600),
                            columnCount: logic.getAgencyWiseProviders.length,
                            child: ScaleAnimation(
                              child: FadeInAnimation(
                                child: ProviderListItemView(
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

class ProviderListItemView extends StatelessWidget {
  final GetAgencyWiseProviders getAgencyWiseProviders;
  const ProviderListItemView({super.key, required this.getAgencyWiseProviders});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProviderListController>(
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
