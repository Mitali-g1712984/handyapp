import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/custom/app_button/primary_app_button.dart';
import 'package:handy/ui/on_boarding_screen/controller/on_boarding_controller.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/constant.dart';
import 'package:handy/utils/font_style.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryAppColor1,
      child: GetBuilder<OnBoardingController>(
        id: Constant.idOnBoarding,
        builder: (logic) {
          return Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: logic.pageController,
                      onPageChanged: (int page) {
                        logic.onPageChanged(page: page);
                      },
                      itemCount: logic.title.length,
                      itemBuilder: (context, index) {
                        return OnboardingItemView(
                          title: logic.title[index],
                          image: logic.image[index],
                        );
                      },
                    ),
                  ),
                  Container(
                    width: Get.width,
                    color: AppColors.white,
                    child: Column(
                      children: [
                        const SizedBox(height: 25),
                        SmoothPageIndicator(
                          controller: logic.pageController,
                          count: logic.title.length,
                          effect: ExpandingDotsEffect(
                            spacing: 5,
                            radius: 10,
                            dotWidth: 7,
                            dotHeight: 5,
                            paintStyle: PaintingStyle.fill,
                            strokeWidth: 1,
                            dotColor: AppColors.tabUnselectText.withOpacity(0.3),
                            activeDotColor: AppColors.primaryAppColor1,
                          ),
                        ),
                        const SizedBox(height: 30),
                        GetBuilder<OnBoardingController>(
                          id: Constant.idOnBoarding,
                          builder: (logic) {
                            return PrimaryAppButton(
                              onTap: () {
                                logic.onPageScroll(currentPage: logic.currentPage);
                              },
                              height: Get.height * 0.065,
                              width: Get.width * 0.92,
                              borderRadius: 12,
                              color: AppColors.appButton,
                              text: logic.currentPage == 2 ? 'Get Started' : 'Next',
                              textStyle: AppFontStyle.fontStyleW800(
                                fontSize: 20,
                                fontColor: AppColors.primaryAppColor1,
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 25),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 130,
                child: Container(
                  height: 20,
                  width: Get.width,
                  color: AppColors.white,
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

class OnboardingItemView extends StatelessWidget {
  final String title;
  final String image;

  const OnboardingItemView({
    super.key,
    required this.title,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Image.asset(image, height: 365),
        Container(
          height: Get.height * 0.26,
          width: Get.width,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(45),
              topRight: Radius.circular(45),
            ),
          ),
          child: Text(
            title,
            style: AppFontStyle.fontStyleW900(
              fontSize: 35,
              fontColor: AppColors.primaryAppColor1,
            ),
            textAlign: TextAlign.center,
          ).paddingAll(20),
        ),
      ],
    );
  }
}
