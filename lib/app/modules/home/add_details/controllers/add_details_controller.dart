import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:melikaahmadian/app/core/model/product_model.dart';
import 'package:melikaahmadian/generated/assets.dart';

class AddDetailsController extends GetxController {
  //TODO: Implement AddDetailsController

  final dataEditingController  = TextEditingController();

  final timeEditingController  = TextEditingController();
  DateTime ? selectedDate ;
  RxInt selectedHouseType = 0.obs ;
  RxString selectedDateText = "".obs ;
  List<ProductModel> houseType = [
    ProductModel(titel: "House",iconPath: Assets.iconsHouse),
    ProductModel(titel: "Apartment",iconPath: Assets.iconsAppartment),
    ProductModel(titel: "Commercial",iconPath: Assets.iconsCommersial),
  ] ;

  //location
  RxString  picupLatitude = "".obs ;
  RxString  picupLongitude = "".obs ;
  RxString  picupAddress = "".obs ;
  RxString  dropLatitude = "".obs ;
  RxString  dropLongitude = "".obs ;
  RxString  dropAddress = "".obs ;


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

  Future selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2500),

    );
    if(picked != null && picked != DateTime.now()){
      selectedDate = picked ;
      dataEditingController.text = DateFormat('dd MMM yyyy').format(picked);
    }


  }
  Future timeSelectDate(BuildContext context) async {
    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time != null) {
      timeEditingController.text = time.format(context);

    }


  }


}
