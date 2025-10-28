import 'dart:convert';
import 'dart:developer';

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/place_type.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:handy/custom/app_bar/custom_app_bar.dart';
import 'package:handy/custom/dialog/app_maintenance_dialog.dart';
import 'package:handy/routes/app_routes.dart';
import 'package:handy/services/app_exception/app_exception.dart';
import 'package:handy/services/location_service/location_service.dart';
import 'package:handy/ui/history_screen/controller/history_screen_controller.dart';
import 'package:handy/ui/home_screen/controller/home_screen_controller.dart';
import 'package:handy/ui/profile_screen/controller/profile_screen_controller.dart';
import 'package:handy/ui/splash_screen/model/get_country_model.dart';
import 'package:handy/ui/splash_screen/model/get_setting_model.dart';
import 'package:handy/utils/api.dart';
import 'package:handy/utils/app_asset.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/constant.dart';
import 'package:handy/utils/enums.dart';
import 'package:handy/utils/font_style.dart';
import 'package:handy/utils/global_variables.dart';
import 'package:handy/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ChooseMapScreen extends StatefulWidget {
  final double? latLong;
  final double? latitude;
  final bool isDirect;

  const ChooseMapScreen({super.key, this.latLong, this.latitude, required this.isDirect});

  @override
  ChooseMapScreenState createState() => ChooseMapScreenState();
}

class ChooseMapScreenState extends State<ChooseMapScreen> {
  TextEditingController controller = TextEditingController();
  ProfileScreenController profileScreenController = Get.put(ProfileScreenController());
  HistoryScreenController historyScreenController = Get.put(HistoryScreenController());

  double? selectLatitude;
  double? selectLongitude;

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  Future<String?> getCityName(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        return placemarks.first.locality;
      }
    } catch (e) {
      log("Error getting city: $e");
    }
    return null;
  }

  GetCountryModel? getCountryModel;
  GetSettingModel? getSettingModel;

  onGetCountryApiCall() async {
    try {
      homeScreenController.isLoading = true;
      homeScreenController.update([Constant.idGetCountry, Constant.idGetCurrentLocation]);

      final url = Uri.parse("http://ip-api.com/json");
      final headers = {'Content-Type': 'application/json'};

      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        getCountryModel = GetCountryModel.fromJson(jsonResponse);
        country = getCountryModel?.country;
        countryCode = getCountryModel?.countryCode;
        log("The Country Name :: $country");
        log("The Country Code :: $countryCode");
      }
    } catch (e) {
      log("Error call Get Country Api :: $e");
    } finally {
      homeScreenController.isLoading = false;
      homeScreenController.update([Constant.idGetCountry, Constant.idGetCurrentLocation]);
    }
  }

  onGeSettingApiCall() async {
    try {
      homeScreenController.isLoading = true;
      homeScreenController.update([Constant.idGetSetting, Constant.idGetCurrentLocation]);

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.getSetting);
      log("Get Setting Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Get Setting Headers :: $headers");

      final response = await http.get(url, headers: headers);

      log("Get Setting Status Code :: ${response.statusCode}");
      log("Get Setting Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        getSettingModel = GetSettingModel.fromJson(jsonResponse);
      }

      log("Get Setting Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Get Setting Api :: $e");
    } finally {
      homeScreenController.isLoading = false;
      homeScreenController.update([Constant.idGetSetting, Constant.idGetCurrentLocation]);
    }
  }

  onApiCall() async {
    await onGetCountryApiCall();
    getDialCode();
    await onGeSettingApiCall();

    if (getSettingModel?.status == true) {
      zegoAppId = getSettingModel?.data?.zegoAppId;
      zegoAppSignIn = getSettingModel?.data?.zegoAppSignIn;
      stripeSecretKey = getSettingModel?.data?.stripeSecretKey;
      stripePublishKey = getSettingModel?.data?.stripePublishableKey;
      razorpayId = getSettingModel?.data?.razorPayId;
      flutterWaveKey = getSettingModel?.data?.flutterWaveKey;
      currency = getSettingModel?.data?.currency?.symbol;
      currencyName = getSettingModel?.data?.currency?.name;
      isRazorPay = getSettingModel?.data?.isRazorPay;
      isStripePay = getSettingModel?.data?.isStripe;
      isFlutterWave = getSettingModel?.data?.isFlutterWave;
      termsCondition = getSettingModel?.data?.termsOfUsePolicyLink;
      privacyPolicy = getSettingModel?.data?.privacyPolicyLink;

      log("Zego App Id :: $zegoAppId");
      log("Zego App SignIn :: $zegoAppSignIn");
      log("Stripe Secret Key :: $stripeSecretKey");
      log("Stripe Publish Key :: $stripePublishKey");
      log("Razorpay Id :: $razorpayId");
      log("Flutter Wave Key :: $flutterWaveKey");
      log("Currency :: $currency");
      log("Currency Name :: $currencyName");
      log("Is Razor Pay :: $isRazorPay");
      log("Is Stripe Pay :: $isStripePay");
      log("Is Flutter Wave :: $isFlutterWave");
      log("Terms & Condition :: $termsCondition");
      log("Privacy Policy :: $privacyPolicy");

      if (getSettingModel?.data?.isUnderMaintenance == true) {
        Get.dialog(
          barrierColor: AppColors.black.withOpacity(0.8),
          barrierDismissible: false,
          Dialog(
            backgroundColor: AppColors.transparent,
            shadowColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            child: const AppMaintenanceDialog(),
          ),
        );
      } else {
        profileScreenController.getCustomerProfileApiCall();

        if (profileScreenController.getCustomerProfileModel?.status == true) {
          Constant.storage.write("customerId", profileScreenController.getCustomerProfileModel?.customer?.id);
          Constant.storage.write("customerName", profileScreenController.getCustomerProfileModel?.customer?.name);
          Constant.storage.write("customerEmail", profileScreenController.getCustomerProfileModel?.customer?.email);
          Constant.storage.write("customerImage", profileScreenController.getCustomerProfileModel?.customer?.profileImage);
          Constant.storage.write("mobileNumber", profileScreenController.getCustomerProfileModel?.customer?.mobileNumber);

          await historyScreenController.getWalletHistoryApiCall(
            customerId: Constant.storage.read('customerId'),
            month: DateFormat('yyyy-MM').format(DateTime.now()),
            start: "1",
            limit: "20",
          );

          if (historyScreenController.getWalletHistoryModel?.status == true) {
            Constant.storage.write("walletAmount", historyScreenController.getWalletHistoryModel?.total?.toStringAsFixed(2));
            log("Wallet Amount :: ${Constant.storage.read("walletAmount")}");
          }

          Constant.storage.write("walletAmount", historyScreenController.getWalletHistoryModel?.total?.toStringAsFixed(2));
          log("Wallet Amount :: ${Constant.storage.read("walletAmount")}");
        }

        Future.delayed(const Duration(seconds: 3), () async {
          if (Constant.storage.read("isUpdate") == false) {
            Get.toNamed(AppRoutes.editProfile, arguments: [
              profileScreenController.getCustomerProfileModel?.customer?.name,
              profileScreenController.getCustomerProfileModel?.customer?.email,
              profileScreenController.getCustomerProfileModel?.customer?.mobileNumber,
              profileScreenController.getCustomerProfileModel?.customer?.country,
              profileScreenController.getCustomerProfileModel?.customer?.gender,
            ]);
          } else {
            if (Constant.storage.read("isOnBoarding") == true) {
              if (Constant.storage.read("isLogIn") == true) {
                Get.offAllNamed(AppRoutes.bottom);
              } else {
                Get.offAllNamed(AppRoutes.main);
              }
            } else {
              Get.offAllNamed(AppRoutes.onBoarding);
            }
          }
        });
      }
    } else {
      Utils.showToast(Get.context!, getSettingModel?.message ?? "");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: CustomAppBar(
          title: "Choose your Location",
          showLeadingIcon: true,
        ),
        elevation: 0,
      ),
      body: GetBuilder<HomeScreenController>(
        id: Constant.idGetLocation,
        builder: (logic) {
          return Stack(
            children: [
              GoogleMap(
                markers: Set<Marker>.from(markers),
                initialCameraPosition: initialLocation,
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                mapType: MapType.hybrid,
                zoomGesturesEnabled: true,
                zoomControlsEnabled: false,
                onMapCreated: (GoogleMapController controller) {
                  mapController = controller;
                },
                onTap: onHandleTapPoint,
              ),
              SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipOval(
                      child: Material(
                        color: AppColors.primaryAppColor1,
                        child: InkWell(
                          splashColor: AppColors.primaryAppColor1,
                          child: Icon(
                            Icons.add,
                            size: 25,
                            color: AppColors.checkButton,
                          ).paddingAll(10),
                          onTap: () {
                            mapController.animateCamera(CameraUpdate.zoomIn());
                          },
                        ),
                      ),
                    ).paddingOnly(bottom: 10),
                    ClipOval(
                      child: Material(
                        color: AppColors.primaryAppColor1,
                        child: InkWell(
                          splashColor: AppColors.primaryAppColor1,
                          child: Icon(
                            Icons.remove,
                            size: 25,
                            color: AppColors.checkButton,
                          ).paddingAll(10),
                          onTap: () {
                            mapController.animateCamera(CameraUpdate.zoomOut());
                          },
                        ),
                      ),
                    ).paddingOnly(bottom: 10),
                  ],
                ).paddingOnly(left: 10),
              ),
              Positioned(
                right: 15,
                left: 15,
                top: 15,
                child: GooglePlaceAutoCompleteTextField(
                  textEditingController: controller,
                  googleAPIKey: "AIzaSyAhgRhzU7kGnLRFJ-qgLXsHj3nGiecMQzw",
                  focusNode: FocusScopeNode().focusedChild,
                  inputDecoration: InputDecoration(
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
                      borderSide: BorderSide(color: AppColors.primaryAppColor1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: AppColors.primaryAppColor1),
                    ),
                    fillColor: AppColors.categoryCircle,
                    filled: true,
                    hintText: "Search here...",
                    hintStyle: AppFontStyle.fontStyleW500(
                      fontSize: 14,
                      fontColor: AppColors.degreeText,
                    ),
                    suffixIcon: InkWell(
                      onTap: () {
                        controller.clear();
                      },
                      child: Container(
                        child: Image.asset(
                          AppAsset.icClose,
                          height: 20,
                        ).paddingAll(9),
                      ),
                    ),
                  ),
                  textStyle: AppFontStyle.fontStyleW500(
                    fontSize: 15,
                    fontColor: AppColors.primaryAppColor1,
                  ),
                  debounceTime: 800,
                  isLatLngRequired: true,
                  getPlaceDetailWithLatLng: (Prediction prediction) async {
                    log("prediction.lng :: ${prediction.lng}");
                    log("prediction.lat :: ${prediction.lat}");
                    log("prediction.description :: ${prediction.description}");

                    controller.text = prediction.description!;

                    finalAddress = controller.text;
                    log("finalAddress = controller.text :: $finalAddress");

                    controller.selection = TextSelection.fromPosition(TextPosition(offset: prediction.description?.length ?? 0));

                    String pointLatLng = "${prediction.lat}, ${prediction.lng}";

                    selectLatitude = double.parse(prediction.lat ?? "");
                    selectLongitude = double.parse(prediction.lng ?? "");

                    String? city = await getCityName(selectLatitude ?? 0.0, selectLongitude ?? 0.0);
                    log("User's Current City: $city");

                    Constant.storage.write("currentCity", city);

                    log("selectLatitude :: $selectLatitude");
                    log("selectLongitude :: $selectLongitude");

                    markers.clear();
                    markers.add(
                      Marker(
                        markerId: MarkerId(pointLatLng),
                        position: LatLng(double.parse(prediction.lat ?? ""), double.parse(prediction.lng ?? "")),
                        infoWindow: InfoWindow(title: 'Start $currentAddress', snippet: destinationAddress),
                        icon: BitmapDescriptor.defaultMarker,
                      ),
                    );

                    mapController.animateCamera(
                      CameraUpdate.newCameraPosition(
                        CameraPosition(
                          target: LatLng(double.parse(prediction.lat ?? ""), double.parse(prediction.lng ?? "")),
                          zoom: 18.0,
                        ),
                      ),
                    );

                    logic.update([Constant.idGetLocation]);
                  },
                  itemClick: (Prediction prediction) {
                    if (prediction.lat == null || prediction.lng == null || prediction.lat!.isEmpty || prediction.lng!.isEmpty) {
                      log("Invalid latitude or longitude: lat=${prediction.lat}, lng=${prediction.lng}");
                      return;
                    }
                    final double? lat = double.tryParse(prediction.lat!);
                    final double? lng = double.tryParse(prediction.lng!);

                    if (lat == null || lng == null) {
                      log("Failed to parse latitude or longitude: lat=${prediction.lat}, lng=${prediction.lng}");
                      return;
                    }
                  },
                  itemBuilder: (context, index, Prediction prediction) {
                    return Row(
                      children: [
                        const Icon(Icons.location_on),
                        const SizedBox(
                          width: 7,
                        ),
                        Expanded(child: Text(prediction.description ?? ""))
                      ],
                    );
                  },
                  seperatedBuilder: const Divider(),
                  isCrossBtnShown: false,
                  boxDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  placeType: PlaceType.geocode,
                ),
              ),
              Positioned(
                right: 0,
                left: 0,
                bottom: 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ClipOval(
                      child: Material(
                        color: AppColors.primaryAppColor1,
                        child: InkWell(
                          splashColor: AppColors.primaryAppColor1,
                          onTap: () async {
                            await getUserLocationPosition().then((value) async {
                              double lat = value.latitude;
                              double lng = value.longitude;

                              String? city = await getCityName(lat, lng);
                              log("User's Current City: $city");

                              Constant.storage.write("currentCity", city);

                              mapController.animateCamera(
                                CameraUpdate.newCameraPosition(
                                  CameraPosition(
                                    target: LatLng(value.latitude, value.longitude),
                                    zoom: 18.0,
                                  ),
                                ),
                              );

                              onHandleTapPoint(
                                LatLng(value.latitude, value.longitude),
                              );
                            });
                          },
                          child: Icon(
                            Icons.my_location,
                            size: 25,
                            color: AppColors.checkButton,
                          ).paddingAll(10),
                        ),
                      ),
                    ).paddingOnly(bottom: 15),
                    BlurryContainer(
                      height: Get.height * 0.17,
                      width: Get.width,
                      blur: 4,
                      elevation: 0,
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            height: Get.height * 0.09,
                            width: Get.width,
                            decoration: BoxDecoration(
                              color: AppColors.categoryCircle,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.only(top: 5, left: 8, right: 7, bottom: 5),
                            margin: const EdgeInsets.only(bottom: 10),
                            child: SingleChildScrollView(
                              child: Text(
                                finalAddress ?? "",
                                style: AppFontStyle.fontStyleW600(
                                  fontSize: 15,
                                  fontColor: AppColors.title,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              String? city = await getCityName(
                                selectLatitude ?? Constant.storage.read("latitude"),
                                selectLongitude ?? Constant.storage.read("longitude"),
                              );
                              log("User's Current City: $city");

                              Constant.storage.write("latitude", selectLatitude);
                              Constant.storage.write("longitude", selectLongitude);

                              setState(() {
                                Constant.storage.write("userAddress", finalAddress);
                              });
                              Constant.storage.write("currentCity", city);

                              log("Select User Address :: ${Constant.storage.read("userAddress")}");
                              log("Select User City :: ${Constant.storage.read("currentCity")}");

                              setState(() {
                                Constant.storage.write("userAddress", finalAddress);
                                logic.update([Constant.idGetLocation]);
                              });

                              widget.isDirect == true ? await onApiCall() : Get.back();

                              logic.update([Constant.idGetLocation]);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 12),
                              decoration: BoxDecoration(
                                color: AppColors.primaryAppColor1,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                EnumLocale.txtContinue.name.tr,
                                style: AppFontStyle.fontStyleW500(
                                  fontSize: 15,
                                  fontColor: AppColors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ).paddingOnly(left: 15, right: 15, bottom: 5),
              ),
            ],
          );
        },
      ),
    );
  }
}
