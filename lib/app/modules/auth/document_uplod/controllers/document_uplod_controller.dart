import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../core/const/app_argument.dart';

class DocumentUplodController extends GetxController {


  final int maxLimit = 3;
  final  indicatorValue = 0.00.obs;





  RxList<File> selectedFiles = <File>[].obs;


  RxList<String> fileNames = <String>[].obs;


  RxList<bool> isImageList = <bool>[].obs;

  String? bio ;
  List? specilize ;


  @override
  void onInit() {
    final argument = Get.arguments ;
    bio = argument[AppArgument.bio];
    specilize = argument[AppArgument.specializ];
    debugPrint("bio: $bio");
    debugPrint("specilize: $specilize");
    // TODO: implement onInit
    super.onInit();
  }


  Future<void> pickDocument() async {


    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg', 'pdf'],
    );

    if (result != null && result.files.single.path != null) {
      updateProgress(0.50);
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
      updateProgress(0.00);
    }
  }
  void updateProgress(double value) {
    indicatorValue.value = value;
  }


}
