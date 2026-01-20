class AppUrls {
  static const baseUrl = "http://206.162.244.175:6008/api/v1";
  static const aibaseUrl = "http://206.162.244.175:3033/api/v1";
  static const refreshToken = "${baseUrl}/auth/refresh-token";
  static const loginWithGoogle = "${baseUrl}/auth/google-login";
  static const createPaymentIntent = "${baseUrl}/payments/create-intent";
  static acceptOffer(String offerId) => "${baseUrl}/offers/$offerId/accept";
  static paymentConfirm(String paymentIntentId) =>
      "https://api.stripe.com/v1/payment_intents/$paymentIntentId/confirm";

  static const createAccount = "/auth/create-account";
  static const login = "/auth/login";
  static const verfyEmail = "/auth/email-verify";
  static const getMyProfile = "/users/me";
  static const updateProfile = "/users/update-profile";
  static const chnagePassword = "/auth/change-password";
  static const providerOnbording = "/users/provider-onboarding";
  static const getFurnitureByCatagory = "/furniture";
  static const post = "/posts";
  static const sendOffer = "/offers";
  static const uploadProfilePicture = "/users/me/uploads-profile-photo";
  static const treanAndCondition = "/rules/terms-and-conditions";
  static const privacyAndPolicy = "/rules/privacy-policy";
  static const updateProfileNameSpecialization = "/users/provider/profile";
  static const deleteVehiclePhoto = "/users/provider/vehicle-photos";
  static const updateProfilevehicalPhoto = "/users/provider/vehicle-photos";
  static const changePassword = "/auth/change-password";
  static const resetPassword = "/auth/reset-password";
  static const verifyResetPasswordotp = "/auth/verify-reset-password-otp";

  static const my_post = "/posts/my-posts";
  static const getAllChat = "$baseUrl/conversations/my-conversations";
  static const createConversation = "$baseUrl/conversations";
  static getMyChatList(String id, int page, int limit) =>
      "$baseUrl/conversations/$id/messages?page=$page&limit=$limit";
  static const get_my_offer = "/offers/my-offers";
  static const forget_password = "/auth/forgot-password";
  static const analyzVideo = "analyze-video";
  static const uploadPicture = "/users/me/uploads-profile-photo";

  static String getOfferForSpecificPost(String? id) => "/offers/post/$id";
  static String getSinglePost(String? id) => "/posts/$id";
  static String getUserProfileId(String? id) => "/users/$id";
  static String getReviewByUser(String? id) => "/reviews/user/$id";
  static String cancelPost(String? id) => "/posts/cancel/$id";
  static String cancelOffer(String? id) => "/offers/cancel/$id";
  static String statusChange(String? id) => "/posts/status/$id";
  static String getMoveStatus(String? id) => "/posts/move-status/$id";
  static String moveStatusChange(String? id) => "/posts/move-status/$id";
}

//https://images.rawpixel.com/image_800/czNmcy1wcml2YXRlL3Jhd3BpeGVsX2ltYWdlcy93ZWJzaXRlX2NvbnRlbnQvbHIvdjkzNy1hZXctMTY1LWtsaGN3ZWNtLmpwZw.jpg

// Obx(() {
// final data =
// controller.profileModel.value?.data?.image;
// if (data == null || data.isEmpty) {
// return AppImageFrameRadiousWidget(
// radious: 50,
// imageLink:
// "https://images.rawpixel.com/image_800/czNmcy1wcml2YXRlL3Jhd3BpeGVsX2ltYWdlcy93ZWJzaXRlX2NvbnRlbnQvbHIvdjkzNy1hZXctMTY1LWtsaGN3ZWNtLmpwZw.jpg",
// );
// }
//
// return AppImageFrameRadiousWidget(
// radious: 50,
// imageLink:
// controller.profileModel.value?.data?.image,
// );
// }),
