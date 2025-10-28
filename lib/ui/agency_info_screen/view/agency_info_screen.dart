import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/ui/agency_info_screen/controller/agency_info_controller.dart';
import 'package:handy/ui/agency_info_screen/widget/agency_info_widget.dart';
import 'package:handy/utils/api.dart';
import 'package:handy/utils/app_asset.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/constant.dart';
import 'package:handy/utils/font_style.dart';

class AgencyInfoScreen extends StatelessWidget {
  const AgencyInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 230.0,
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.appButton,
            flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final double offset = constraints.biggest.height;
                final bool isCollapsed = offset <= kToolbarHeight + Get.statusBarHeight;

                return FlexibleSpaceBar(
                  title: isCollapsed
                      ? GetBuilder<AgencyInfoController>(
                          id: Constant.idGetAgencyInfo,
                          builder: (logic) {
                            return Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Image.asset(
                                    AppAsset.icArrowRight,
                                    height: 25,
                                    color: AppColors.primaryAppColor1,
                                  ).paddingOnly(left: 12),
                                ),
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.divider.withOpacity(0.5),
                                  ),
                                  clipBehavior: Clip.hardEdge,
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        "${ApiConstant.BASE_URL}${logic.getAgencyInfoModel?.agencyInfo?.profileImage ?? ""}",
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) {
                                      return Image.asset(AppAsset.icPlaceholderProvider).paddingAll(10);
                                    },
                                    errorWidget: (context, url, error) {
                                      return Image.asset(AppAsset.icPlaceholderProvider).paddingAll(10);
                                    },
                                  ),
                                ).paddingOnly(left: 12, right: 10),
                                Text(
                                  "${logic.getAgencyInfoModel?.agencyInfo?.firstName} ${logic.getAgencyInfoModel?.agencyInfo?.lastName}",
                                  style: AppFontStyle.fontStyleW700(
                                    fontSize: 18,
                                    fontColor: AppColors.primaryAppColor1,
                                  ),
                                ),
                              ],
                            );
                          },
                        )
                      : null,
                  background: const AgencyInfoAppBarView(),
                  collapseMode: CollapseMode.parallax,
                  centerTitle: true,
                );
              },
            ),
          ),
          const SliverToBoxAdapter(
            child: AgencyInfoInfoView(),
          ),

          /// Using SliverPadding & SliverList to avoid height issues
          SliverPersistentHeader(
            pinned: true,
            delegate: SliverAppBarDelegate(
              child: const AgencyInfoTabView(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<AgencyInfoController>(
        id: Constant.idGetAgencyInfo,
        builder: (logic) {
          return logic.servicePrice?.isEmpty == true ? const SizedBox() : const AgencyInfoBottomView();
        },
      ),
    );
  }
}

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  SliverAppBarDelegate({required this.child});

  @override
  double get minExtent => Get.width;

  @override
  double get maxExtent => Get.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return oldDelegate.child != child;
  }
}
