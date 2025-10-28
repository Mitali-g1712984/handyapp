import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/custom/app_button/primary_app_button.dart';
import 'package:handy/ui/confirm_booking_screen/controller/confirm_booking_controller.dart';
import 'package:handy/utils/app_asset.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/constant.dart';
import 'package:handy/utils/enums.dart';
import 'package:handy/utils/font_style.dart';
import 'package:handy/utils/global_variables.dart';

class PaymentBottomSheet extends StatelessWidget {
  final bool isRecharge;

  const PaymentBottomSheet({super.key, required this.isRecharge});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ConfirmBookingController>(
      id: Constant.idMoneyOffer,
      builder: (logic) {
        List amount = [
          EnumLocale.txtAmount.name.tr,
          EnumLocale.txtDiscount.name.tr,
        ];

        return Container(
          height: logic.getCouponModel?.data?.isEmpty == true
              ? Get.height * 0.6
              : logic.applyCoupon == -1
                  ? Get.height * 0.73
                  : Get.height * 0.82,
          width: Get.width,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(35),
              topRight: Radius.circular(35),
            ),
            color: AppColors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
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
                      isRecharge == true ? EnumLocale.txtRechargeWallet.name.tr : EnumLocale.txtInsufficientBalance.name.tr,
                      style: AppFontStyle.fontStyleW800(
                        fontSize: 19,
                        fontColor: AppColors.white,
                      ),
                    ).paddingOnly(left: 8),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: SizedBox(
                        width: 45,
                        child: Image.asset(
                          AppAsset.icClose,
                          height: Get.height * 0.07,
                          width: Get.width * 0.07,
                        ).paddingOnly(right: 15),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        EnumLocale.txtAddMoney.name.tr,
                        style: AppFontStyle.fontStyleW900(
                          fontSize: 20,
                          fontColor: AppColors.appButton,
                        ),
                      ).paddingOnly(top: 10, left: 12.5),
                      Text(
                        EnumLocale.desEnoughFundsWallet.name.tr,
                        style: AppFontStyle.fontStyleW400(
                          fontSize: 13,
                          fontColor: AppColors.categoryText,
                        ),
                      ).paddingOnly(top: 5, left: 12.5),
                      Row(
                        children: [
                          SizedBox(
                            height: Get.height * 0.065,
                            width: Get.width * 0.05,
                            child: Center(
                              child: Text(
                                currency ?? "",
                                style: AppFontStyle.fontStyleW500(
                                  fontSize: 37,
                                  fontColor: AppColors.primaryAppColor1,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: Get.height * 0.065,
                              width: Get.width,
                              padding: const EdgeInsets.only(bottom: 32),
                              child: TextFormField(
                                controller: logic.currencyController,
                                onChanged: (text) {
                                  logic.printLatestValue(text: text.trim().toString());
                                  return;
                                },
                                cursorColor: AppColors.bottomTitle,
                                style: AppFontStyle.fontStyleW500(
                                  fontSize: 37,
                                  fontColor: AppColors.appButton,
                                ),
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(color: AppColors.transparent),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(color: AppColors.transparent),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(color: AppColors.transparent),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(12),
                                      bottomRight: Radius.circular(12),
                                    ),
                                    borderSide: BorderSide(color: AppColors.transparent),
                                  ),
                                ),
                              ),
                            ).paddingOnly(right: 15),
                          )
                        ],
                      ).paddingOnly(top: 10, bottom: 5, left: 10),
                      Text(
                        EnumLocale.desRechargeForBooking.name.tr,
                        style: AppFontStyle.fontStyleW400(
                          fontSize: 13,
                          fontColor: AppColors.categoryText,
                        ),
                      ).paddingOnly(top: 5, left: 12.5),
                      Divider(height: 1.2, color: AppColors.bottomSheetDivider).paddingOnly(top: 7),
                      Text(
                        EnumLocale.txtSelectDirectAmount.name.tr,
                        style: AppFontStyle.fontStyleW900(
                          fontSize: 16,
                          fontColor: AppColors.appButton,
                        ),
                      ).paddingOnly(top: 10, bottom: 5, left: 12.5),
                      SizedBox(
                        height: Get.height * 0.065,
                        child: GetBuilder<ConfirmBookingController>(
                          id: Constant.idSelectAmount,
                          builder: (logic) {
                            return ListView.builder(
                              itemCount: logic.directAmount.length,
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    logic.onSelectAmount(index);

                                    ///----TODO
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: logic.selectAmountIndex == index ? AppColors.appButton : AppColors.divider,
                                    ),
                                    padding: const EdgeInsets.only(left: 15, right: 15),
                                    margin: const EdgeInsets.only(bottom: 2.5, right: 10, top: 10),
                                    child: Center(
                                      child: Text(
                                        logic.directAmount[index],
                                        style: AppFontStyle.fontStyleW700(
                                          fontSize: 15,
                                          fontColor:
                                              logic.selectAmountIndex == index ? AppColors.white : AppColors.tabUnselectText,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ).paddingOnly(left: 12.5),
                      logic.getCouponModel?.data?.isEmpty == true || logic.applyCoupon == -1
                          ? const SizedBox()
                          : Container(
                              height: 185,
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  width: 0.7,
                                  color: AppColors.primaryAppColor1,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height: 45,
                                    width: Get.width,
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryAppColor1,
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(14),
                                        topRight: Radius.circular(14),
                                      ),
                                    ),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        EnumLocale.txtPaymentDescription.name.tr,
                                        style: AppFontStyle.fontStyleW800(
                                          fontSize: 15,
                                          fontColor: AppColors.white,
                                        ),
                                      ).paddingOnly(left: 15),
                                    ),
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                      physics: const NeverScrollableScrollPhysics(),
                                      padding: EdgeInsets.zero,
                                      itemCount: amount.length,
                                      scrollDirection: Axis.vertical,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          height: 45,
                                          decoration: BoxDecoration(
                                            color: index.isOdd ? AppColors.paymentDes1 : AppColors.paymentDes,
                                          ),
                                          margin: const EdgeInsets.only(bottom: 3),
                                          padding: const EdgeInsets.only(left: 15, right: 15),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                amount[index],
                                                overflow: TextOverflow.ellipsis,
                                                style: AppFontStyle.fontStyleW600(
                                                  fontSize: 14,
                                                  fontColor: AppColors.categoryText,
                                                ),
                                              ),
                                              Text(
                                                "$currency ${logic.priceList[index]}",
                                                style: AppFontStyle.fontStyleW900(
                                                  fontSize: 15,
                                                  fontColor: AppColors.appButton,
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    ).paddingOnly(top: 3, bottom: 3),
                                  ),
                                  Container(
                                    height: 43,
                                    width: Get.width,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                        bottomRight: Radius.circular(14),
                                        bottomLeft: Radius.circular(14),
                                      ),
                                      color: AppColors.primaryAppColor1,
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          EnumLocale.txtTotalPayableAmount.name.tr,
                                          style: AppFontStyle.fontStyleW600(
                                            fontSize: 14,
                                            fontColor: AppColors.white,
                                          ),
                                        ),
                                        Text(
                                          "$currency ${logic.finalAmountAfterCoupon}",
                                          style: AppFontStyle.fontStyleW900(
                                            fontSize: 15,
                                            fontColor: AppColors.white,
                                          ),
                                        )
                                      ],
                                    ).paddingOnly(left: 15, right: 15),
                                  ),
                                ],
                              ),
                            ).paddingOnly(left: 15, right: 15, top: 10),
                      GetBuilder<ConfirmBookingController>(
                        id: Constant.idMoneyOffer,
                        builder: (logic) {
                          return logic.getCouponModel?.data?.isEmpty == true
                              ? const SizedBox()
                              : Text(
                                  EnumLocale.txtAddMoneyOffer.name.tr,
                                  style: AppFontStyle.fontStyleW900(
                                    fontSize: 16,
                                    fontColor: AppColors.appButton,
                                  ),
                                ).paddingOnly(top: 12, bottom: 12, left: 12.5);
                        },
                      ),
                      GetBuilder<ConfirmBookingController>(
                        id: Constant.idMoneyOffer,
                        builder: (logic) {
                          return logic.getCouponModel?.data?.isEmpty == true
                              ? const SizedBox()
                              : SizedBox(
                                  height: Get.height * 0.18,
                                  child: ListView.builder(
                                    itemCount: logic.getCouponModel?.data?.length ?? 0,
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    physics: const AlwaysScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      final enteredAmount = double.tryParse(logic.currencyController.text) ?? 0;
                                      final couponMinAmount = logic.getCouponModel?.data?[index].minAmountToApply ?? 0;
                                      final isEligible = enteredAmount >= couponMinAmount;

                                      return GestureDetector(
                                        onTap: () {
                                          logic.onMoneyOffer(index);
                                        },
                                        child: Opacity(
                                          opacity: isEligible ? 1.0 : 0.7,
                                          child: Container(
                                            width: Get.width * 0.83,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                  logic.applyCoupon == index ? AppAsset.imSelectCouponBox : AppAsset.imCouponBox,
                                                ),
                                                fit: BoxFit.fill,
                                              ),
                                              borderRadius: BorderRadius.circular(16),
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    SizedBox(
                                                      width: Get.width * 0.6,
                                                      child: Text(
                                                        logic.getCouponModel?.data?[index].title ?? "",
                                                        overflow: TextOverflow.ellipsis,
                                                        style: AppFontStyle.fontStyleW800(
                                                          fontSize: 21,
                                                          fontColor: logic.applyCoupon == index
                                                              ? AppColors.primaryAppColor1
                                                              : AppColors.appButton,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                                      decoration: BoxDecoration(
                                                        color: logic.applyCoupon == index
                                                            ? AppColors.primaryAppColor1
                                                            : AppColors.couponBox,
                                                        borderRadius: BorderRadius.circular(5),
                                                      ),
                                                      child: RichText(
                                                        text: TextSpan(
                                                          text: '${EnumLocale.txtOfferValidity.name.tr}  ',
                                                          style: AppFontStyle.fontStyleW700(
                                                            fontSize: 13,
                                                            fontColor: logic.applyCoupon == index
                                                                ? AppColors.appButton
                                                                : AppColors.white,
                                                          ),
                                                          children: [
                                                            TextSpan(
                                                              text: logic.getCouponModel?.data?[index].expiryDate ?? "",
                                                              style: AppFontStyle.fontStyleW900(
                                                                fontSize: 13,
                                                                fontColor: logic.applyCoupon == index
                                                                    ? AppColors.appButton
                                                                    : AppColors.white,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 1),
                                                    SizedBox(
                                                      width: Get.width * 0.5,
                                                      child: Text(
                                                        logic.getCouponModel?.data?[index].description ?? "",
                                                        maxLines: 2,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: AppFontStyle.fontStyleW700(
                                                          fontSize: 12,
                                                          fontColor: logic.applyCoupon == index
                                                              ? AppColors.white
                                                              : AppColors.appButton.withOpacity(0.5),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: Get.width * 0.62,
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            "Max Discount: ",
                                                            style: AppFontStyle.fontStyleW500(
                                                              fontSize: 12,
                                                              fontColor: logic.applyCoupon == index
                                                                  ? AppColors.white
                                                                  : AppColors.appButton.withOpacity(0.5),
                                                            ),
                                                          ).paddingOnly(right: 5),
                                                          Text(
                                                            "$currency${logic.getCouponModel?.data?[index].maxDiscount.toString()}",
                                                            style: AppFontStyle.fontStyleW600(
                                                              fontSize: 13,
                                                              fontColor: logic.applyCoupon == index
                                                                  ? AppColors.white
                                                                  : AppColors.appButton.withOpacity(0.5),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ).paddingOnly(top: 13, bottom: 13, left: 28),
                                                Container(
                                                  height: 22,
                                                  width: 22,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: logic.applyCoupon == index ? AppColors.white : AppColors.appButton,
                                                      width: 1.3,
                                                    ),
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: logic.applyCoupon == index
                                                      ? Container(
                                                          height: 21,
                                                          width: 21,
                                                          decoration: BoxDecoration(
                                                            color: AppColors.primaryAppColor1,
                                                            shape: BoxShape.circle,
                                                          ),
                                                          child: Image.asset(AppAsset.icCheck).paddingAll(5),
                                                        )
                                                      : const SizedBox.shrink(),
                                                ).paddingOnly(right: Get.width * 0.08),
                                              ],
                                            ),
                                          ).paddingOnly(left: 12.5, bottom: 10),
                                        ),
                                      );
                                    },
                                  ).paddingOnly(right: 12),
                                );
                        },
                      ),
                      const SizedBox(height: 15), // Optional bottom spacing
                    ],
                  ),
                ),
              ),
              GetBuilder<ConfirmBookingController>(
                builder: (logic) {
                  return PrimaryAppButton(
                    onTap: () {
                      logic.onRechargeClick();
                    },
                    height: Get.height * 0.065,
                    width: Get.width * 0.93,
                    text: EnumLocale.txtRechargeNow.name.tr,
                    textStyle: AppFontStyle.fontStyleW800(
                      fontSize: 17,
                      fontColor: AppColors.primaryAppColor1,
                    ),
                  ).paddingOnly(left: 12.5, bottom: 15);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
