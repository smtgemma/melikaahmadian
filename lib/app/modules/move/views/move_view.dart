import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/move_controller.dart';

class MoveView extends GetView<MoveController> {
  const MoveView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MoveView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'MoveView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
