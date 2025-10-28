import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:handy/routes/app_routes.dart';
import 'package:handy/services/app_exception/app_exception.dart';
import 'package:handy/ui/edit_profile_screen/model/edit_customer_profile_model.dart';
import 'package:handy/ui/profile_screen/controller/profile_screen_controller.dart';
import 'package:handy/ui/search_screen/widget/search_screen_widget.dart';
import 'package:handy/utils/api.dart';
import 'package:handy/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:handy/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileController extends GetxController {
  final formKey = GlobalKey<FormState>();
  dynamic args = Get.arguments;

  String? name;
  String? email;
  String? mobileNumber;

  String? countryName;
  String? genderName;
  int genderSelect = 0;

  final ImagePicker imagePicker = ImagePicker();
  XFile? image;
  File? selectImageFile;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  ProfileScreenController profileScreenController = Get.find<ProfileScreenController>();

  @override
  void onInit() async {
    await getDataFromArgs();
    await setDataFromArgs();
    super.onInit();
  }

  getDataFromArgs() {
    if (args != null) {
      if (args[0] != null || args[1] != null || args[2] != null || args[3] != null || args[4] != null) {
        name = args[0];
        email = args[1];
        mobileNumber = args[2];
        countryName = args[3];
        genderName = args[4];
      }

      log("Name :: $name");
      log("Email :: $email");
      log("Mobile Number :: $mobileNumber");
      log("Country :: $countryName");
      log("Gender :: $genderName");
    }
  }

  setDataFromArgs() {
    nameController.text = name ?? "";
    emailController.text = email ?? "";
    numberController.text = mobileNumber ?? "";
    countryName = countryName;
    genderName = genderName;
  }

  bool isEmailValid(String email) {
    final emailRegex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  onPickImage() async {
    image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectImageFile = File(image!.path);
      update();
    }
    update([Constant.idEditImage]);
  }

  onCountryChange(String country) {
    countryName = country;
    update([Constant.idSelectCountry]);
  }

  onGenderSelect(int index) {
    genderSelect = index;
    genderName = genderList[index];

    update([Constant.idRegGenderSelect]);
  }

  onSaveProfileClick(BuildContext context) async {
    Utils.currentFocus(context);

    if (formKey.currentState!.validate()) {
      await editCustomerProfileApiCall(
        name: nameController.text,
        email: emailController.text,
        mobile: numberController.text,
        gender: genderName ?? "",
        country: countryName ?? "",
        image: selectImageFile?.path ?? "",
      );

      if (editCustomerProfileModel?.status == true) {
        Constant.storage.write("isUpdate", true);
        Constant.storage.write("isLogIn", true);
        Utils.showToast(Get.context!, editCustomerProfileModel?.message ?? "");

        await onGetProfileApiCall();
      } else {
        Utils.showToast(Get.context!, editCustomerProfileModel?.message ?? "");
      }
    }
  }

  onGetProfileApiCall() async {
    try {
      isLoading = true;
      update([Constant.idEditCustomer]);

      await profileScreenController.getCustomerProfileApiCall();

      if (profileScreenController.getCustomerProfileModel?.status == true) {
        Constant.storage.write("customerId", profileScreenController.getCustomerProfileModel?.customer?.id);
        Constant.storage.write("customerName", profileScreenController.getCustomerProfileModel?.customer?.name);
        Constant.storage.write("customerEmail", profileScreenController.getCustomerProfileModel?.customer?.email);
        Constant.storage.write("customerImage", profileScreenController.getCustomerProfileModel?.customer?.profileImage);
        Constant.storage.write("mobileNumber", profileScreenController.getCustomerProfileModel?.customer?.mobileNumber);

        if (Constant.storage.read("isSignUp") == true) {
          Constant.storage.write("isSignUp", false);

          Get.offAllNamed(AppRoutes.bottom);
        } else {
          Get.back();
        }
      }
    } catch (e) {
      log("Error in Get profile in Edit profile :: $e");
    } finally {
      isLoading = false;
      update([Constant.idEditCustomer]);
    }
  }

  /// =================== API Calling =================== ///

  EditCustomerProfileModel? editCustomerProfileModel;
  bool isLoading = false;

  editCustomerProfileApiCall({
    required String name,
    required String email,
    required String mobile,
    required String gender,
    required String country,
    required String image,
  }) async {
    try {
      isLoading = true;
      update([Constant.idEditCustomer]);

      final queryParameters = {
        "customerId": Constant.storage.read('customerId'),
      };

      log("Edit Customer Profile Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      var uri = Uri.parse(ApiConstant.BASE_URL + ApiConstant.editCustomerProfile + queryString);
      var request = http.MultipartRequest("PATCH", uri);
      log("Edit Customer Profile URL :: $uri");

      if (image.isNotEmpty) {
        var addImage = await http.MultipartFile.fromPath("profileImage", image);
        request.files.add(addImage);
        log("Edit Customer Profile addImage :: $addImage");
        log("Edit Customer Profile Image :: $image");
      }

      request.headers.addAll({"key": ApiConstant.SECRET_KEY});

      Map<String, String> requestBody = <String, String>{
        "name": name,
        "email": email,
        "mobile": mobile,
        "gender": gender,
        "country": country,
      };

      log("Edit Customer Profile Body :: $requestBody");

      request.fields.addAll(requestBody);
      var res1 = await request.send();
      var res = await http.Response.fromStream(res1);
      log("Edit Customer Profile Status Code :: ${res.statusCode}");
      log("Edit Customer Profile Response :: ${res.body}");

      if (res.statusCode == 200) {
        final jsonResponse = jsonDecode(res.body);
        editCustomerProfileModel = EditCustomerProfileModel.fromJson(jsonResponse);
        return EditCustomerProfileModel.fromJson(jsonDecode(res.body));
      }

      log("Edit Customer Profile Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error Call Edit Customer Profile Api :: $e");
    } finally {
      isLoading = false;
      update([Constant.idEditCustomer]);
    }
  }
}
