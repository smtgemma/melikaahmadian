import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/cencel_mover_details_controller.dart';

class CencelMoverDetailsView extends GetView<CencelMoverDetailsController> {
  const CencelMoverDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CencelMoverDetailsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CencelMoverDetailsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
