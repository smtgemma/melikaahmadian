 class AppUrls {
  static const baseUrl = "http://206.162.244.175:6008/api/v1";
  static const aibaseUrl = "http://206.162.244.175:3033/api/v1";
  static const refreshToken = "${baseUrl}/auth/refresh-token";

  static const createAccount = "/auth/create-account";
  static const login = "/auth/login";
  static const verfyEmail = "/auth/email-verify";
  static const getMyProfile = "/users/me";
  static const updateProfile = "/users/update-profile";
  static const chnagePassword = "/auth/change-password";
  static const providerOnbording = "/users/provider-onboarding";
  static const getFurnitureByCatagory = "/furniture";
  static const post = "/posts";
  static const my_post = "/posts/my-posts";
  static const get_my_offer = "/offers/my-offers";
  static const forget_password = "/auth/forgot-password";
  static const analyzVideo = "analyze-video";


  static String getOfferForSpecificPost(String? id) => "/offers/post/$id";
  static String getSinglePost(String? id) => "/posts/$id";
  static String getUserProfileId(String? id) => "/users/$id";
  static String getReviewByUser(String? id) => "/reviews/user/$id";
  static String cancelPost(String? id) => "/posts/cancel/$id";
  static String statusChange(String? id) => "/posts/status/$id";










 }//https://images.rawpixel.com/image_800/czNmcy1wcml2YXRlL3Jhd3BpeGVsX2ltYWdlcy93ZWJzaXRlX2NvbnRlbnQvbHIvdjkzNy1hZXctMTY1LWtsaGN3ZWNtLmpwZw.jpg

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