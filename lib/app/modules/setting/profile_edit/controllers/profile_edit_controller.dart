import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileEditController extends GetxController {

  final nameController = TextEditingController(text: "meskatul");
  final emailController = TextEditingController(text: "s******@gmail.com");
  final phoneController = TextEditingController(text: "+880111100");

  RxBool isEdit = true.obs ;


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

  //edit
  void setEdit(bool value) {
    isEdit.value = value;
  }

}

