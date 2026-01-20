import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../model/terms_condition_model.dart';
import '../repository/terms_condition_repository.dart';

class TermsConditionController extends GetxController {
  Rx<TermsConditionModel> profileModel = TermsConditionModel().obs;
  RxBool isLoading = false.obs;
  final tos = RxnString();

  @override
  void onInit() {
    super.onInit();
    getTramsAndCondition();
  }

  Future<void> getTramsAndCondition() async {
    try {
      isLoading.value = true;
      final response = await TermsConditionRepository.getProfile();
      profileModel.value = response;
      print("Total OPS: ${profileModel.value.data?.content?.ops?.length}" );
      if(profileModel.value.data?.content?.ops != null) {

      final tosValue =  deltaToMarkdown(profileModel.value.data!.content!.ops!);
      print("TOS Value: $tosValue");
        tos.value = tosValue;
      }
    } catch (e) {
      debugPrint("❌ Terms Error: $e");
    } finally {
      isLoading.value = false;
    }
  }


  String deltaToMarkdown(List<Ops> delta) {
    final buffer = StringBuffer();

    for (int i = 0; i < delta.length; i++) {
      final item = delta[i];
      final text = item.insert ?? '';
      final attrs = item.attributes;

      // Headers
      if (attrs != null && attrs.header
          != null) {
        final level = attrs.header;
        buffer.write('\n${'#' * (level ?? 6)} ');
        continue;
      }

      // Bullet list
      if (attrs != null && attrs.list == 'bullet') {
        buffer.write('\n- ');
        continue;
      }

      String formatted = text;

      // Bold
      if (attrs != null && attrs.bold == true) {
        formatted = '**$formatted**';
      }

      // Italic (if needed later)
      if (attrs != null && attrs.italic == true) {
        formatted = '*$formatted*';
      }

      buffer.write(formatted);
    }

    return buffer.toString();
  }

}

