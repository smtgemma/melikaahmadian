import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

class ImageUplodController extends GetxController {

  final int maxLimit = 1;
  final  indicatorValue = 0.50.obs;


  RxList<File> selectedFiles = <File>[].obs;


  RxList<String> fileNames = <String>[].obs;


  RxList<bool> isImageList = <bool>[].obs;


  Future<void> pickDocument() async {


    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg', 'pdf'],
    );

    if (result != null && result.files.single.path != null) {
      updateProgress(1.0);
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
      updateProgress(0.50);
    }
  }
  void updateProgress(double value) {
    indicatorValue.value = value;
  }

}
