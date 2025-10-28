import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:handy/utils/app_asset.dart';
import 'package:handy/utils/app_color.dart';

class Constant {
  /// =================== Id For Refresh Widgets =================== ///
  static var idBottomBar = 'idBottomBar';
  static var idServiceSaved = 'idServiceSaved';
  static var idEditServiceSaved = 'idEditServiceSaved';
  static var idCategoryProviderSaved = 'idCategoryDoctorSaved';
  static var idTopSpecialistSaved = 'idTopSpecialistSaved';
  static var idSpecialistSaved = 'idSpecialistSaved';
  static var idGenderSelect = 'idGenderSelect';
  static var idRegGenderSelect = 'idRegGenderSelect';
  static var idRatingSelect = 'idRatingSelect';
  static var idSelectService = 'idSelectService';
  static var idSelectLocation = 'idSelectLocation';
  static var idApplyFilter = 'idApplyFilter';
  static var idSelectAmount = 'idSelectAmount';
  static var idMoneyOffer = 'idMoneyOffer ';
  static var idApplyCoupon = 'idApplyCoupon';
  static var idSelectAppointmentType = 'idSelectAppointmentType';
  static var idAppointmentType = 'idAppointmentType';
  static var idPickImage = 'idPickImage';
  static var idRemoveImage = 'idRemoveImage';
  static var idSelectCountry = 'idSelectCountry';
  static var idSelectPatient = 'idSelectPatient';
  static var idSelectBirthDate = 'idSelectBirthDate';
  static var idPatientImage = 'idPatientImage';
  static var idEditImage = 'idEditImage';
  static var idChatImage = 'idChatImage';
  static var idChatVideo = 'idChatVideo';
  static var idChatCameraPhoto = 'idChatCameraPhoto';
  static var idSpeakerOpen = 'idSpeakerOpen';
  static var idMicMute = 'idMicMute';
  static var idVideoTurn = 'idVideoTurn';
  static var idSelectStar = 'idSelectStar';
  static var idSwitchOn = 'idSwitchOn';
  static var idSelectDateRange = 'idSelectDateRange';
  static var idSelectPayment = 'idSelectPayment';
  static var idChangeLanguage = 'idChangeLanguage';
  static var idSelectMonth = 'idSelectMonth';
  static var idOnBoarding = 'idOnBoarding';
  static var idComplainImage = 'idComplainImage';
  static var idUpdateSlots = 'idUpdateSlots';
  static var idServiceSelected = 'idServiceSelected';
  static var idSelectType = 'idSelectType';
  static var idVideoPlay = 'idVideoPlay';
  static var idVideoCall = 'idVideoCall';
  static var idNotification = 'idNotification';
  static var idGetLocation = 'idGetLocation';
  static var idSelectSortBy = 'idSelectSortBy';
  static var idGetCurrentLocation = 'idGetCurrentLocation';

  /// =================== Id For Refresh API`s Response =================== ///
  static var idCheckMobile = 'idCheckMobile';
  static var idVerification = 'idVerification';
  static var idGetCountry = 'idGetCountry';
  static var idGetSetting = 'idGetSetting';
  static var idLoginOrSignUp = 'idLoginOrSignUp';
  static var idGetCustomerProfile = 'idGetCustomerProfile';
  static var idDeleteCustomerProfile = 'idDeleteCustomerProfile';
  static var idCheckCustomer = 'idCheckCustomer';
  static var idEditCustomer = 'idEditCustomer';
  static var idSetEditCustomerData = 'idSetEditCustomerData';
  static var idGenerateOtpForLogin = 'idGenerateOtpForLogin';
  static var idGenerateOtpForPassword = 'idGenerateOtpForPassword';
  static var idSetPassword = 'idSetPassword';
  static var idVerifyOTP = 'idVerifyOTP';
  static var idGetService = 'idGetService';
  static var idGetBanner = 'idGetBanner';
  static var idGetTopRatedAgency = 'idGetTopRatedAgency';
  static var idFavouriteAgencyByCustomer = 'idFavouriteAgencyByCustomer';
  static var idGetServiceWiseAgency = 'idGetServiceWiseAgency';
  static var idGetFavouriteAgency = 'idGetFavouriteAgency';
  static var idGetAgencyInfo = 'idGetAgencyInfo';
  static var idGetAppointmentTime = 'idGetAppointmentTime';
  static var idCreateBookingByCustomer = 'idCreateBookingByCustomer';
  static var idGetCoupon = 'idGetCoupon';
  static var idGetCouponAmount = 'idGetCouponAmount';
  static var idAddCouponAmount = 'idAddCouponAmount';
  static var idGetAllAppointment = 'idGetAllAppointment';
  static var idCancelAppointment = 'idDeleteAppointment';
  static var idReScheduleAppointment = 'idReScheduleAppointment';
  static var idGetAppointmentInfo = 'idGetAppointmentInfo';
  static var idRaiseComplain = 'idRaiseComplain';
  static var idGetComplain = 'idGetComplain';
  static var idDepositWallet = 'idDepositWallet';
  static var idGetWalletHistory = 'idGetWalletHistory';
  static var idSearchByCustomer = 'idSearchByCustomer';
  static var idGetFilterWiseAgency = 'idGetFilterWiseAgency';
  static var idGetChatList = 'idGetChatList';
  static var idGetOldChat = 'idGetOldChat';
  static var idGetNotification = 'idGetNotification';
  static var idClearAllNotification = 'idClearAllNotification';
  static var idPostReview = 'idPostReview';
  static var idGetReview = 'idGetReview';
  static var idGetProviderService = 'idGetProviderService';
  static var idGetUpcomingAppointment = 'idGetUpcomingAppointment';
  static var idGetCallEnableOrNot = 'idGetCallEnableOrNot';
  static var idAcceptTerms = 'idAcceptTerms';
  static var idGetAgencyWiseProvider = 'idGetAgencyWiseProvider';

  /// =================== Get Storage (Local Storage) =================== ///
  static final storage = GetStorage();

  /// =================== Localization =================== ///
  static const languageEn = "en";
  static const countryCodeEn = "US";

  /// =================== Stripe Merchant =================== ///
  static const stripeMerchantCountryCode = 'IN';

  /// =================== Country Name List =================== ///
  static List countryList = [
    {"country": "Arabic", "image": AppAsset.imPakistan, "id": "1"},
    {"country": "Bengali", "image": AppAsset.imIndia, "id": "2"},
    {"country": "Chinese", "image": AppAsset.imChinese, "id": "3"},
    {"country": "English", "image": AppAsset.imEnglish, "id": "4"},
    {"country": "French", "image": AppAsset.imFrench, "id": "5"},
    {"country": "German", "image": AppAsset.imGerman, "id": "6"},
    {"country": "Hindi", "image": AppAsset.imIndia, "id": "7"},
    {"country": "Italian", "image": AppAsset.imItalian, "id": "8"},
    {"country": "Indonesian", "image": AppAsset.imIndonesian, "id": "9"},
    {"country": "Korean", "image": AppAsset.imKorean, "id": "10"},
    {"country": "Portuguese", "image": AppAsset.imPortuguese, "id": "11"},
    {"country": "Russian", "image": AppAsset.imRussian, "id": "12"},
    {"country": "Spanish", "image": AppAsset.imSpanish, "id": "13"},
    {"country": "Swahili", "image": AppAsset.imSwahili, "id": "14"},
    {"country": "Turkish", "image": AppAsset.imTurkish, "id": "15"},
    {"country": "Telugu", "image": AppAsset.imIndia, "id": "16"},
    {"country": "Tamil", "image": AppAsset.imIndia, "id": "17"},
    {"country": "Urdu", "image": AppAsset.imPakistan, "id": "18"},
  ];

  /// =================== Shimmers =================== ///
  static Color baseColor = AppColors.shimmerGrey.withOpacity(0.6);
  static Color highlightColor = Colors.grey.withOpacity(0.2);
  static Duration period = const Duration(milliseconds: 500);
}
