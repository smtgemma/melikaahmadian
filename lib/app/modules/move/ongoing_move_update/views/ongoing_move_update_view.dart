import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/ongoing_move_update_controller.dart';

class OngoingMoveUpdateView extends GetView<OngoingMoveUpdateController> {
  const OngoingMoveUpdateView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OngoingMoveUpdateView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'OngoingMoveUpdateView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
