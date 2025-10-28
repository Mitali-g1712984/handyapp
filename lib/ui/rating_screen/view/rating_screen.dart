import 'package:flutter/material.dart';
import 'package:handy/ui/rating_screen/widget/rating_screen_widget.dart';
import 'package:handy/utils/app_color.dart';

class RatingScreen extends StatelessWidget {
  const RatingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: const RatingAppBarView(),
      ),
      body: const RatingListView(),
    );
  }
}
