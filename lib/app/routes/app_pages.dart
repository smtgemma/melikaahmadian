import 'package:get/get.dart';

import '../modules/audio_call/bindings/audio_call_binding.dart';
import '../modules/audio_call/views/audio_call_view.dart';
import '../modules/auth/application_submit/bindings/application_submit_binding.dart';
import '../modules/auth/application_submit/views/application_submit_view.dart';
import '../modules/auth/bio/bindings/bio_binding.dart';
import '../modules/auth/bio/views/bio_view.dart';
import '../modules/auth/create_account/bindings/create_account_binding.dart';
import '../modules/auth/create_account/views/create_account_view.dart';
import '../modules/auth/create_account_with_email/bindings/create_account_with_email_binding.dart';
import '../modules/auth/create_account_with_email/views/create_account_with_email_view.dart';
import '../modules/auth/document_uplod/bindings/document_uplod_binding.dart';
import '../modules/auth/document_uplod/views/document_uplod_view.dart';
import '../modules/auth/document_uplod_page/bindings/document_uplod_page_binding.dart';
import '../modules/auth/document_uplod_page/views/document_uplod_page_view.dart';
import '../modules/auth/image_uplod/bindings/image_uplod_binding.dart';
import '../modules/auth/image_uplod/views/image_uplod_view.dart';
import '../modules/auth/log_in/bindings/log_in_binding.dart';
import '../modules/auth/log_in/views/log_in_view.dart';
import '../modules/auth/review_evrything/bindings/review_evrything_binding.dart';
import '../modules/auth/review_evrything/views/review_evrything_view.dart';
import '../modules/auth/set_new_password/bindings/set_new_password_binding.dart';
import '../modules/auth/set_new_password/views/set_new_password_view.dart';
import '../modules/auth/sign_up/bindings/sign_up_binding.dart';
import '../modules/auth/sign_up/views/sign_up_view.dart';
import '../modules/auth/specialty/bindings/specialty_binding.dart';
import '../modules/auth/specialty/views/specialty_view.dart';
import '../modules/auth/verification_code/bindings/verification_code_binding.dart';
import '../modules/auth/verification_code/views/verification_code_view.dart';
import '../modules/chat/bindings/chat_binding.dart';
import '../modules/chat/views/chat_view.dart';
import '../modules/home/add_details/bindings/add_details_binding.dart';
import '../modules/home/add_details/views/add_details_view.dart';
import '../modules/home/ai_analized_furniture/bindings/ai_analized_furniture_binding.dart';
import '../modules/home/ai_analized_furniture/views/ai_analized_furniture_view.dart';
import '../modules/home/ai_analye/bindings/ai_analye_binding.dart';
import '../modules/home/ai_analye/views/ai_analye_view.dart';
import '../modules/home/ai_genared_price/bindings/ai_genared_price_binding.dart';
import '../modules/home/ai_genared_price/views/ai_genared_price_view.dart';
import '../modules/home/all_item/bindings/all_item_binding.dart';
import '../modules/home/all_item/views/all_item_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/custom_furniture/bindings/custom_furniture_binding.dart';
import '../modules/home/custom_furniture/views/custom_furniture_view.dart';
import '../modules/home/review_video/bindings/review_video_binding.dart';
import '../modules/home/review_video/views/review_video_view.dart';
import '../modules/home/video_cmera/bindings/video_cmera_binding.dart';
import '../modules/home/video_cmera/views/video_cmera_view.dart';
import '../modules/home/views/home_view.dart';
import '../modules/move/bindings/move_binding.dart';
import '../modules/move/cencel_move/bindings/cencel_move_binding.dart';
import '../modules/move/cencel_move/views/cencel_move_view.dart';
import '../modules/move/cencel_mover_details/bindings/cencel_mover_details_binding.dart';
import '../modules/move/cencel_mover_details/views/cencel_mover_details_view.dart';
import '../modules/move/mover_profiel_details/bindings/mover_profiel_details_binding.dart';
import '../modules/move/mover_profiel_details/views/mover_profiel_details_view.dart';
import '../modules/move/offer_review/bindings/offer_review_binding.dart';
import '../modules/move/offer_review/views/offer_review_view.dart';
import '../modules/move/ongoing_move_update/bindings/ongoing_move_update_binding.dart';
import '../modules/move/ongoing_move_update/views/ongoing_move_update_view.dart';
import '../modules/move/ongoing_mover_details/bindings/ongoing_mover_details_binding.dart';
import '../modules/move/ongoing_mover_details/views/ongoing_mover_details_view.dart';
import '../modules/move/payment_details/bindings/payment_details_binding.dart';
import '../modules/move/payment_details/views/payment_details_view.dart';
import '../modules/move/prduct_details/bindings/prduct_details_binding.dart';
import '../modules/move/prduct_details/views/prduct_details_view.dart';
import '../modules/move/views/move_view.dart';
import '../modules/mover/mover_chat/bindings/mover_chat_binding.dart';
import '../modules/mover/mover_chat/views/mover_chat_view.dart';
import '../modules/mover/mover_home/bindings/mover_home_binding.dart';
import '../modules/mover/mover_home/mover_location_city/bindings/mover_location_city_binding.dart';
import '../modules/mover/mover_home/mover_location_city/views/mover_location_city_view.dart';
import '../modules/mover/mover_home/mover_move_detils_send_offer/bindings/mover_move_detils_send_offer_binding.dart';
import '../modules/mover/mover_home/mover_move_detils_send_offer/views/mover_move_detils_send_offer_view.dart';
import '../modules/mover/mover_home/mover_search_post/bindings/mover_search_post_binding.dart';
import '../modules/mover/mover_home/mover_search_post/views/mover_search_post_view.dart';
import '../modules/mover/mover_home/mover_serched_locationed/bindings/mover_serched_locationed_binding.dart';
import '../modules/mover/mover_home/mover_serched_locationed/views/mover_serched_locationed_view.dart';
import '../modules/mover/mover_home/views/mover_home_view.dart';
import '../modules/mover/mover_move/bindings/mover_move_binding.dart';
import '../modules/mover/mover_move/mover_information_about_the_cancalation/bindings/mover_information_about_the_cancalation_binding.dart';
import '../modules/mover/mover_move/mover_information_about_the_cancalation/views/mover_information_about_the_cancalation_view.dart';
import '../modules/mover/mover_move/mover_information_about_the_cancalation_cenceled/bindings/mover_information_about_the_cancalation_cenceled_binding.dart';
import '../modules/mover/mover_move/mover_information_about_the_cancalation_cenceled/views/mover_information_about_the_cancalation_cenceled_view.dart';
import '../modules/mover/mover_move/mover_move_compledet_detils/bindings/mover_move_compledet_detils_binding.dart';
import '../modules/mover/mover_move/mover_move_compledet_detils/views/mover_move_compledet_detils_view.dart';
import '../modules/mover/mover_move/mover_move_detils/bindings/mover_move_detils_binding.dart';
import '../modules/mover/mover_move/mover_move_detils/views/mover_move_detils_view.dart';
import '../modules/mover/mover_move/views/mover_move_view.dart';
import '../modules/mover/mover_navbar/bindings/mover_navbar_binding.dart';
import '../modules/mover/mover_navbar/views/mover_navbar_view.dart';
import '../modules/mover/mover_profile/my_eraning/bindings/my_eraning_binding.dart';
import '../modules/mover/mover_profile/my_eraning/views/my_eraning_view.dart';
import '../modules/mover/mover_profile/profile_my_profile/bindings/profile_my_profile_binding.dart';
import '../modules/mover/mover_profile/profile_my_profile/views/profile_my_profile_view.dart';
import '../modules/mover/mover_profile/profile_profile_edit/bindings/profile_profile_edit_binding.dart';
import '../modules/mover/mover_profile/profile_profile_edit/views/profile_profile_edit_view.dart';
import '../modules/navbar/bindings/navbar_binding.dart';
import '../modules/navbar/views/navbar_view.dart';
import '../modules/notification/bindings/notification_binding.dart';
import '../modules/notification/views/notification_view.dart';
import '../modules/role_selection/bindings/role_selection_binding.dart';
import '../modules/role_selection/views/role_selection_view.dart';
import '../modules/select_option/bindings/select_option_binding.dart';
import '../modules/select_option/views/select_option_view.dart';
import '../modules/setting/bindings/setting_binding.dart';
import '../modules/setting/cencel_request/bindings/cencel_request_binding.dart';
import '../modules/setting/cencel_request/views/cencel_request_view.dart';
import '../modules/setting/profile_change_password/bindings/profile_change_password_binding.dart';
import '../modules/setting/profile_change_password/views/profile_change_password_view.dart';
import '../modules/setting/profile_edit/bindings/profile_edit_binding.dart';
import '../modules/setting/profile_edit/views/profile_edit_view.dart';
import '../modules/setting/profile_privacy_policy/bindings/profile_privacy_policy_binding.dart';
import '../modules/setting/profile_privacy_policy/views/profile_privacy_policy_view.dart';
import '../modules/setting/profile_tramd_condition/bindings/profile_tramd_condition_binding.dart';
import '../modules/setting/profile_tramd_condition/views/profile_tramd_condition_view.dart';
import '../modules/setting/views/setting_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

import '../modules/mover/mover_profile/bindings/mover_profile_binding.dart'
    hide MoverProfileBinding;
import '../modules/mover/mover_profile/views/mover_profile_view.dart'
    hide MoverProfileView;

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
      name: _Paths.CENCEL_MOVER_DETAILS,
      page: () => const CencelMoverDetailsView(),
      binding: CencelMoverDetailsBinding(),
    ),
    GetPage(
      name: _Paths.ROLE_SELECTION,
      page: () => RoleSelectionView(),
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
    GetPage(name: _Paths.BIO, page: () => BioView(), binding: BioBinding()),
    GetPage(
      name: _Paths.SPECIALTY,
      page: () => const SpecialtyView(),
      binding: SpecialtyBinding(),
    ),
    GetPage(
      name: _Paths.DOCUMENT_UPLOD_PAGE,
      page: () => const DocumentUplodPageView(),
      binding: DocumentUplodPageBinding(),
    ),
    GetPage(
      name: _Paths.DOCUMENT_UPLOD,
      page: () => const DocumentUplodView(),
      binding: DocumentUplodBinding(),
    ),
    GetPage(
      name: _Paths.IMAGE_UPLOD,
      page: () => const ImageUplodView(),
      binding: ImageUplodBinding(),
    ),
    GetPage(
      name: _Paths.REVIEW_EVRYTHING,
      page: () => ReviewEvrythingView(),
      binding: ReviewEvrythingBinding(),
    ),
    GetPage(
      name: _Paths.APPLICATION_SUBMIT,
      page: () => const ApplicationSubmitView(),
      binding: ApplicationSubmitBinding(),
    ),
    GetPage(
      name: _Paths.VIDEO_CMERA,
      page: () => VideoCmeraView(),
      binding: VideoCmeraBinding(),
    ),
    GetPage(
      name: _Paths.REVIEW_VIDEO,
      page: () => ReviewVideoView(),
      binding: ReviewVideoBinding(),
    ),
    GetPage(
      name: _Paths.ADD_DETAILS,
      page: () => AddDetailsView(),
      binding: AddDetailsBinding(),
    ),
    GetPage(
      name: _Paths.AI_ANALIZED_FURNITURE,
      page: () => const AiAnalizedFurnitureView(),
      binding: AiAnalizedFurnitureBinding(),
    ),
    GetPage(
      name: _Paths.CUSTOM_FURNITURE,
      page: () => const CustomFurnitureView(),
      binding: CustomFurnitureBinding(),
    ),
    GetPage(
      name: _Paths.ALL_ITEM,
      page: () => const AllItemView(),
      binding: AllItemBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.AI_ANALYE,
      page: () => const AiAnalyeView(),
      binding: AiAnalyeBinding(),
    ),
    GetPage(
      name: _Paths.AI_GENARED_PRICE,
      page: () => const AiGenaredPriceView(),
      binding: AiGenaredPriceBinding(),
    ),
    GetPage(
      name: _Paths.ALL_ITEM,
      page: () => const AllItemView(),
      binding: AllItemBinding(),
    ),
    GetPage(
      name: _Paths.MOVE,
      page: () => const MoveView(),
      binding: MoveBinding(),
    ),
    GetPage(
      name: _Paths.CENCEL_MOVE,
      page: () => const CencelMoveView(),
      binding: CencelMoveBinding(),
    ),
    GetPage(
      name: _Paths.ONGOING_MOVER_DETAILS,
      page: () => const OngoingMoverDetailsView(),
      binding: OngoingMoverDetailsBinding(),
    ),
    GetPage(
      name: _Paths.ONGOING_MOVE_UPDATE,
      page: () => const OngoingMoveUpdateView(),
      binding: OngoingMoveUpdateBinding(),
    ),
    GetPage(
      name: _Paths.OFFER_REVIEW,
      page: () => const OfferReviewView(),
      binding: OfferReviewBinding(),
    ),
    GetPage(
      name: _Paths.MOVER_PROFIEL_DETAILS,
      page: () => MoverProfielDetailsView(),
      binding: MoverProfielDetailsBinding(),
    ),
    GetPage(
      name: _Paths.PRDUCT_DETAILS,
      page: () => const PrductDetailsView(),
      binding: PrductDetailsBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT_DETAILS,
      page: () => const PaymentDetailsView(),
      binding: PaymentDetailsBinding(),
    ),
    GetPage(
      name: _Paths.CHAT,
      page: () => const ChatView(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: _Paths.SETTING,
      page: () => const SettingView(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: _Paths.CENCEL_REQUEST,
      page: () => const CencelRequestView(),
      binding: CencelRequestBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_EDIT,
      page: () => const ProfileEditView(),
      binding: ProfileEditBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_CHANGE_PASSWORD,
      page: () => ProfileChangePasswordView(),
      binding: ProfileChangePasswordBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_TRAMD_CONDITION,
      page: () => const ProfileTramdConditionView(),
      binding: ProfileTramdConditionBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_PRIVACY_POLICY,
      page: () => const ProfilePrivacyPolicyView(),
      binding: ProfilePrivacyPolicyBinding(),
    ),
    GetPage(
      name: _Paths.MOVER_NAVBAR,
      page: () => const MoverNavbarView(),
      binding: MoverNavbarBinding(),
    ),
    GetPage(
      name: _Paths.MOVER_HOME,
      page: () => const MoverHomeView(),
      binding: MoverHomeBinding(),
    ),
    GetPage(
      name: _Paths.MOVER_SEARCH_POST,
      page: () => MoverSearchPostView(),
      binding: MoverSearchPostBinding(),
    ),
    GetPage(
      name: _Paths.MOVER_LOCATION_CITY,
      page: () => const MoverLocationCityView(),
      binding: MoverLocationCityBinding(),
    ),
    GetPage(
      name: _Paths.MOVER_SERCHED_LOCATIONED,
      page: () => const MoverSerchedLocationedView(),
      binding: MoverSerchedLocationedBinding(),
    ),
    GetPage(
      name: _Paths.MOVER_MOVE_DETILS_SEND_OFFER,
      page: () => const MoverMoveDetilsSendOfferView(),
      binding: MoverMoveDetilsSendOfferBinding(),
    ),
    GetPage(
      name: _Paths.MOVER_MOVE,
      page: () => const MoverMoveView(),
      binding: MoverMoveBinding(),
    ),
    GetPage(
      name: _Paths.MOVER_INFORMATION_ABOUT_THE_CANCALATION_CENCELED,
      page: () => const MoverInformationAboutTheCancalationCenceledView(),
      binding: MoverInformationAboutTheCancalationCenceledBinding(),
    ),
    GetPage(
      name: _Paths.MOVER_INFORMATION_ABOUT_THE_CANCALATION,
      page: () => const MoverInformationAboutTheCancalationView(),
      binding: MoverInformationAboutTheCancalationBinding(),
    ),
    GetPage(
      name: _Paths.MOVER_MOVE_COMPLEDET_DETILS,
      page: () => const MoverMoveCompledetDetilsView(),
      binding: MoverMoveCompledetDetilsBinding(),
    ),
    GetPage(
      name: _Paths.MOVER_MOVE_DETILS,
      page: () => const MoverMoveDetilsView(),
      binding: MoverMoveDetilsBinding(),
    ),
    GetPage(
      name: _Paths.MOVER_CHAT,
      page: () => const MoverChatView(),
      binding: MoverChatBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_MY_PROFILE,
      page: () => const ProfileMyProfileView(),
      binding: ProfileMyProfileBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_PROFILE_EDIT,
      page: () => const ProfileProfileEditView(),
      binding: ProfileProfileEditBinding(),
    ),
    GetPage(
      name: _Paths.MY_ERANING,
      page: () => const MyEraningView(),
      binding: MyEraningBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => const NotificationView(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: _Paths.AUDIO_CALL,
      page: () => const AudioCallView(),
      binding: AudioCallBinding(),
    ),
  ];
}
