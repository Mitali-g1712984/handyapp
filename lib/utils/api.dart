class ApiConstant {

  static const BASE_URL = "http://10.5.54.121:8080/";
  static const SECRET_KEY = "b02698ae4e9aaa419fc0e9c4e732ef0ccfd405d4149fadc03601f9076ea1f78b"; 

  /// =================== Customer =================== ///
  static const loginOrSignUpCustomer = "api/customer/customer/loginOrSignUp";
  static const getCustomerProfile = "api/customer/customer/getProfile?";
  static const checkCustomer = "api/customer/customer/checkCustomer"; 
  static const editCustomerProfile = "api/customer/customer/update?";
  static const deleteCustomerProfile = "api/customer/customer/deleteCustomerAccount?";

  /// =================== OTP =================== ///
  static const generateOtpForLogin = "api/customer/otp/generateOtpForlogin";
  static const generateOtpForPassword = "api/customer/otp/generateOtpForPassword";
  static const verifyOtp = "api/customer/otp/verifyOtp";
  static const setPassword = "api/customer/customer/setPassword";

  /// =================== Service =================== ///
  static const getService = "api/customer/service/RetriveService";

  /// =================== Add-ons =================== ///
  static const getServiceSpecificAddOns = "api/customer/agency/getServiceSpecificAddOns?";

  /// =================== Agency =================== ///
  static const getTopRatedAgency = "api/customer/agency/getTopPerformingAgencies?";
  static const getServiceWiseAgency = "api/customer/agency/retrieveServiceWiseAgencyList?";
  static const getFilterWiseAgency = "api/customer/agency/fetchAgenciesByFilter";
  static const getAgencyInfo = "api/customer/agency/fetchAgencyInfo?";

  /// =================== Favorite Agency =================== ///
  static const favoriteAgencyByCustomer = "api/customer/favorite/favoriteByCustomer?";
  static const getFavouriteAgency = "api/customer/favorite/fetchFavoritesList?";

  /// =================== Appointment =================== ///
  static const getAppointmentTimeModel = "api/customer/appointment/checkAppointmentIsValid?";
  static const createBookingByCustomer = "api/customer/appointment/bookingByCustomer";
  static const getAllAppointment = "api/customer/appointment/getAppointmentByCust?";
  static const cancelAppointment = "api/customer/appointment/cancelAppointmentByCust?";
  static const reScheduleAppointment = "api/customer/appointment/rescheduleAppointmentByCust?";
  static const getAppointmentInfo = "api/customer/appointment/appointmentInfoByCust?";
  static const getUpcomingAppointment = "api/customer/appointment/fetchUpcomingBookingsForCust?";

  /// =================== Banner =================== ///
  static const getBanner = "api/customer/banner/getBanner";

  /// =================== Provider =================== ///
  static const listAgencyBasedProviders = "api/customer/provider/listAgencyBasedProviders?";

  /// =================== Review =================== ///
  static const postReview = "api/customer/ratingReview/postReviewRating";
  static const getReview = "api/customer/ratingReview/getReviewOfProvider?";

  /// =================== Search =================== ///
  static const searchByCustomer = "api/customer/agency/filterResultsByCustomer";

  /// =================== Notification =================== ///
  static const getNotification = "api/customer/notification/notificationList?";
  static const clearAllNotification = "api/customer/notification/clearNotificationHistory?";

  /// =================== Chat =================== ///
  static const getChatList = "api/customer/chatTopic/getChatList?";
  static const getOldChat = "api/customer/chat/getOldChat?";
  static const createChatImage = "api/customer/chat/createChat";

  /// =================== Wallet =================== ///
  static const depositWallet = "api/customer/customer/depositeToWallet?";
  static const getWalletHistory = "api/customer/customer/walletHistoryByCust?";

  /// =================== Coupon =================== ///
  static const getCoupon = "api/customer/coupon/retriveCoupons?";
  static const getCouponAmount = "api/customer/coupon/retriveValidateCoupon?";

  /// =================== Complain or Suggestion =================== ///
  static const raiseComplain = "api/customer/complaintSuggestion/raiseCompOrSuggByCust";
  static const getComplain = "api/customer/complaintSuggestion/retriveCompOrSuggByCust?";

  /// =================== Setting =================== ///
  static const getSetting = "api/customer/setting/fetchCustomerSettings";

  /// =================== Stripe Payment =================== ///
  static const stripeUrl = "https://api.stripe.com/v1/payment_intents";
}
