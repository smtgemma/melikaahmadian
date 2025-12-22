import 'dart:io';

import 'package:file_picker/file_picker.dart';
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

  //vicicel
  RxList<File> selectedFiles = <File>[].obs;


  RxList<String> fileNames = <String>[].obs;


  RxList<bool> isImageList = <bool>[].obs;


  Future<void> pickDocument() async {


    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg', 'pdf'],
    );

    if (result != null && result.files.single.path != null) {
      final file = File(result.files.single.path!);
      final extension = result.files.single.extension ?? '';

      selectedFiles.add(file);
      fileNames.add(result.files.single.name);
      isImageList.add(
        extension == 'png' ||
            extension == 'jpg' ||
            extension == 'jpeg',
      );
    }
  }


  void removeFile(int index) {
    selectedFiles.removeAt(index);
    fileNames.removeAt(index);
    isImageList.removeAt(index);
    if(fileNames.isEmpty){
    }
  }




}
