import 'package:handy/custom/app_bar/custom_app_bar.dart';
import 'package:handy/custom/no_data_found/no_data_found.dart';
import 'package:handy/ui/notification_screen/controller/notification_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/utils/app_asset.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/constant.dart';
import 'package:handy/utils/enums.dart';
import 'package:handy/utils/font_style.dart';
import 'package:handy/utils/shimmers.dart';
import 'package:intl/intl.dart';

/// =================== App Bar =================== ///
class NotificationAppBarView extends StatelessWidget {
  const NotificationAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationController>(
      id: Constant.idGetNotification,
      builder: (logic) {
        return CustomAppBar(
          title: EnumLocale.txtNotification.name.tr,
          showLeadingIcon: true,
          action: [
            logic.getNotificationModel?.notification?.isEmpty == true
                ? const SizedBox()
                : InkWell(
                    onTap: () {
                      logic.onClickClearNotification();
                    },
                    child: Icon(
                      Icons.delete_forever,
                      color: AppColors.redBox.withOpacity(0.8),
                      size: 25,
                    ).paddingOnly(right: 12),
                  )
          ],
        );
      },
    );
  }
}

/// =================== List View =================== ///
class NotificationListView extends StatelessWidget {
  const NotificationListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationController>(
      id: Constant.idGetNotification,
      builder: (logic) {
        return logic.isLoading
            ? Shimmers.notificationShimmer()
            : logic.getNotificationModel?.notification?.isEmpty == true
                ? NoDataFound(
                    image: AppAsset.icPlaceholderNoData,
                    imageHeight: 150,
                    text: EnumLocale.noDataFoundNotification.name.tr,
                    padding: const EdgeInsets.only(top: 10),
                    textSize: 14,
                  )
                : SizedBox(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: logic.getNotificationModel?.notification?.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return NotificationListItemView(index: index);
                      },
                    ).paddingOnly(bottom: 10),
                  );
      },
    );
  }
}

/// =================== List Item View =================== ///
class NotificationListItemView extends StatelessWidget {
  final int index;

  const NotificationListItemView({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationController>(
      id: Constant.idGetNotification,
      builder: (logic) {
        DateTime parsedDate =
            DateFormat("M/dd/yyyy, HH:mm:ss a").parse(logic.getNotificationModel?.notification?[index].date?.toUpperCase() ?? "");
        logic.time = DateFormat("h:mm a").format(parsedDate);

        return Container(
          width: Get.width,
          margin: const EdgeInsets.only(left: 13, right: 13, top: 12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.categoryCircle,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: AppColors.title.withOpacity(0.05),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    logic.getNotificationModel?.notification?[index].title ?? "",
                    style: AppFontStyle.fontStyleW700(
                      fontSize: 15,
                      fontColor: AppColors.categoryText,
                    ),
                  ),
                  Text(
                    logic.time ?? "",
                    style: AppFontStyle.fontStyleW600(
                      fontSize: 10.5,
                      fontColor: AppColors.time,
                    ),
                  )
                ],
              ).paddingOnly(bottom: 6),
              Text(
                logic.getNotificationModel?.notification?[index].message ?? "",
                style: AppFontStyle.fontStyleW400(
                  fontSize: 11,
                  fontColor: AppColors.description,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
