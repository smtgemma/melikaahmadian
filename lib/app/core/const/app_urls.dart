class AppUrls {
  static const baseUrl = "http://206.162.244.175:6008/api/v1";
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
  static const getAllChat = "$baseUrl/conversations/my-conversations";
  static getMyChatList(int page, int limit) =>
      "$baseUrl/conversations/695f341bfb3399f08442e8a7/messages?page=$page&limit=$limit";
  static const forget_password = "/auth/forgot-password";
  static String getOfferForSpecificPost(String? id) => "/offers/post/$id";
  static String getSinglePost(String? id) => "/posts/$id";
}
