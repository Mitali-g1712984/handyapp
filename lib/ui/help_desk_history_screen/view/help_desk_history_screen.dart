import 'package:flutter/material.dart';
import 'package:handy/ui/help_desk_history_screen/widget/help_desk_history_widget.dart';
import 'package:handy/utils/app_color.dart';

class HelpDeskHistoryScreen extends StatelessWidget {
  const HelpDeskHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        flexibleSpace: const HelpDeskHistoryAppBarView(),
      ),
      body: const HelpDeskHistoryListView(),
    );
  }
}
