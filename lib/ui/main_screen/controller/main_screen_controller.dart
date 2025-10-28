import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:handy/routes/app_routes.dart';
import 'package:handy/ui/main_screen/model/login_or_sign_up_model.dart';
import 'package:handy/services/app_exception/app_exception.dart';
import 'package:handy/ui/profile_screen/controller/profile_screen_controller.dart';
import 'package:handy/utils/api.dart';
import 'package:handy/utils/constant.dart';
import 'package:handy/utils/global_variables.dart';
import 'package:http/http.dart' as http;
import 'package:handy/utils/utils.dart';

class MainScreenController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  GoogleSignInAccount? googleSignInAccountUser;

  ProfileScreenController profileScreenController = Get.find<ProfileScreenController>();

  @override
  void onInit() async {
    /// Google Controller
    googleSignInAccountUser = await googleSignIn.signInSilently();
    super.onInit();
  }

  /// Google Controller ===========================>

  GoogleSignInAccount? get user => googleSignInAccountUser;

  Future<GoogleSignInAccount?> signInWithGoogle() async {
    try {
      isLoading = true;
      update([Constant.idLoginOrSignUp]);

      GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
        AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        UserCredential? userCredential = await auth.signInWithCredential(credential).catchError((onErr) {
          return Utils.showToast(Get.context!, onErr.toString());
        });

        if (userCredential.user != null) {
          await loginOrSignUpApiCall(
            name: googleSignInAccount.displayName ?? "",
            email: googleSignInAccount.email,
            password: "",
            mobileNumber: "",
            loginType: 2,
            fcmToken: fcmToken ?? "",
            latitude: latitude.toString(),
            longitude: longitude.toString(),
          );
        }

        if (loginOrSignUpModel?.status == true) {
          Utils.showToast(Get.context!, loginOrSignUpModel?.message ?? "");

          Constant.storage.write("isLogIn", true);
          Constant.storage.write("isGoogleLogin", true);
          Constant.storage.write("customerId", loginOrSignUpModel?.customer?.id);
          Constant.storage.write("customerName", loginOrSignUpModel?.customer?.name);
          Constant.storage.write("customerEmail", loginOrSignUpModel?.customer?.email);
          Constant.storage.write("mobileNumber", loginOrSignUpModel?.customer?.mobileNumber);

          await profileScreenController.getCustomerProfileApiCall();

          if (profileScreenController.getCustomerProfileModel?.status == true) {
            Utils.showToast(Get.context!, profileScreenController.getCustomerProfileModel?.message ?? "");

            Constant.storage.write("customerId", profileScreenController.getCustomerProfileModel?.customer?.id);
            Constant.storage.write("customerName", profileScreenController.getCustomerProfileModel?.customer?.name);
            Constant.storage.write("customerEmail", profileScreenController.getCustomerProfileModel?.customer?.email);
            Constant.storage.write("customerImage", profileScreenController.getCustomerProfileModel?.customer?.profileImage);
            Constant.storage.write("mobileNumber", profileScreenController.getCustomerProfileModel?.customer?.mobileNumber);

            Get.offAllNamed(AppRoutes.bottom);
          } else {
            Utils.showToast(Get.context!, profileScreenController.getCustomerProfileModel?.message ?? "");
          }
        } else {
          Utils.showToast(Get.context!, loginOrSignUpModel?.message ?? "");
        }

        log('Success signing in with Google');
      } else {
        log('Error signing in with Google');
      }
    } catch (error) {
      log('Error signing in with Google: $error');
      return null;
    } finally {
      isLoading = false;
      update([Constant.idLoginOrSignUp]);
    }
    return null;
  }

  Future<void> signOut() async {
    try {
      await googleSignIn.signOut();
      googleSignInAccountUser = null;
    } catch (error) {
      log('Error signing out: $error');
    }
  }

  /// =================== API Calling =================== ///

  LoginOrSignUpModel? loginOrSignUpModel;
  bool isLoading = false;

  loginOrSignUpApiCall({
    required String name,
    required String email,
    required String password,
    required String mobileNumber,
    required int loginType,
    required String fcmToken,
    required String latitude,
    required String longitude,
  }) async {
    try {
      isLoading = true;
      update([Constant.idLoginOrSignUp]);

      final body = json.encode({
        "name": name,
        "email": email,
        "password": password,
        "mobileNumber": mobileNumber,
        "loginType": loginType,
        "fcmToken": fcmToken,
        "latitude": latitude,
        "longitude": longitude,
      });

      log("Login Or Sign Up Body :: $body");

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.loginOrSignUpCustomer);
      log("Login Or Sign Up Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Login Or Sign Up Headers :: $headers");

      final response = await http.post(url, headers: headers, body: body);

      log("Login Or Sign Up Status Code :: ${response.statusCode}");
      log("Login Or Sign Up Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        loginOrSignUpModel = LoginOrSignUpModel.fromJson(jsonResponse);
      }
      log("Login Or Sign Up Api Called Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Login Or Sign Up Api :: $e");
      Utils.showToast(Get.context!, '$e');
    } finally {
      isLoading = false;
      update([Constant.idLoginOrSignUp]);
    }
  }
}
