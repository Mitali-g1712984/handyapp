import 'package:flutter/material.dart';
import 'package:handy/ui/history_screen/widget/history_screen_widget.dart';
import 'package:handy/utils/app_color.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: const HistoryAppBarView(),
      ),
      body: const Column(
        children: [
          HistoryTitleView(),
          Expanded(child: HistoryListView()),
        ],
      ),
    );
  }
}
