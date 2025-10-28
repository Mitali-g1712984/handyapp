// import 'package:handy/custom/app_button/primary_app_button.dart';
// import 'package:handy/ui/search_screen/controller/search_screen_controller.dart';
// import 'package:handy/utils/app_asset.dart';
// import 'package:handy/utils/app_color.dart';
// import 'package:handy/utils/constant.dart';
// import 'package:handy/utils/enums.dart';
// import 'package:handy/utils/font_style.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// /// =================== Bottom Sheet =================== ///
// class SearchFilterBottomSheet extends StatelessWidget {
//   const SearchFilterBottomSheet({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 515,
//       width: Get.width,
//       decoration: BoxDecoration(
//         borderRadius: const BorderRadius.only(
//           topLeft: Radius.circular(35),
//           topRight: Radius.circular(35),
//         ),
//         color: AppColors.white,
//       ),
//       child: const Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           FilterBottomTitleView(),
//           FilterBottomServiceListView(),
//           FilterBottomRatingGridView(),
//           FilterBottomLocationListView(),
//           SizedBox(height: 40),
//           FilterBottomButtonView(),
//         ],
//       ),
//     );
//   }
// }
//
// /// Bottom Sheet Items......
//
// /// =================== Bottom Sheet Title =================== ///
// class FilterBottomTitleView extends StatelessWidget {
//   const FilterBottomTitleView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           height: 52,
//           decoration: BoxDecoration(
//             borderRadius: const BorderRadius.only(
//               topLeft: Radius.circular(28),
//               topRight: Radius.circular(28),
//             ),
//             color: AppColors.primaryAppColor1,
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Spacer(),
//               Text(
//                 EnumLocale.txtApplyFilters.name.tr,
//                 style: AppFontStyle.fontStyleW800(
//                   fontSize: 19,
//                   fontColor: AppColors.white,
//                 ),
//               ).paddingOnly(left: 20),
//               const Spacer(),
//               GestureDetector(
//                 onTap: () {
//                   Get.back();
//                 },
//                 child: Image.asset(
//                   AppAsset.icClose,
//                   height: Get.height * 0.07,
//                   width: Get.width * 0.07,
//                 ).paddingOnly(right: 15),
//               )
//             ],
//           ),
//         ),
//         Container(
//           width: Get.width,
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: AppColors.bottomSheetDivider,
//               width: 0.4,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// /// =================== Bottom Sheet Select Service =================== ///
// class FilterBottomServiceListView extends StatelessWidget {
//   const FilterBottomServiceListView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           "Select Service",
//           style: AppFontStyle.fontStyleW700(
//             fontSize: 15,
//             fontColor: AppColors.categoryText,
//           ),
//         ).paddingOnly(left: 15, top: 10, bottom: 13),
//         SizedBox(
//           height: Get.height * 0.05,
//           child: GetBuilder<SearchScreenController>(
//             id: Constant.idSelectService,
//             builder: (logic) {
//               return ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 shrinkWrap: true,
//                 itemCount: logic.getAllService.length,
//                 itemBuilder: (context, index) {
//                   return FilterBottomServiceListItemView(index: index);
//                 },
//               );
//             },
//           ),
//         ).paddingOnly(left: 12, right: 12),
//       ],
//     );
//   }
// }
//
// class FilterBottomServiceListItemView extends StatelessWidget {
//   final int index;
//
//   const FilterBottomServiceListItemView({super.key, required this.index});
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<SearchScreenController>(
//       id: Constant.idSelectService,
//       builder: (logic) {
//         return GestureDetector(
//           onTap: () {
//             logic.onServiceSelect(index);
//           },
//           child: Container(
//             padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
//             margin: const EdgeInsets.only(right: 13),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               color: logic.serviceSelect == index ? AppColors.appButton : AppColors.divider,
//             ),
//             child: Center(
//               child: Text(
//                 logic.getAllService[index],
//                 style: AppFontStyle.fontStyleW700(
//                   fontSize: 15,
//                   fontColor: logic.serviceSelect == index ? AppColors.white : AppColors.tabUnselectText,
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
//
// /// =================== Bottom Sheet Select Rating =================== ///
// class FilterBottomRatingGridView extends StatelessWidget {
//   const FilterBottomRatingGridView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           EnumLocale.txtRatings.name.tr,
//           style: AppFontStyle.fontStyleW700(
//             fontSize: 15,
//             fontColor: AppColors.categoryText,
//           ),
//         ).paddingOnly(left: 15, top: 15, bottom: 10),
//         SizedBox(
//           height: Get.height * 0.12,
//           child: GetBuilder<SearchScreenController>(
//             id: Constant.idRatingSelect,
//             builder: (logic) {
//               return GridView.builder(
//                 scrollDirection: Axis.vertical,
//                 physics: const ScrollPhysics(),
//                 padding: EdgeInsets.zero,
//                 shrinkWrap: true,
//                 itemCount: logic.ratings.length,
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 4,
//                   childAspectRatio: 2.1,
//                   mainAxisSpacing: 10,
//                   crossAxisSpacing: 10,
//                 ),
//                 itemBuilder: (context, index) {
//                   return FilterBottomRatingGridItemView(index: index);
//                 },
//               );
//             },
//           ),
//         ).paddingOnly(left: 12, right: 12),
//       ],
//     );
//   }
// }
//
// class FilterBottomRatingGridItemView extends StatelessWidget {
//   final int index;
//
//   const FilterBottomRatingGridItemView({super.key, required this.index});
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<SearchScreenController>(
//       id: Constant.idRatingSelect,
//       builder: (logic) {
//         return GestureDetector(
//           onTap: () {
//             logic.onRatingSelect(index);
//           },
//           child: Container(
//             width: Get.width * 0.262,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               color: logic.ratingSelect == index ? AppColors.appButton : AppColors.divider,
//             ),
//             padding: const EdgeInsets.only(left: 13, right: 13),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Image.asset(
//                   AppAsset.icStarFilled,
//                   height: 15,
//                   width: 15,
//                   color: logic.ratingSelect == index ? AppColors.white : AppColors.tabUnselectText,
//                 ).paddingOnly(right: 8),
//                 Text(
//                   logic.ratings[index],
//                   overflow: TextOverflow.ellipsis,
//                   style: AppFontStyle.fontStyleW700(
//                     fontSize: 15,
//                     fontColor: logic.ratingSelect == index ? AppColors.white : AppColors.tabUnselectText,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
//
// /// =================== Bottom Sheet Location =================== ///
// class FilterBottomLocationListView extends StatelessWidget {
//   const FilterBottomLocationListView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           EnumLocale.txtLocation.name.tr,
//           style: AppFontStyle.fontStyleW700(
//             fontSize: 15,
//             fontColor: AppColors.categoryText,
//           ),
//         ).paddingOnly(left: 15, top: 15, bottom: 15),
//         SizedBox(
//           height: Get.height * 0.06,
//           child: GetBuilder<SearchScreenController>(
//             id: Constant.idSelectLocation,
//             builder: (logic) {
//               return ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 shrinkWrap: true,
//                 itemCount: logic.locations.length,
//                 itemBuilder: (context, index) {
//                   return FilterBottomLocationListItemView(index: index);
//                 },
//               );
//             },
//           ),
//         ).paddingOnly(left: 12, right: 12)
//       ],
//     );
//   }
// }
//
// class FilterBottomLocationListItemView extends StatelessWidget {
//   final int index;
//
//   const FilterBottomLocationListItemView({super.key, required this.index});
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<SearchScreenController>(
//       id: Constant.idSelectLocation,
//       builder: (logic) {
//         return GestureDetector(
//           onTap: () {
//             logic.onLocationSelect(index);
//           },
//           child: Container(
//             padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
//             margin: const EdgeInsets.only(right: 13, bottom: 8),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               color: logic.locationSelect == index ? AppColors.appButton : AppColors.divider,
//             ),
//             child: Center(
//               child: Text(
//                 logic.locations[index],
//                 style: AppFontStyle.fontStyleW700(
//                   fontSize: 15,
//                   fontColor: logic.locationSelect == index ? AppColors.white : AppColors.tabUnselectText,
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
//
// /// =================== Bottom Sheet Button =================== ///
// class FilterBottomButtonView extends StatelessWidget {
//   const FilterBottomButtonView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<SearchScreenController>(
//       id: Constant.idApplyFilter,
//       builder: (logic) {
//         return Center(
//           child: PrimaryAppButton(
//             onTap: () {
//               logic.serviceSelect == -1 && logic.ratingSelect == -1 && logic.locationSelect == -1
//                   ? logic.onBackToFilter()
//                   : logic.onApplyFilter();
//             },
//             text: EnumLocale.txtApplyNow.name.tr,
//             color: logic.serviceSelect == -1 && logic.ratingSelect == -1 && logic.locationSelect == -1
//                 ? AppColors.divider
//                 : AppColors.appButton,
//             textStyle: AppFontStyle.fontStyleW800(
//               fontSize: 17,
//               fontColor: logic.serviceSelect == -1 && logic.ratingSelect == -1 && logic.locationSelect == -1
//                   ? AppColors.tabUnselectText
//                   : AppColors.primaryAppColor1,
//             ),
//           ).paddingOnly(top: 10, left: 12, right: 12, bottom: 12),
//         );
//       },
//     );
//   }
// }

import 'package:handy/custom/app_button/primary_app_button.dart';
import 'package:handy/ui/search_screen/controller/search_screen_controller.dart';
import 'package:handy/utils/app_asset.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/constant.dart';
import 'package:handy/utils/enums.dart';
import 'package:handy/utils/font_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchFilterBottomSheet extends StatelessWidget {
  const SearchFilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 515,
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
        color: AppColors.white,
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FilterBottomTitleView(),
          FilterBottomServiceListView(),
          FilterBottomRatingGridView(),
          FilterBottomLocationListView(),
          SizedBox(height: 40),
          FilterBottomButtonView(),
        ],
      ),
    );
  }
}

/// Bottom Sheet Items......

/// =================== Bottom Sheet Title =================== ///
class FilterBottomTitleView extends StatelessWidget {
  const FilterBottomTitleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 52,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(28),
              topRight: Radius.circular(28),
            ),
            color: AppColors.primaryAppColor1,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Text(
                EnumLocale.txtApplyFilters.name.tr,
                style: AppFontStyle.fontStyleW800(
                  fontSize: 19,
                  fontColor: AppColors.white,
                ),
              ).paddingOnly(left: 20),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Image.asset(
                  AppAsset.icClose,
                  height: Get.height * 0.07,
                  width: Get.width * 0.07,
                ).paddingOnly(right: 15),
              )
            ],
          ),
        ),
        Container(
          width: Get.width,
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.bottomSheetDivider,
              width: 0.4,
            ),
          ),
        ),
      ],
    );
  }
}

/// =================== Bottom Sheet Select Service =================== ///
class FilterBottomServiceListView extends StatelessWidget {
  const FilterBottomServiceListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Select Service",
          style: AppFontStyle.fontStyleW700(
            fontSize: 15,
            fontColor: AppColors.categoryText,
          ),
        ).paddingOnly(left: 15, top: 10, bottom: 13),
        SizedBox(
          height: Get.height * 0.05,
          child: GetBuilder<SearchScreenController>(
            id: Constant.idSelectService,
            builder: (logic) {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: logic.getAllService.length,
                itemBuilder: (context, index) {
                  return FilterBottomServiceListItemView(service: logic.getAllService[index]);
                },
              );
            },
          ),
        ).paddingOnly(left: 12, right: 12),
      ],
    );
  }
}

class FilterBottomServiceListItemView extends StatelessWidget {
  final String service;

  const FilterBottomServiceListItemView({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchScreenController>(
      id: Constant.idSelectService,
      builder: (logic) {
        bool isSelected = logic.selectedServices.contains(service);
        return GestureDetector(
          onTap: () {
            logic.onServiceSelect(service);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
            margin: const EdgeInsets.only(right: 13),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: isSelected ? AppColors.appButton : AppColors.divider,
            ),
            child: Center(
              child: Text(
                service,
                style: AppFontStyle.fontStyleW700(
                  fontSize: 15,
                  fontColor: isSelected ? AppColors.white : AppColors.tabUnselectText,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// =================== Bottom Sheet Select Rating =================== ///
class FilterBottomRatingGridView extends StatelessWidget {
  const FilterBottomRatingGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          EnumLocale.txtRatings.name.tr,
          style: AppFontStyle.fontStyleW700(
            fontSize: 15,
            fontColor: AppColors.categoryText,
          ),
        ).paddingOnly(left: 15, top: 15, bottom: 10),
        SizedBox(
          height: Get.height * 0.12,
          child: GetBuilder<SearchScreenController>(
            id: Constant.idRatingSelect,
            builder: (logic) {
              return GridView.builder(
                scrollDirection: Axis.vertical,
                physics: const ScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: logic.ratings.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 2.1,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return FilterBottomRatingGridItemView(rating: logic.ratings[index]);
                },
              );
            },
          ),
        ).paddingOnly(left: 12, right: 12),
      ],
    );
  }
}

class FilterBottomRatingGridItemView extends StatelessWidget {
  final String rating;

  const FilterBottomRatingGridItemView({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchScreenController>(
      id: Constant.idRatingSelect,
      builder: (logic) {
        bool isSelected = logic.selectedRatings.contains(rating);
        return GestureDetector(
          onTap: () {
            logic.onRatingSelect(rating);
          },
          child: Container(
            width: Get.width * 0.262,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: isSelected ? AppColors.appButton : AppColors.divider,
            ),
            padding: const EdgeInsets.only(left: 13, right: 13),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppAsset.icStarFilled,
                  height: 15,
                  width: 15,
                  color: isSelected ? AppColors.white : AppColors.tabUnselectText,
                ).paddingOnly(right: 8),
                Text(
                  rating,
                  style: AppFontStyle.fontStyleW700(
                    fontSize: 15,
                    fontColor: isSelected ? AppColors.white : AppColors.tabUnselectText,
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

/// =================== Bottom Sheet Location =================== ///
class FilterBottomLocationListView extends StatelessWidget {
  const FilterBottomLocationListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          EnumLocale.txtLocation.name.tr,
          style: AppFontStyle.fontStyleW700(
            fontSize: 15,
            fontColor: AppColors.categoryText,
          ),
        ).paddingOnly(left: 15, top: 15, bottom: 15),
        SizedBox(
          height: Get.height * 0.06,
          child: GetBuilder<SearchScreenController>(
            id: Constant.idSelectLocation,
            builder: (logic) {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: logic.locations.length,
                itemBuilder: (context, index) {
                  return FilterBottomLocationListItemView(location: logic.locations[index]);
                },
              );
            },
          ),
        ).paddingOnly(left: 12, right: 12)
      ],
    );
  }
}

class FilterBottomLocationListItemView extends StatelessWidget {
  final String location;

  const FilterBottomLocationListItemView({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchScreenController>(
      id: Constant.idSelectLocation,
      builder: (logic) {
        bool isSelected = logic.selectedLocations.contains(location);
        return GestureDetector(
          onTap: () {
            logic.onLocationSelect(location);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
            margin: const EdgeInsets.only(right: 13, bottom: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: isSelected ? AppColors.appButton : AppColors.divider,
            ),
            child: Center(
              child: Text(
                location,
                style: AppFontStyle.fontStyleW700(
                  fontSize: 15,
                  fontColor: isSelected ? AppColors.white : AppColors.tabUnselectText,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// =================== Bottom Sheet Button =================== ///
class FilterBottomButtonView extends StatelessWidget {
  const FilterBottomButtonView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchScreenController>(
      id: Constant.idApplyFilter,
      builder: (logic) {
        bool isAnyFieldSelected =
            logic.selectedServices.isNotEmpty || logic.selectedRatings.isNotEmpty || logic.selectedLocations.isNotEmpty;

        return Center(
          child: PrimaryAppButton(
            onTap: () {
              isAnyFieldSelected ? logic.onApplyFilter() : logic.onBackToFilter();
            },
            text: EnumLocale.txtApplyNow.name.tr,
            color: isAnyFieldSelected ? AppColors.appButton : AppColors.divider,
            textStyle: AppFontStyle.fontStyleW800(
              fontSize: 17,
              fontColor: isAnyFieldSelected ? AppColors.primaryAppColor1 : AppColors.tabUnselectText,
            ),
          ).paddingOnly(top: 10, left: 12, right: 12, bottom: 12),
        );
      },
    );
  }
}
