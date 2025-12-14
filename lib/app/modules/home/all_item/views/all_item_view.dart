import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/all_item_controller.dart';

class AllItemView extends GetView<AllItemController> {
  const AllItemView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AllItemView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AllItemView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
