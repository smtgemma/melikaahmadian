import 'package:get/get.dart';
import '../../../../core/const/app_urls.dart';
import '../../../../core/network/dio_client.dart';
import '../model/payment_model_mathode.dart';

class MoverSelectedAccountController extends GetxController {
  final Rx<PayoutMethodModel?> payoutMethod = Rx<PayoutMethodModel?>(null);
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPayoutMethod();
  }

  Future<void> fetchPayoutMethod() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await DioClient().get(AppUrls.myPaymentMathode);

      if (response.statusCode == 200 || response.statusCode == 201) {
       // payoutMethod.value = PayoutMethodModel.fromJson(response.data);
        payoutMethod.value = PayoutMethodModel.fromJson(response.data['data']);


      } else {
        errorMessage.value = response.data["message"] ?? 'Failed to fetch payout method';
      }
    } catch (e) {
      errorMessage.value = 'An error occurred: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshPayoutMethod() async {

    await fetchPayoutMethod();
  }
}
