import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:handy/custom/app_bar/custom_app_bar.dart';
import 'package:handy/routes/app_routes.dart';
import 'package:handy/ui/home_screen/controller/home_screen_controller.dart';
import 'package:handy/ui/home_screen/model/get_service_model.dart';
import 'package:handy/utils/api.dart';
import 'package:handy/utils/app_asset.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/constant.dart';
import 'package:handy/utils/enums.dart';
import 'package:handy/utils/font_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/utils/shimmers.dart';

/// =================== App Bar =================== ///
class CategoryAppBarView extends StatelessWidget {
  const CategoryAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: EnumLocale.txtOurServices.name.tr,
      showLeadingIcon: true,
    );
  }
}

/// =================== Grid View =================== ///
class CategoryGridView extends StatelessWidget {
  const CategoryGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
      id: Constant.idGetService,
      builder: (logic) {
        return logic.isLoading
            ? Shimmers.homeServiceShimmer()
            : GridView.builder(
                scrollDirection: Axis.vertical,
                physics: const ScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: logic.getServiceModel?.data?.length ?? 0,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 0.71,
                  crossAxisSpacing: 15,
                ),
                itemBuilder: (context, index) {
                  return AnimationConfiguration.staggeredGrid(
                    position: index,
                    duration: const Duration(milliseconds: 500),
                    columnCount: logic.getServiceModel?.data?.length ?? 0,
                    child: ScaleAnimation(
                      child: FadeInAnimation(
                        child: CategoryGridItemView(
                          index: index,
                          getServiceData: logic.getServiceModel?.data?[index] ?? GetServiceData(),
                        ),
                      ),
                    ),
                  );
                },
              ).paddingOnly(left: 11, right: 11, top: 15);
      },
    );
  }
}

class CategoryGridItemView extends StatelessWidget {
  final int index;
  final GetServiceData getServiceData;

  const CategoryGridItemView({super.key, required this.index, required this.getServiceData});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
      id: Constant.idGetService,
      builder: (logic) {
        return SizedBox(
          height: Get.height * 0.15,
          child: GestureDetector(
            onTap: () {
              Get.toNamed(
                AppRoutes.serviceWiseAgency,
                arguments: [
                  getServiceData.name,
                  getServiceData.id,
                  AppColors.colorList[index % AppColors.colorList.length],
                  AppColors.textColorList[index % AppColors.colorList.length],
                  index,
                ],
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColors.white,
                border: Border.all(color: AppColors.serviceBorder, width: 1),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.boxShadow.withOpacity(0.1),
                    blurRadius: 1,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    width: Get.width * 0.17,
                    padding: const EdgeInsets.all(15),
                    margin: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.colorList[index % AppColors.colorList.length],
                    ),
                    child: CachedNetworkImage(
                      imageUrl: "${ApiConstant.BASE_URL}${getServiceData.image ?? ""}",
                      placeholder: (context, url) {
                        return Image.asset(AppAsset.icPlaceholderService).paddingAll(2);
                      },
                      errorWidget: (context, url, error) {
                        return Image.asset(AppAsset.icPlaceholderService).paddingAll(2);
                      },
                    ),
                  ).paddingOnly(bottom: 6, top: 5),
                  SizedBox(
                    width: Get.width * 0.15,
                    child: Center(
                      child: Text(
                        getServiceData.name ?? "",
                        overflow: TextOverflow.ellipsis,
                        style: AppFontStyle.fontStyleW700(
                          fontSize: 12,
                          fontColor: AppColors.categoryText,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ).paddingOnly(bottom: 10),
          ),
        );
      },
    );
  }
}
