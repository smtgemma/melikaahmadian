import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/mover_profile_controller.dart';

class MoverProfileView extends GetView<MoverProfileController> {
  const MoverProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MoverProfileView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'MoverProfileView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
