import 'package:get/get.dart';

class MyEraningController extends GetxController {
  //TODO: Implement MyEraningController


  RxList months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ].obs;
  final monthIndex = 0.obs;

  final selectedMonth = "January".obs;
  @override
  void onInit() {
    super.onInit();
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
