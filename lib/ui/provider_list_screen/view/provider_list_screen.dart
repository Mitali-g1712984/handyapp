import 'package:flutter/material.dart';
import 'package:handy/ui/provider_list_screen/widget/provider_list_widget.dart';

class ProviderListScreen extends StatelessWidget {
  const ProviderListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: const ProviderListTopView(),
      ),
      body: const ProviderListView(),
    );
  }
}
