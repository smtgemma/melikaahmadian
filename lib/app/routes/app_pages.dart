import 'package:get/get.dart';

import '../modules/auth/bio/bindings/bio_binding.dart';
import '../modules/auth/bio/views/bio_view.dart';
import '../modules/auth/create_account/bindings/create_account_binding.dart';
import '../modules/auth/create_account/views/create_account_view.dart';
import '../modules/auth/create_account_with_email/bindings/create_account_with_email_binding.dart';
import '../modules/auth/create_account_with_email/views/create_account_with_email_view.dart';
import '../modules/auth/log_in/bindings/log_in_binding.dart';
import '../modules/auth/log_in/views/log_in_view.dart';
import '../modules/auth/set_new_password/bindings/set_new_password_binding.dart';
import '../modules/auth/set_new_password/views/set_new_password_view.dart';
import '../modules/auth/sign_up/bindings/sign_up_binding.dart';
import '../modules/auth/sign_up/views/sign_up_view.dart';
import '../modules/auth/specialty/bindings/specialty_binding.dart';
import '../modules/auth/specialty/views/specialty_view.dart';
import '../modules/auth/verification_code/bindings/verification_code_binding.dart';
import '../modules/auth/verification_code/views/verification_code_view.dart';
import '../modules/navbar/bindings/navbar_binding.dart';
import '../modules/navbar/views/navbar_view.dart';
import '../modules/role_selection/bindings/role_selection_binding.dart';
import '../modules/role_selection/views/role_selection_view.dart';
import '../modules/select_option/bindings/select_option_binding.dart';
import '../modules/select_option/views/select_option_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.NAVBAR,
      page: () => const NavbarView(),
      binding: NavbarBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.ROLE_SELECTION,
      page: () => const RoleSelectionView(),
      binding: RoleSelectionBinding(),
    ),
    GetPage(
      name: _Paths.SELECT_OPTION,
      page: () => const SelectOptionView(),
      binding: SelectOptionBinding(),
    ),
    GetPage(
      name: _Paths.LOG_IN,
      page: () => LogInView(),
      binding: LogInBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_UP,
      page: () => const SignUpView(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_ACCOUNT,
      page: () => CreateAccountView(),
      binding: CreateAccountBinding(),
    ),
    GetPage(
      name: _Paths.VERIFICATION_CODE,
      page: () => const VerificationCodeView(),
      binding: VerificationCodeBinding(),
    ),
    GetPage(
      name: _Paths.SET_NEW_PASSWORD,
      page: () => SetNewPasswordView(),
      binding: SetNewPasswordBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_ACCOUNT_WITH_EMAIL,
      page: () => CreateAccountWithEmailView(),
      binding: CreateAccountWithEmailBinding(),
    ),
    GetPage(
      name: _Paths.BIO,
      page: () => BioView(),
      binding: BioBinding(),
    ),
    GetPage(
      name: _Paths.SPECIALTY,
      page: () => const SpecialtyView(),
      binding: SpecialtyBinding(),
    ),
  ];
}
