import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/const/app_argument_string.dart';
import '../../../mover/mover_profile/profile_profile_edit/repository/profile_profile_edit_repository.dart';

class ProfileEditController extends GetxController {

  String? name ;
  String? phone ;
  String? email ;
  String? image ;
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;

  final isLoading = false.obs;


  @override
  void onInit() {
    final args = Get.arguments;
     name = args?[AppArgumentString.name];
     email = args?[AppArgumentString.email];
     phone = args?[AppArgumentString.phone];
     image = args?[AppArgumentString.image];

    nameController = TextEditingController(text: name ?? "");
    emailController = TextEditingController(text: email ?? "");
    phoneController = TextEditingController(text: phone ?? "");



    // TODO: implement onInit
    super.onInit();
  }
  @override
  void onClose() {
    // ✅ Dispose controllers to avoid memory leak
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.onClose();
  }

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
      ProfileProfileEditRepository.uploadProfilePicture(imagePath: image.path) ;
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

