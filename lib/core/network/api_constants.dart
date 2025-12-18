class ApiConstants {
  static const String baseUrl = "https://deliveria.low-high.org";
  static const String signUpUrl = "$baseUrl/users/signup";
  static const String loginUrl = "/auth/login";
  static const String allResturantAdmin = "/restaurants/all";
  static const String allRatedResturant = "/restaurants/all_rated";
  static const String createCouponeLink = "/coupon_codes/create";
  static const String createResturantLink = "/restaurants/create";
  static const String superCategoryLink = "/super_categories/all";
  static const String getNearbyResLink = "/restaurants/home";
  static const String getDeliveryAgent = "/agents/all";
  static const String createAgent = "/agents/create";
  static const String apiKey =
      "ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2TVRBMk5qWTJOeXdpYm1GdFpTSTZJakUzTlRRM05qazBPRGN1TURReE16Y3lJbjAuQXQyUFNXc2NwVVZZeVRxRGhvVFctVUdraHlHbVJ1V3F2MUlEWGgxSGZwVXhMTXZzdHNsbzlSV2M3Qmx2aXI3SnN5U0pDU0tiV045WG9QMzJXRVJtT2c=";
  static const integrationId = "5229349";
  static const iFrameId = "947222";
  static const secretKey =
      "egy_sk_test_71a56c7075184aea57e1caa24e43348c59f3416ea1799faa646e59a6cadea7c5";
  static const String getPaymobTokenLink = "/auth/tokens";
  static const String createPaymobOrder = "/ecommerce/orders";
  static const String getPaymentKey = "/acceptance/payment_keys";
  static const String createAddressLink = "/address/create";
  static const String getAddressLink = "/address";
  static const String addCartLink = "/carts/add";
  static const String increaseItemCartLink = "/carts/increase-item";
  static const String decreaseItemCartLink = "/carts/decrease-item";
  static const String removeCartLink = "/carts/remove";
  static const String getCartLink = "/carts";
  static const String addOrderLink = "/orders/add";
  static const String getOrdersLink = "/orders";
  static const String getFavLink = "/favourites";
  static const String getIncomingOrdersAgentLink = "/delivery/available";
  static const String getmyOrdersAgentLink = "/delivery/my_orders";
  static const String getSlidersLink = "/sliders/all";
  static const String createSliderLink = "/sliders/create";
  static const String getDataLink = "/auth/get_data";
  static const String updateUserInfoLink = "/users/update";
  static const String getMyOrdersLink = "/restaurants/my_orders";
  static const String acceptedOrderLink = "/delivery/my_orders";

  static const String getOrdersNotAcceptedAgentLink = "/delivery/available";

  static const String addReviewLink = "/restaurants/add_review";

  static const String getUsersLink = "/users/all";

  static const String getCouponesLink = "/coupon_codes";

  static const String searchUsers = "/users/search";

  static const String searchResturant = "/restaurants/admin_search";

  static const String getHomeDataResLink = "/restaurants/home_data";
  static const String getHomeDataAdminLink = "/admins/get_data_of_app";

  static const String getNotificationLink = "/notifications/get";
  static const String createNotificationLink = "/notifications/create";

  static const String getSystemDataLink = "/system/";
  static const String allOrdersLink = "/orders/all";

  static var apiKeyOtp =
      'f96f2653bcffae32c7b1939e86f06869a95f107fd31e023bd21ad04e6b7eeb48';

  static var piplineId = '68f3aff0dddc0839d5019f3b';
}

class ApiErrors {
  static const String badRequestError = "badRequestError";
  static const String noContent = "noContent";
  static const String forbiddenError = "forbiddenError";
  static const String unauthorizedError = "unauthorizedError";
  static const String notFoundError = "notFoundError";
  static const String conflictError = "conflictError";
  static const String internalServerError = "internalServerError";
  static const String unknownError = "unknownError";
  static const String timeoutError = "timeoutError";
  static const String defaultError = "defaultError";
  static const String cacheError = "cacheError";
  static const String noInternetError = "noInternetError";
  static const String loadingMessage = "loading_message";
  static const String retryAgainMessage = "retry_again_message";
  static const String ok = "Ok";
}
