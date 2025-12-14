import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/ai_analye_controller.dart';

class AiAnalyeView extends GetView<AiAnalyeController> {
  const AiAnalyeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AiAnalyeView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AiAnalyeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
