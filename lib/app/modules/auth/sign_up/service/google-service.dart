import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:melikaahmadian/app/modules/auth/log_in/controllers/log_in_controller.dart';

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  // final loginResponse = Rxn<loginModal?>();
  final logger = Logger();

  Future<GoogleSignInAccount?> login() async {
    try {
      final GoogleSignInAccount? user = await _googleSignIn.authenticate();
      if (user != null) {
        logger.i("Google Sign in: ${user.displayName}");
        final auth = await user.authentication;
        logger.i("Google ID Token obtained");
        final loginController = Get.find<LogInController>();
        await loginController.socialLogin(auth.idToken ?? '');
      }
      return user;
    } catch (e) {
      logger.e("Google Login Error: $e");
      return null;
    }
  }
}
