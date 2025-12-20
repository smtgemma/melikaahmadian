import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileProfileEditController extends GetxController {
  //TODO: Implement ProfileProfileEditController
  final nameTextEditingController = TextEditingController(text: "meskatul");
  final phoneTextEditingController = TextEditingController(text: "+880177777");
  final addressTextEditingController = TextEditingController(text: "Bangladesh");
  final emailTextEditingController = TextEditingController(text: "m*******@gmail.com");

  final specilizTextController = TextEditingController();
  RxList specilized = [].obs ;

  final count = 0.obs;
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

  void increment() => count.value++;

  //image picker
  final ImagePicker _picker = ImagePicker();

  Rx<File?> selectedImage = Rx<File?>(null);

  /// Pick image from gallery
  Future<void> pickImageFromGallery() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (image != null) {
      selectedImage.value = File(image.path);
    }
  }

  /// Clear image (optional)
  void clearImage() {
    selectedImage.value = null;
  }
}
