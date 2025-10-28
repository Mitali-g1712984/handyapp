import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:handy/services/app_exception/app_exception.dart';
import 'package:handy/ui/chat_screen/model/fake_chat_thumb_list_model.dart';
import 'package:handy/ui/chat_screen/model/get_chat_list_model.dart';
import 'package:handy/utils/api.dart';
import 'package:handy/utils/constant.dart';
import 'package:handy/utils/utils.dart';
import 'package:http/http.dart' as http;

class ChatScreenController extends GetxController {

  List<FakeChatItem> chatItems = [
    FakeChatItem(
      name: "Andrew D Filder",
      lastMessage: "Your cleaning service is scheduled for tomorrow at 10 AM.",
      thumbUrl: "https://images.pexels.com/photos/3778876/pexels-photo-3778876.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1", // Replace with actual image URL
      time: "09:45 AM",
      unreadCount: 2,
      serviceName: "Cleaning",
    ),
    FakeChatItem(
      name: "William Andrew",
      lastMessage: "The plumber will arrive at your location by 2 PM.",
      thumbUrl: "https://images.pexels.com/photos/921646/pexels-photo-921646.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      time: "11:25 AM",
      unreadCount: 3,
      serviceName: "Plumbing",
    ),
    FakeChatItem(
      name: "Saniya Leo",
      lastMessage: "Can you confirm the address for the electrical repairs?",
      thumbUrl: "https://images.pexels.com/photos/1642228/pexels-photo-1642228.jpeg",
      time: "01:45 PM",
      unreadCount: 0,
      serviceName: "Electrical Repairs",
    ),
    FakeChatItem(
      name: "Zenith Smith",
      lastMessage: "Your lawn care appointment is set for Friday at 8 AM.",
      thumbUrl: "https://images.pexels.com/photos/375880/pexels-photo-375880.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      time: "01:45 PM",
      unreadCount: 0,
      serviceName: "Lawn Care",
    ),
  ];

  @override
  void onInit() async {
    await getChatListApiCall();
    super.onInit();
  }

  /// =================== API Calling =================== ///

  GetChatListModel? getChatListModel;
  bool isLoading = false;

  getChatListApiCall() async {
    try {
      isLoading = true;
      update([Constant.idGetChatList]);

      final queryParameters = {
        "customerId": Constant.storage.read("customerId"),
      };

      log("Get Chat List Params :: $queryParameters");

      String queryString = Uri(queryParameters: queryParameters).query;

      final url = Uri.parse(ApiConstant.BASE_URL + ApiConstant.getChatList + queryString);
      log("Get Chat List Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Get Chat List Headers :: $headers");

      final response = await http.get(url, headers: headers);

      log("Get Chat List Status Code :: ${response.statusCode}");
      log("Get Chat List Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        getChatListModel = GetChatListModel.fromJson(jsonResponse);
      }

      log("Get Chat List Api Call Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Get Chat List Api :: $e");
    } finally {
      isLoading = false;
      update([Constant.idGetChatList]);
    }
  }
}
