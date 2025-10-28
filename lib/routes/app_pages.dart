import 'package:get/get.dart';
import 'package:handy/routes/app_routes.dart';
import 'package:handy/ui/History_screen/binding/history_screen_binding.dart';
import 'package:handy/ui/History_screen/view/history_screen.dart';
import 'package:handy/ui/apply_coupon_screen/binding/apply_coupon_binding.dart';
import 'package:handy/ui/apply_coupon_screen/view/apply_coupon_screen.dart';
import 'package:handy/ui/appointment_screen/binding/appointment_screen_binding.dart';
import 'package:handy/ui/appointment_screen/view/appointment_screen.dart';
import 'package:handy/ui/booking_information_screen/binding/booking_information_binding.dart';
import 'package:handy/ui/booking_information_screen/view/booking_information_screen.dart';
import 'package:handy/ui/booking_screen/binding/booking_screen_binding.dart';
import 'package:handy/ui/booking_screen/view/booking_screen.dart';
import 'package:handy/ui/bottom_bar/binding/bottom_bar_binding.dart';
import 'package:handy/ui/bottom_bar/view/bottom_bar_screen.dart';
import 'package:handy/ui/call_connect_screen/binding/call_connect_binding.dart';
import 'package:handy/ui/call_connect_screen/view/call_connect_screen.dart';
import 'package:handy/ui/call_receive_screen/binding/call_receive_binding.dart';
import 'package:handy/ui/call_receive_screen/view/call_receive_screen.dart';
import 'package:handy/ui/device_location_screen/binding/device_location_binding.dart';
import 'package:handy/ui/device_location_screen/view/device_location_screen.dart';
import 'package:handy/ui/service_wise_agency_screen/binding/service_wise_agency_binding.dart';
import 'package:handy/ui/category_screen/binding/category_screen_binding.dart';
import 'package:handy/ui/category_screen/view/category_screen.dart';
import 'package:handy/ui/chat_screen/binding/chat_screen_binding.dart';
import 'package:handy/ui/chat_screen/view/chat_screen.dart';
import 'package:handy/ui/confirm_appointment_screen/binding/confirm_appointment_binding.dart';
import 'package:handy/ui/confirm_appointment_screen/view/confirm_appointment_screen.dart';
import 'package:handy/ui/confirm_booking_screen/binding/confirm_booking_binding.dart';
import 'package:handy/ui/confirm_booking_screen/view/confirm_booking_screen.dart';
import 'package:handy/ui/edit_profile_screen/binding/edit_profile_binding.dart';
import 'package:handy/ui/edit_profile_screen/view/edit_profile_screen.dart';
import 'package:handy/ui/fake_call_connect_screen/binding/fake_call_connect_binding.dart';
import 'package:handy/ui/fake_call_connect_screen/view/fake_call_connect_screen.dart';
import 'package:handy/ui/fake_personal_chat_screen/binding/personal_chat_binding.dart';
import 'package:handy/ui/fake_personal_chat_screen/view/fake_personal_chat_screen.dart';
import 'package:handy/ui/fake_voice_call_screen/binding/fake_voice_call_binding.dart';
import 'package:handy/ui/fake_voice_call_screen/view/fake_voice_call_screen.dart';
import 'package:handy/ui/forgot_password_screen/binding/forgot_password_binding.dart';
import 'package:handy/ui/forgot_password_screen/view/forgot_password_screen.dart';
import 'package:handy/ui/help_desk_history_screen/binding/help_desk_history_binding.dart';
import 'package:handy/ui/help_desk_history_screen/view/help_desk_history_screen.dart';
import 'package:handy/ui/help_task_screen/binding/help_desk_screen_binding.dart';
import 'package:handy/ui/help_task_screen/view/help_desk_screen.dart';
import 'package:handy/ui/home_screen/binding/home_screen_binding.dart';
import 'package:handy/ui/home_screen/view/home_screen.dart';
import 'package:handy/ui/language_screen/binding/language_screen_binding.dart';
import 'package:handy/ui/language_screen/view/language_screen.dart';
import 'package:handy/ui/login_screen/binding/login_screen_binding.dart';
import 'package:handy/ui/login_screen/view/login_screen.dart';
import 'package:handy/ui/main_screen/binding/main_screen_binding.dart';
import 'package:handy/ui/main_screen/view/main_screen.dart';
import 'package:handy/ui/mobile_number_screen/binding/mobile_number_binding.dart';
import 'package:handy/ui/mobile_number_screen/view/mobile_number_screen.dart';
import 'package:handy/ui/my_appointment_screen/binding/my_appointment_binding.dart';
import 'package:handy/ui/my_appointment_screen/view/my_appointment_screen.dart';
import 'package:handy/ui/my_wallet_screen/binding/my_wallet_binding.dart';
import 'package:handy/ui/my_wallet_screen/view/my_wallet_screen.dart';
import 'package:handy/ui/notification_screen/binding/notification_binding.dart';
import 'package:handy/ui/notification_screen/view/notification_screen.dart';
import 'package:handy/ui/on_boarding_screen/binding/on_boarding_binding.dart';
import 'package:handy/ui/on_boarding_screen/view/onboarding_screen.dart';
import 'package:handy/ui/payment_screen/binding/payment_screen_binding.dart';
import 'package:handy/ui/payment_screen/view/payment_screen.dart';
import 'package:handy/ui/personal_chat_screen/binding/personal_chat_binding.dart';
import 'package:handy/ui/personal_chat_screen/view/personal_chat_screen.dart';
import 'package:handy/ui/profile_screen/binding/profile_screen_binding.dart';
import 'package:handy/ui/profile_screen/view/profile_screen.dart';
import 'package:handy/ui/agency_info_screen/binding/agency_info_binding.dart';
import 'package:handy/ui/agency_info_screen/view/agency_info_screen.dart';
import 'package:handy/ui/provider_list_screen/binding/provider_list_binding.dart';
import 'package:handy/ui/provider_list_screen/view/provider_list_screen.dart';
import 'package:handy/ui/purchase_package_screen/binding/purchase_package_binding.dart';
import 'package:handy/ui/purchase_package_screen/view/purchase_package_screen.dart';
import 'package:handy/ui/rating_screen/binding/rating_screen_binding.dart';
import 'package:handy/ui/rating_screen/view/rating_screen.dart';
import 'package:handy/ui/re_schedule_screen/binding/re_schedule_binding.dart';
import 'package:handy/ui/re_schedule_screen/view/re_schedule_screen.dart';
import 'package:handy/ui/registration_screen/binding/registration_binding.dart';
import 'package:handy/ui/registration_screen/view/registration_screen.dart';
import 'package:handy/ui/favorite_agency_screen/binding/favorite_agency_binding.dart';
import 'package:handy/ui/favorite_agency_screen/view/favorite_agency_screen.dart';
import 'package:handy/ui/search_screen/binding/search_screen_binding.dart';
import 'package:handy/ui/search_screen/view/search_screen.dart';
import 'package:handy/ui/service_wise_agency_screen/view/service_wise_agency_screen.dart';
import 'package:handy/ui/set_password_screen/binding/set_password_binding.dart';
import 'package:handy/ui/set_password_screen/view/set_password_screen.dart';
import 'package:handy/ui/splash_screen/binding/splash_screen_binding.dart';
import 'package:handy/ui/splash_screen/view/splash_screen.dart';
import 'package:handy/ui/top_rated_agency_screen/binding/top_rated_agency_binding.dart';
import 'package:handy/ui/top_rated_agency_screen/view/top_rated_agency_screen.dart';
import 'package:handy/ui/upcoming_appointment_screen/binding/upcoming_appointment_binding.dart';
import 'package:handy/ui/upcoming_appointment_screen/view/upcoming_appointment_screen.dart';
import 'package:handy/ui/verify_otp_screen/binding/verify_otp_binding.dart';
import 'package:handy/ui/verify_otp_screen/view/verify_otp_screen.dart';
import 'package:handy/ui/verify_password_screen/binding/verify_password_binding.dart';
import 'package:handy/ui/verify_password_screen/view/verify_password_screen.dart';
import 'package:handy/ui/voice_call_screen/binding/voice_call_binding.dart';
import 'package:handy/ui/voice_call_screen/view/voice_call_screen.dart';
import 'package:handy/ui/video_player_screen/binding/video_player_binding.dart';
import 'package:handy/ui/video_player_screen/view/video_player_screen.dart';

class AppPages {
  static List<GetPage> list = [
    GetPage(
      name: AppRoutes.initial,
      page: () => const SplashScreen(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: AppRoutes.onBoarding,
      page: () => const OnBoardingScreen(),
      binding: OnBoardingBinding(),
    ),
    GetPage(
      name: AppRoutes.main,
      page: () => const MainScreen(),
      binding: MainScreenBinding(),
    ),
    GetPage(
      name: AppRoutes.registration,
      page: () => const RegistrationScreen(),
      binding: RegistrationBinding(),
    ),
    GetPage(
      name: AppRoutes.mobileNumber,
      page: () => const MobileNumberScreen(),
      binding: MobileNumberBinding(),
    ),
    GetPage(
      name: AppRoutes.verifyOtp,
      page: () => const VerifyOtpScreen(),
      binding: VerifyOtpBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      binding: LoginScreenBinding(),
    ),
    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => const ForgotPasswordScreen(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: AppRoutes.verifyPassword,
      page: () => const VerifyPasswordScreen(),
      binding: VerifyPasswordBinding(),
    ),
    GetPage(
      name: AppRoutes.setPassword,
      page: () => const SetPasswordScreen(),
      binding: SetPasswordBinding(),
    ),
    GetPage(
      name: AppRoutes.bottom,
      page: () => const BottomBarScreen(),
      binding: BottomBarBinding(),
    ),
    GetPage(
      name: AppRoutes.deviceLocation,
      page: () => const DeviceLocationScreen(),
      binding: DeviceLocationBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
      binding: HomeScreenBinding(),
    ),
    GetPage(
      name: AppRoutes.appointment,
      page: () => const AppointmentScreen(),
      binding: AppointmentScreenBinding(),
    ),
    GetPage(
      name: AppRoutes.chat,
      page: () => const ChatScreen(),
      binding: ChatScreenBinding(),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfileScreen(),
      binding: ProfileScreenBinding(),
    ),
    GetPage(
      name: AppRoutes.upcomingAppointment,
      page: () => const UpcomingAppointmentScreen(),
      binding: UpcomingAppointmentBinding(),
    ),
    GetPage(
      name: AppRoutes.notification,
      page: () => const NotificationScreen(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: AppRoutes.search,
      page: () => const SearchScreen(),
      binding: SearchScreenBinding(),
    ),
    GetPage(
      name: AppRoutes.category,
      page: () => const CategoryScreen(),
      binding: CategoryScreenBinding(),
    ),
    GetPage(
      name: AppRoutes.serviceWiseAgency,
      page: () => const ServiceWiseAgencyScreen(),
      binding: ServiceWiseAgencyBinding(),
    ),
    GetPage(
      name: AppRoutes.topRatedAgency,
      page: () => const TopRatedAgencyScreen(),
      binding: TopRatedAgencyBinding(),
    ),
    GetPage(
      name: AppRoutes.agencyInfo,
      page: () => const AgencyInfoScreen(),
      binding: AgencyInfoBinding(),
    ),
    GetPage(
      name: AppRoutes.providerList,
      page: () => const ProviderListScreen(),
      binding: ProviderListBinding(),
    ),
    GetPage(
      name: AppRoutes.purchasePackage,
      page: () => const PurchasePackageScreen(),
      binding: PurchasePackageBinding(),
    ),
    GetPage(
      name: AppRoutes.rating,
      page: () => const RatingScreen(),
      binding: RatingScreenBinding(),
    ),
    GetPage(
      name: AppRoutes.booking,
      page: () => const BookingScreen(),
      binding: BookingScreenBinding(),
    ),
    GetPage(
      name: AppRoutes.confirmBooking,
      page: () => const ConfirmBookingScreen(),
      binding: ConfirmBookingBinding(),
    ),
    GetPage(
      name: AppRoutes.confirmAppointment,
      page: () => const ConfirmAppointmentScreen(),
      binding: ConfirmAppointmentBinding(),
    ),
    GetPage(
      name: AppRoutes.applyCoupon,
      page: () => const ApplyCouponScreen(),
      binding: ApplyCouponBinding(),
    ),
    GetPage(
      name: AppRoutes.schedule,
      page: () => const ReScheduleScreen(),
      binding: ReScheduleBinding(),
    ),
    GetPage(
      name: AppRoutes.bookingInformation,
      page: () => const BookingInformationScreen(),
      binding: BookingInformationBinding(),
    ),
    GetPage(
      name: AppRoutes.personalChat,
      page: () => const PersonalChatScreen(),
      binding: PersonalChatBinding(),
    ),
    GetPage(
      name: AppRoutes.fakePersonalChat,
      page: () => const FakePersonalChatScreen(),
      binding: FakePersonalChatBinding(),
    ),
    GetPage(
      name: AppRoutes.fakeCallConnect,
      page: () => const FakeCallConnectScreen(),
      binding: FakeCallConnectBinding(),
    ),
    GetPage(
      name: AppRoutes.fakeVoiceCall,
      page: () => const FakeVoiceCallScreen(),
      binding: FakeVoiceCallBinding(),
    ),
    GetPage(
      name: AppRoutes.videoPlayer,
      page: () => const VideoPlayerScreen(),
      binding: VideoPlayerBinding(),
    ),
    GetPage(
      name: AppRoutes.callConnect,
      page: () => const CallConnectScreen(),
      binding: CallConnectBinding(),
    ),
    GetPage(
      name: AppRoutes.videoCall,
      page: () => const VoiceCallScreen(),
      binding: VoiceCallBinding(),
    ),
    GetPage(
      name: AppRoutes.callReceive,
      page: () => const CallReceiveScreen(),
      binding: CallReceiveBinding(),
    ),
    GetPage(
      name: AppRoutes.editProfile,
      page: () => const EditProfileScreen(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.savedAgency,
      page: () => const FavoriteAgencyScreen(),
      binding: FavoriteAgencyBinding(),
    ),
    GetPage(
      name: AppRoutes.myAppointment,
      page: () => const MyAppointmentScreen(),
      binding: MyAppointmentBinding(),
    ),
    GetPage(
      name: AppRoutes.language,
      page: () => const LanguageScreen(),
      binding: LanguageScreenBinding(),
    ),
    GetPage(
      name: AppRoutes.myWallet,
      page: () => const MyWalletScreen(),
      binding: MyWalletBinding(),
    ),
    GetPage(
      name: AppRoutes.history,
      page: () => const HistoryScreen(),
      binding: HistoryScreenBinding(),
    ),
    GetPage(
      name: AppRoutes.payment,
      page: () => const PaymentScreen(),
      binding: PaymentScreenBinding(),
    ),
    GetPage(
      name: AppRoutes.helpDesk,
      page: () => const HelpDeskScreen(),
      binding: HelpDeskScreenBinding(),
    ),
    GetPage(
      name: AppRoutes.helpDeskHistory,
      page: () => const HelpDeskHistoryScreen(),
      binding: HelpDeskHistoryBinding(),
    ),
  ];
}
