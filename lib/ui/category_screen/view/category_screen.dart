import 'package:flutter/material.dart';
import 'package:handy/ui/category_screen/widget/category_screen_widget.dart';
import 'package:handy/utils/app_color.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: const CategoryAppBarView(),
      ),
      body: const CategoryGridView(),
    );
  }
}
