import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/prduct_details_controller.dart';

class PrductDetailsView extends GetView<PrductDetailsController> {
  const PrductDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PrductDetailsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PrductDetailsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
