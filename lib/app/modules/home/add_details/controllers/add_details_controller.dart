// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:melikaahmadian/app/core/model/product_model.dart';
// import 'package:melikaahmadian/generated/assets.dart';
//
// import '../../../../core/network/shared_prepharence_helper.dart';
//
// class AddDetailsController extends GetxController {
//   //TODO: Implement AddDetailsController
//
//   final dataEditingController  = TextEditingController();
//
//   final timeEditingController  = TextEditingController();
//   DateTime ? selectedDate ;
//   RxInt selectedHouseType = 0.obs ;
//   RxString selectedDateText = "".obs ;
//   List<ProductModel> houseType = [
//     ProductModel(titel: "House",iconPath: Assets.iconsHouse),
//     ProductModel(titel: "Apartment",iconPath: Assets.iconsAppartment),
//     ProductModel(titel: "Commercial",iconPath: Assets.iconsCommersial),
//   ] ;
//
//   //location
//   RxString  picupLatitude = "".obs ;
//   RxString  picupLongitude = "".obs ;
//   RxString  picupAddress = "".obs ;
//   RxString  dropLatitude = "".obs ;
//   RxString  dropLongitude = "".obs ;
//   RxString  dropAddress = "".obs ;
//
//   RxString ai = "".obs ;
//   RxDouble distance = 0.0.obs ;
//   RxBool isLoading = false.obs ;
//
//
//
//
//   @override
//   void onInit() {
//     super.onInit();
//     ai.value = SharedPrefHelper.getString(SharedPrefHelper.ai).toString();
//   }
//
//
//   @override
//   void onReady() {
//     super.onReady();
//   }
//
//   @override
//   void onClose() {
//     super.onClose();
//   }
//
//   Future selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2500),
//
//     );
//     if(picked != null && picked != DateTime.now()){
//       selectedDate = picked ;
//       dataEditingController.text = DateFormat('dd MMM yyyy').format(picked);
//     }
//
//
//   }
//   Future timeSelectDate(BuildContext context) async {
//     TimeOfDay? time = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.now(),
//     );
//
//     if (time != null) {
//       timeEditingController.text = time.format(context);
//
//     }
//
//
//   }
//
//
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:melikaahmadian/app/core/model/product_model.dart';
import 'package:melikaahmadian/generated/assets.dart';
import '../../../../core/network/shared_prepharence_helper.dart';

class AddDetailsController extends GetxController {
  late TextEditingController dataEditingController;
  late TextEditingController timeEditingController;

  DateTime? selectedDate;
  RxInt selectedHouseType = 0.obs;
  RxString selectedDateText = "".obs;

  List<ProductModel> houseType = [
    ProductModel(titel: "House", iconPath: Assets.iconsHouse),
    ProductModel(titel: "Apartment", iconPath: Assets.iconsAppartment),
    ProductModel(titel: "Commercial", iconPath: Assets.iconsCommersial),
  ];

  // Location
  RxString picupLatitude = "".obs;
  RxString picupLongitude = "".obs;
  RxString picupAddress = "".obs;
  RxString dropLatitude = "".obs;
  RxString dropLongitude = "".obs;
  RxString dropAddress = "".obs;
  RxString ai = "".obs;
  RxDouble distance = 0.0.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeControllers();
    ai.value = SharedPrefHelper.getString(SharedPrefHelper.ai).toString();
  }

  void _initializeControllers() {
    dataEditingController = TextEditingController();
    timeEditingController = TextEditingController();
  }

  @override
  void onClose() {
    dataEditingController.dispose();
    timeEditingController.dispose();
    super.onClose();
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2500),
    );
    if (picked != null) {
      selectedDate = picked;
      dataEditingController.text = DateFormat('dd MMM yyyy').format(picked);
    }
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      timeEditingController.text = time.format(context);
    }
  }

  bool validateAllFields() {
    return picupAddress.value.isNotEmpty &&
        dropAddress.value.isNotEmpty &&
        dataEditingController.text.isNotEmpty &&
        timeEditingController.text.isNotEmpty;
  }

  void resetForm() {
    selectedDate = null;
    selectedHouseType.value = 0;
    selectedDateText.value = "";
    picupLatitude.value = "";
    picupLongitude.value = "";
    picupAddress.value = "";
    dropLatitude.value = "";
    dropLongitude.value = "";
    dropAddress.value = "";
    distance.value = 0.0;
    dataEditingController.clear();
    timeEditingController.clear();
  }
}