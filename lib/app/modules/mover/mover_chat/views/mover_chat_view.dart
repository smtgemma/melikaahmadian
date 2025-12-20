import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/mover_chat_controller.dart';

class MoverChatView extends GetView<MoverChatController> {
  const MoverChatView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MoverChatView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'MoverChatView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
