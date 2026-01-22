import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:melikaahmadian/app/core/const/app_argument_string.dart';
import 'package:melikaahmadian/app/core/const/app_urls.dart';
import 'package:melikaahmadian/app/core/network/dio_client.dart';
import 'package:melikaahmadian/app/modules/move/payment_details/widget/expairy_month_function.dart';
import 'package:melikaahmadian/app/routes/app_pages.dart';

class PaymentDetailsController extends GetxController {
  //TODO: Implement PaymentDetailsController
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  final countryController = TextEditingController();
  final addressController = TextEditingController();
  final StateaddressController = TextEditingController();
  final zipaddressController = TextEditingController();
  final alexCardController = TextEditingController();
  final mmCardController = TextEditingController();
  final cvcCardController = TextEditingController();
  final aledMeanCardController = TextEditingController();
  final countryOrRegonController = TextEditingController();
  final cardNumber = TextEditingController();
  final expDate = TextEditingController();
  final cardHolderName = TextEditingController();
  final cvcController = TextEditingController();
  var isLoading = false.obs;
  final pmId = ''.obs;
  final formKey = GlobalKey<FormState>();
  final _networkCaller = DioClient();
  late String clientSecret = '';
  late String paymentIntentId = '';
  String? databasePayment;

  String? offerId;
  final count = 0.obs;
  @override
  void onInit() {
    final args = Get.arguments;
    logD('PaymentDetailsController Init args', args);

    offerId = args?['ProviderId'];
    logD('Offer ID', offerId);

    super.onInit();
  }

  final String stripeKey =
      'pk_test_51PMlmpAE1lXUvAexf8vaM2B30fSC9XXARvezhEHlCc8sePnReLWl42at82unsE0LIfdw9FkmDNPybHkw7qGHnDAm00atqOe0Z0';
  final String backendCreatePaymentMethodUrl =
      'https://api.stripe.com/v1/payment_methods';

  void logD(String title, dynamic data) {
    if (kDebugMode) {
      debugPrint('🟢 [$title]');
      debugPrint(data.toString());
      debugPrint('────────────────────────────');
    }
  }

  void logE(String title, dynamic error) {
    if (kDebugMode) {
      debugPrint('🔴 [$title]');
      debugPrint(error.toString());
      debugPrint('────────────────────────────');
    }
  }

  Future<void> databasePaymentConfirm() async {
    final response = await _networkCaller.post(
      'http://206.162.244.175:6008/api/v1/payments/confirm',
      data: {"paymentIntentId": paymentIntentId},
    );
    if (response.statusCode == 200) {
      print('payment okvjhsjfjvjxv');
    }
  }

  Future<void> onPayPressed() async {
    logD('Pay Button Pressed', 'Start');

    isLoading.value = true;

    if (!formKey.currentState!.validate()) {
      logE('Form Validation', 'Form is invalid');
      isLoading.value = false;
      return;
    }

    final expiry = parseExpiryDate(expDate.text.trim());
    logD('Parsed Expiry', expiry);

    if (expiry == null) {
      Get.snackbar('Error', 'Invalid expiry date. Use MM/YY');
      isLoading.value = false;
      return;
    }

    try {
      final body = {
        'type': 'card',
        'card[number]': cardNumber.text.replaceAll(' ', ''),
        'card[exp_month]': expiry['month'],
        'card[exp_year]': expiry['year'],
        'card[cvc]': cvcController.text.trim(),
      };

      logD('Create Payment Method Body', body);

      final response = await http.post(
        Uri.parse(backendCreatePaymentMethodUrl),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization': 'Basic ${base64Encode(utf8.encode('$stripeKey:'))}',
        },
        body: body,
      );

      logD('Stripe PM Status Code', response.statusCode);
      logD('Stripe PM Response', response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        pmId.value = data['id'];

        logD('Payment Method ID', pmId.value);

        await createPaymentIntent();
        await confirmPayment();
      } else {
        logE('Stripe PM Error', response.body);
        Get.snackbar('Error', 'Failed: ${response.statusCode}');
      }
    } catch (e, s) {
      logE('onPayPressed Exception', e);
      logE('StackTrace', s);
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
      logD('Pay Button', 'End');
    }
  }

  Future<void> createPaymentIntent() async {
    logD('Create PaymentIntent', {'offerId': offerId});

    try {
      final response = await _networkCaller.post(
        AppUrls.createPaymentIntent,
        data: {"offerId": offerId},
      );

      logD('PaymentIntent Status', response.statusCode);
      logD('PaymentIntent Response', response.data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        clientSecret = response.data?['data']['clientSecret'];
        paymentIntentId = response.data?['data']['paymentIntentId'];

        logD('Client Secret', clientSecret);
        logD('PaymentIntent ID', paymentIntentId);
      }
    } catch (e, s) {
      logE('CreatePaymentIntent Error', e);
      logE('StackTrace', s);
    }
  }

  Future<void> confirmPayment() async {
    logD('Confirm Payment Start', {
      'pmId': pmId.value,
      'paymentIntentId': paymentIntentId,
    });

    try {
      final body = {
        'client_secret': clientSecret,
        'payment_method': pmId.value,
      };

      logD('Confirm Body', body);

      final response = await http.post(
        Uri.parse(AppUrls.paymentConfirm(paymentIntentId)),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization': 'Basic ${base64Encode(utf8.encode('$stripeKey:'))}',
        },
        body: body,
      );

      logD('Confirm Status', response.statusCode);
      logD('Confirm Response', response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        await databasePaymentConfirm();
        final data = jsonDecode(response.body);
        print('database intent$data');
      } else {
        logE('Confirm Failed', response.body);
        Get.snackbar('Error', 'Failed: ${response.statusCode}');
      }
    } catch (e, s) {
      logE('ConfirmPayment Exception', e);
      logE('StackTrace', s);
      Get.snackbar('Error', e.toString());
    }
  }
}
