import 'package:get/get.dart';
import 'package:handy/socket/socket_manager.dart';
import 'package:handy/ui/appointment_screen/view/appointment_screen.dart';
import 'package:handy/ui/chat_screen/view/chat_screen.dart';
import 'package:handy/ui/home_screen/view/home_screen.dart';
import 'package:handy/ui/profile_screen/view/profile_screen.dart';
import 'package:handy/ui/favorite_agency_screen/view/favorite_agency_screen.dart';
import 'package:handy/utils/constant.dart';

class BottomBarController extends GetxController {
  bool checkScreen = false;
  int selectIndex = 0;

  @override
  void onInit() {
    SocketManager.initSocketManager();
    super.onInit();
  }

  final pages = [
    const HomeScreen(),
    const AppointmentScreen(),
    const ChatScreen(),
    const FavoriteAgencyScreen(),
    const ProfileScreen(),
  ];

  onClick(value) async {
    if (value != null) {
      selectIndex = value;
      update([Constant.idBottomBar]);
    }
  }
}
