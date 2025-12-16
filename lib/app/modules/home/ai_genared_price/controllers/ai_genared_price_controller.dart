import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AiGenaredPriceController extends GetxController {
  //TODO: Implement AiGenaredPriceController

  final priceTextEditignControoler = TextEditingController();
  RxString price = "".obs;

  @override
  void onInit() {
    super.onInit();
    priceTextEditignControoler.addListener(() {
      price.value = priceTextEditignControoler.text;
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
