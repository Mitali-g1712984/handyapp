import 'package:flutter/material.dart';
import 'package:handy/ui/language_screen/widget/language_screen_widget.dart';
import 'package:handy/utils/app_color.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: const LanguageAppBarView(),
      ),
      body: const LanguageListView(),
    );
  }
}
