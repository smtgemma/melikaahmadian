import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/payment_details_controller.dart';

class PaymentDetailsView extends GetView<PaymentDetailsController> {
  const PaymentDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PaymentDetailsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PaymentDetailsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
