import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/ai_genared_price_controller.dart';

class AiGenaredPriceView extends GetView<AiGenaredPriceController> {
  const AiGenaredPriceView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AiGenaredPriceView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AiGenaredPriceView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
