import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/const/app_urls.dart';
import '../../../../../core/network/dio_client.dart';

class MoverAccountController extends GetxController {
  // Selected payment method
  final selectedMethod = ''.obs;
  final isLoading = false.obs;
  final isSaving = false.obs;

  // INTERAC controllers
  final interacEmailController = TextEditingController();
  final interacSecurityQuestionController = TextEditingController();
  final interacSecurityAnswerController = TextEditingController();

  // BANK_EFT controllers
  final bankNameController = TextEditingController();
  final accountNumberController = TextEditingController();
  final routingNumberController = TextEditingController();
  final accountHolderNameController = TextEditingController();

  // WALLET controllers
  final walletTypeController = TextEditingController();
  final walletIdController = TextEditingController();
  final walletEmailController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    // Fetch existing payment method on init

  }

  @override
  void onClose() {
    // Dispose all controllers
    interacEmailController.dispose();
    interacSecurityQuestionController.dispose();
    interacSecurityAnswerController.dispose();
    bankNameController.dispose();
    accountNumberController.dispose();
    routingNumberController.dispose();
    accountHolderNameController.dispose();
    walletTypeController.dispose();
    walletIdController.dispose();
    walletEmailController.dispose();
    super.onClose();
  }

  // Toggle payment method selection
  void togglePaymentMethod(String method) {
    if (selectedMethod.value == method) {
      // If already selected, deselect it
      selectedMethod.value = '';
    } else {
      // Select the new method
      selectedMethod.value = method;
    }
  }

  Future<void> submitPaymentMethod() async {
    try {
      // Validate that a method is selected
      if (selectedMethod.value.isEmpty) {
        Get.snackbar(
          "Error",
          "Please select a payment method",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      isSaving.value = true;

      Map<String, dynamic> body = {};

      // Build request body based on selected method
      if (selectedMethod.value == 'INTERAC') {
        // Validate INTERAC fields
        if (interacEmailController.text.isEmpty ||
            interacSecurityQuestionController.text.isEmpty ||
            interacSecurityAnswerController.text.isEmpty) {
          Get.snackbar(
            "Error",
            "Please fill all INTERAC fields",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          isSaving.value = false;
          return;
        }

        body = {
          "methodType": "INTERAC",
          "country": "CA",
          "details": {
            "email": interacEmailController.text.trim(),
            "securityQuestion": interacSecurityQuestionController.text.trim(),
            "securityAnswer": interacSecurityAnswerController.text.trim(),
          }
        };
      } else if (selectedMethod.value == 'BANK_EFT') {
        // Validate BANK_EFT fields
        if (bankNameController.text.isEmpty ||
            accountNumberController.text.isEmpty ||
            routingNumberController.text.isEmpty ||
            accountHolderNameController.text.isEmpty) {
          Get.snackbar(
            "Error",
            "Please fill all Bank EFT fields",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          isSaving.value = false;
          return;
        }

        body = {
          "methodType": "BANK_EFT",
          "country": "CA",
          "details": {
            "bankName": bankNameController.text.trim(),
            "accountNumber": accountNumberController.text.trim(),
            "routingNumber": routingNumberController.text.trim(),
            "accountHolderName": accountHolderNameController.text.trim(),
          }
        };
      } else if (selectedMethod.value == 'WALLET') {
        // Validate WALLET fields
        if (walletTypeController.text.isEmpty ||
            walletIdController.text.isEmpty ||
            walletEmailController.text.isEmpty) {
          Get.snackbar(
            "Error",
            "Please fill all Wallet fields",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          isSaving.value = false;
          return;
        }

        body = {
          "methodType": "WALLET",
          "country": "CA",
          "details": {
            "walletType": walletTypeController.text.trim(),
            "walletId": walletIdController.text.trim(),
            "email": walletEmailController.text.trim(),
          }
        };
      }

      // Call API
      final response = await DioClient().post(
        AppUrls.paymentMatodeaddByprovider,
        data: body,
      );

      isSaving.value = false;

      // Check response status
      if (response.statusCode == 200) {
        Get.snackbar(
          "Success",
          response.data['message'] ?? "Payment method saved successfully!",
          snackPosition: SnackPosition.TOP,

        );

        // Optionally navigate back or refresh data
        // Get.back();
      } else {
        Get.snackbar(
          "Error",
          response.data['message'] ?? "Failed to save payment method",
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      isSaving.value = false;
      print("Error submitting payment method: $e");
      Get.snackbar(
        "Error",
        "Failed to save payment method. Please try again.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }



  void populateFieldsFromResponse(Map<String, dynamic> data) {
    String methodType = data['methodType'];
    selectedMethod.value = methodType;

    if (methodType == 'INTERAC') {
      interacEmailController.text = data['details']['email'] ?? '';
      interacSecurityQuestionController.text = data['details']['securityQuestion'] ?? '';
      interacSecurityAnswerController.text = data['details']['securityAnswer'] ?? '';
    } else if (methodType == 'BANK_EFT') {
      bankNameController.text = data['details']['bankName'] ?? '';
      accountNumberController.text = data['details']['accountNumber'] ?? '';
      routingNumberController.text = data['details']['routingNumber'] ?? '';
      accountHolderNameController.text = data['details']['accountHolderName'] ?? '';
    } else if (methodType == 'WALLET') {
      walletTypeController.text = data['details']['walletType'] ?? '';
      walletIdController.text = data['details']['walletId'] ?? '';
      walletEmailController.text = data['details']['email'] ?? '';
    }

    print("Populated fields for $methodType");
  }
}