import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/ai_analized_furniture_controller.dart';

class AiAnalizedFurnitureView extends GetView<AiAnalizedFurnitureController> {
  const AiAnalizedFurnitureView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AiAnalizedFurnitureView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AiAnalizedFurnitureView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
