import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:melikaahmadian/app/core/const/app_urls.dart';
import 'package:melikaahmadian/app/core/network/dio_client.dart';
import 'package:melikaahmadian/app/core/network/shared_prepharence_helper.dart';
import 'package:melikaahmadian/app/routes/app_pages.dart';

class SignUpController extends GetxController {
  //TODO: Implement SignUpController
  final isLoading = false.obs;
  final logger = Logger();

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }
  Future<void> socialLogin(String token) async {
    try {
      logger.i("Starting social login process with backend...");
      final networkCaller = DioClient();

      final response = await networkCaller.post(
        AppUrls.loginWithGoogle,
        data: {"idToken": token},
      );

      logger.i("Social Login Response Status: ${response.statusCode}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;
        // loginResponse.value = loginModal.fromJson(data!);
        logger.i('Social Login Success ✅');

        await SharedPrefHelper.setString(
          SharedPrefHelper.accessToken,
          data['data']['accessToken'],
        );
        await SharedPrefHelper.setString(
          SharedPrefHelper.refreshToken,
          data['data']['refreshToken'],
        );
        // final splashController = Get.find<FeaturesSplashController>();
        // await splashController.getMe();

        // await sendFcmToken();
        Get.offAllNamed(Routes.MOVER_NAVBAR);
      } else {
        logger.e("Social Login Failed ❌ => ${response.statusMessage}");
      }
    } catch (e, stackTrace) {
      logger.e(
        "Exception during social login ❌",
        error: e,
        stackTrace: stackTrace,
      );
    } finally {}
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
