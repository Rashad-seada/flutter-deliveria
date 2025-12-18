import 'dart:convert';
import 'dart:io';

import 'package:delveria/core/network/api_constants.dart';
import 'package:delveria/features/ResturantOwner/home/data/models/get_home_data_resturant_response.dart';
import 'package:delveria/features/ResturantOwner/home/data/models/get_resturant_data_response.dart';
import 'package:delveria/features/ResturantOwner/menu/data/models/change_enable_item_response.dart';
import 'package:delveria/features/ResturantOwner/menu/data/models/create_item_response.dart';
import 'package:delveria/features/ResturantOwner/menu/data/models/edit_item_response.dart';
import 'package:delveria/features/ResturantOwner/menu/data/models/filter_item_category_response_user.dart';
import 'package:delveria/features/ResturantOwner/menu/data/models/get_all_item_response.dart';
import 'package:delveria/features/ResturantOwner/menu/data/models/item_categories_response_user.dart';
import 'package:delveria/features/ResturantOwner/menu/data/models/items_category_model.dart';
import 'package:delveria/features/ResturantOwner/ordersResturantScreen/data/models/get_orders_resturant_response.dart';
import 'package:delveria/features/ResturantOwner/resturantNotification/data/models/notifications_model.dart';
import 'package:delveria/features/ResturantOwner/resturantProfile/data/models/get_resturant_data_response_for_profile.dart';
import 'package:delveria/features/admin/coupons/data/models/coupone_request.dart';
import 'package:delveria/features/admin/coupons/data/models/coupone_response.dart';
import 'package:delveria/features/admin/coupons/data/models/get_all_coupon_response.dart';
import 'package:delveria/features/admin/deliveryAgent/data/models/all_orders_model.dart';
import 'package:delveria/features/admin/deliveryAgent/data/models/create_agent_request.dart';
import 'package:delveria/features/admin/deliveryAgent/data/models/create_agnet_response.dart';
import 'package:delveria/features/admin/deliveryAgent/data/models/each_agent_order_model.dart';
import 'package:delveria/features/admin/deliveryAgent/data/models/get_delivery_agent_response.dart';
import 'package:delveria/features/admin/deliveryAgent/data/models/order_details_model.dart';
import 'package:delveria/features/admin/home/data/models/get_home_data_admin_response.dart';
import 'package:delveria/features/admin/resturantAdmin/data/models/all_resturant_admin_response.dart';
import 'package:delveria/features/admin/resturantAdmin/data/models/change_enable_response.dart';
import 'package:delveria/features/admin/resturantAdmin/data/models/create_resturant_response.dart';
import 'package:delveria/features/admin/resturantAdmin/data/models/super_categories_response.dart';
import 'package:delveria/features/admin/slider/data/models/create_slider_response.dart';
import 'package:delveria/features/admin/slider/data/models/delete_slider_response.dart';
import 'package:delveria/features/admin/users/data/models/ban_user_response.dart';
import 'package:delveria/features/admin/users/data/models/get_all_users_model.dart';
import 'package:delveria/features/admin/users/data/models/search_response.dart';
import 'package:delveria/features/admin/users/data/models/users_model.dart';
import 'package:delveria/features/client/accountInfo/data/model/get_user_data_response.dart';
import 'package:delveria/features/client/accountInfo/data/model/update_user_info_response.dart';
import 'package:delveria/features/client/adresses/data/models/add_address_request.dart';
import 'package:delveria/features/client/adresses/data/models/address_response.dart';
import 'package:delveria/features/client/adresses/data/models/delete_address_response.dart';
import 'package:delveria/features/client/adresses/data/models/get_addresses_response.dart';
import 'package:delveria/features/client/auth/login/data/models/login_request.dart';
import 'package:delveria/features/client/auth/login/data/models/login_response.dart';
import 'package:delveria/features/client/auth/signUp/data/models/sign_up_request_body.dart';
import 'package:delveria/features/client/auth/signUp/data/models/sign_up_response.dart';
import 'package:delveria/features/client/cart/data/models/add_cart_response.dart';
import 'package:delveria/features/client/cart/data/models/add_order_response.dart';
import 'package:delveria/features/client/cart/data/models/add_to_cart_request.dart';
import 'package:delveria/features/client/cart/data/models/decrease_item_cart_response.dart';
import 'package:delveria/features/client/cart/data/models/get_cart_response.dart';
import 'package:delveria/features/client/cart/data/models/increase_item_cart_response.dart';
import 'package:delveria/features/client/cart/data/models/remove_cart_response.dart';
import 'package:delveria/features/client/fav/data/models/add_to_fav_res.dart';
import 'package:delveria/features/client/fav/data/models/delete_fav_response.dart';
import 'package:delveria/features/client/fav/data/models/get_fav_response.dart';
import 'package:delveria/features/client/filter/data/models/filter_by_category_response.dart';
import 'package:delveria/features/client/filter/data/models/sort_by_price.dart';
import 'package:delveria/features/client/home/data/models/get_nearby_response.dart';
import 'package:delveria/features/client/home/data/models/get_sliders_response.dart';
import 'package:delveria/features/client/home/data/models/search_response.dart';
import 'package:delveria/features/client/onboarding/data/models/get_system_data_response.dart';
import 'package:delveria/features/client/orders/data/models/get_orders_model.dart';
import 'package:delveria/features/client/orders/data/models/reorder_response.dart';
import 'package:delveria/features/client/payment/data/models/payment_key_response.dart';
import 'package:delveria/features/client/payment/data/models/payment_order_response.dart';
import 'package:delveria/features/client/payment/data/models/paymobe_token_response.dart';
import 'package:delveria/features/client/reviews/ui/add_review_screen.dart';
import 'package:delveria/features/client/reviews/data/models/add_review_response.dart';
import 'package:delveria/features/deliveryAgent/data/models/accept_orders_model.dart';
import 'package:delveria/features/deliveryAgent/data/models/get_accepted_orders.dart';
import 'package:delveria/features/deliveryAgent/data/models/get_not_accepted_order_agent.dart';
import 'package:delveria/features/deliveryAgent/data/models/update_agent_order_status_response.dart';
import 'package:delveria/features/deliveryAgent/data/models/update_location_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_services.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ApiServices {
  factory ApiServices(Dio dio, {String? baseUrl}) = _ApiServices;
  //*User
  @POST(ApiConstants.signUpUrl)
  Future<SignUpResponse> signUp(@Body() SignUpRequestBody signUpRequestBody);
  @POST(ApiConstants.loginUrl)
  Future<LoginResponse> login(@Body() LoginRequestBody loginRequestBody);
  @POST(ApiConstants.createAddressLink)
  Future<AddressResponse> createAddress(
    @Body() AddAddressRequest addAddressRequest,
  );
  @GET(ApiConstants.getAddressLink)
  Future<GetAddressesResponse> getAddress(@Body() Map<String, dynamic> body);
  @GET(ApiConstants.getSystemDataLink)
  Future<GetSystemDataResponse> getSystemData(
    @Body() Map<String, dynamic> body,
  );
  @GET(ApiConstants.getSlidersLink)
  Future<GetSlidersResponse> getSliders(@Body() Map<String, dynamic> body);
  @GET(ApiConstants.getDataLink)
  Future<GetUserDataResponse> getUserData(@Body() Map<String, dynamic> body);
  @PUT(ApiConstants.updateUserInfoLink)
  Future<UpdateUserInfoResponse> updateUserInfo(
    @Body() Map<String, dynamic> body,
  );
  @GET("/restaurants/home/{lat}/{long}")
  Future<GetNearbyResponse> getNearbyResturants(
    @Body() Map<String, dynamic> body,
    @Path('lat') double lat,
    @Path('long') double long,
  );
  @GET("/restaurants/category/{superId}/{subId}/{lat}/{long}")
  Future<FilterbyCategoryResponse> filterByCategory(
    @Body() Map<String, dynamic> body,
    @Path('superId') String superId,
    @Path('subId') String subId,
    @Path('lat') double lat,
    @Path('long') double long,
  );
  @POST(ApiConstants.addCartLink)
  Future<AddCartResponse> addToCart(@Body() AddToCartRequest addToCart);
  @GET(ApiConstants.getCartLink)
  Future<GetCartResponse> getCart(@Body() Map<String, dynamic> body);
  @PUT(ApiConstants.increaseItemCartLink)
  Future<IncreaseItemCartResponse> increaseItemCart(
    @Body() Map<String, dynamic> body,
  );
  @PUT("/address/change_default/{id}")
  Future changeDefault(
    @Path('id') String id,
    @Body() Map<String, dynamic> body,
  );
  @PUT(ApiConstants.decreaseItemCartLink)
  Future<DecreaseItemCartResponse> decreaseItem(
    @Body() Map<String, dynamic> body,
  );
  @PUT(ApiConstants.removeCartLink)
  Future<RemoveCartResponse> removeCart(@Body() Map<String, dynamic> body);
  @POST(ApiConstants.addOrderLink)
  Future<AddOrderResponse> addOrder(@Body() Map<String, dynamic> body);
  @GET(ApiConstants.getOrdersLink)
  Future<GetOrdersModel> getOrders(@Body() Map<String, dynamic> body);
  @GET("/items/sort_by_price/{code}")
  Future<SortByPriceResponse> sortByPrice(@Path('code') String resId);
  @PUT("/favourites/add/{code}")
  Future<AddToFavRes> addToFav(
    @Path('code') String resId,
    @Body() Map<String, dynamic> body,
  );
  @PUT("/orders/reorder/{code}")
  Future<ReorderResponse> reorder(
    @Path('code') String orderId,
    @Body() Map<String, dynamic> body,
  );
  @GET(ApiConstants.getNotificationLink)
  Future<NotificationsModel> getNotification(@Body() Map<String, dynamic> body);
  @GET(ApiConstants.getFavLink)
  Future<GetFavResponse> getFav(@Body() Map<String, dynamic> body);
  @PUT("/favourites/remove/{resId}")
  Future<DeleteFavResponse> deleteFav(
    @Path('resId') String resId,
    @Body() Map<String, dynamic> body,
  );
  @PUT(ApiConstants.addReviewLink)
  Future<AddReviewResponse> addReview(@Body() Map<String, dynamic> body);
  @POST("/restaurants/search/{lat}/{long}")
  Future<AllResturantAdminResponse> searchResturantUserSider(
    @Body() Map<String, dynamic> body,
    @Path("lat") double lat,
    @Path("long") double long,
  );
  @DELETE("/address/delete/{addressId}")
  Future<DeleteAddressResponse> deleteAddress(
    @Path("addressId") String addressId,
    @Body() Map<String, dynamic> body,
  );
  //*Admin
  @GET(ApiConstants.allOrdersLink)
  Future<AllOrdersModel> getAllOrders(@Body() Map<String, dynamic> body);
  @GET("/agents/id/{id}")
  Future<EachAgentOrderResponse> getAllOrdersForEachAgent(
    @Body() Map<String, dynamic> body,
    @Path("id") String id,
  );
  @GET("/orders/id/{id}")
  Future<OrderDetailsResponse> getOrderDetails(@Body() Map<String, dynamic> body , @Path("id") String id);
  @POST(ApiConstants.createNotificationLink)
  Future createNotification(@Body() Map<String, dynamic> body);
  @GET(ApiConstants.allResturantAdmin)
  Future<AllResturantAdminResponse> getAllResturantAdmin(
    @Body() Map<String, dynamic> body,
    @Header("Authorization") String authorization,
  );
  @GET("/restaurants/all_rated/{lat}/{long}")
  Future<AllResturantAdminResponse> getAllRatedResturantAdmin(
    @Body() Map<String, dynamic> body,
    @Path('lat') double lat,
    @Path('long') double long,
  );
  @GET("/restaurants/all_rated_admin")
  Future<AllResturantAdminResponse> getAllRatedResturantWithoutLocation(
    @Body() Map<String, dynamic> body,
  );
  @GET(ApiConstants.superCategoryLink)
  Future<SuperCategoriesResponse> getAllSuperCategories();
  @POST(ApiConstants.createCouponeLink)
  Future<CouponeResponse> creatCoupone(@Body() CouponeRequest request);
  @POST('/coupon_codes/check/{code}')
  Future<CouponeResponse> checkCoupone(
    @Path('code') String code,
    @Body() Map<String, dynamic> body,
  );
  @GET('/items/all_items_for_restaurant/{code}/all')
  Future<GetAllItemsResponse> getAllItems(@Path('code') String code);
  @PUT('/restaurants/change_enable/{resturantId}')
  Future<ChangeEnableResponse> changeEnable(
    @Path('resturantId') String code,
    @Body() Map<String, dynamic> body,
  );
  @PUT('/items/change_enable/{id}')
  Future<ChangeEnableItemResponse> changeEnableItem(
    @Path('id') String id,
    @Body() Map<String, dynamic> body,
  );
  @POST(ApiConstants.createResturantLink)
  Future<CreateResturantResponse> creatResturant(
    @Body() FormData formData,
    @Header("Authorization") String authorization,
  );
  @PUT("/restaurants/update/{id}")
  Future editRestaurantProfile(
        @Path('id') String id,

    @Body() FormData formData,
    @Header("Authorization") String authorization,
  );
  @GET("/items/search/{id}/{search}")
  Future<SearchResponseItem> searchRestaurnt(
    @Path('id') String id,
    @Path('search') String search,
    @Body() Map<String, dynamic> body,
  );

  @POST(ApiConstants.createSliderLink)
  @MultiPart()
  Future<CreateSliderResponse> createSlider(
    @Part(name: "image") File image,
    @Part(name: "restaurant_id") String restaurantid
  
  );
  @GET(ApiConstants.getDeliveryAgent)
  Future<GetDeliveryAgentResponse> getAllAgents();
  @POST(ApiConstants.createAgent)
  Future<CreateAgentResponse> createAgent(
    @Body() CreateAgentRequest createAgentReq,
  );
  @DELETE('/sliders/delete/{code}')
  Future<DeleteSliderResponse> deleteSlider(
    @Path('code') String code,
    @Body() Map<String, dynamic> body,
  );
  @GET(ApiConstants.getUsersLink)
  Future<GetAllUsersModel> getAllUsers(@Body() Map<String, dynamic> body);

  @GET("/restaurants/admin_category/{super}/{sub}")
  Future<FilterbyCategoryResponse> filterByCategoryAdmin(
    @Body() Map<String, dynamic> body,
    @Path('super') String superId,
    @Path('sub') String subId,
  );
  @PUT("/users/change_ban/{userId}")
  Future<BanUserResponse> banUser(
    @Body() Map<String, dynamic> body,
    @Path('userId') String userId,
  );
  @PUT("/agents/change_ban/{agentId}")
  Future<BanUserResponse> banAgent(
    @Body() Map<String, dynamic> body,
    @Path('agentId') String agentId,
  );
  @PUT("/coupon_codes/change_enable/{couponId}")
  Future<BanUserResponse> changeEnableCoupon(
    @Body() Map<String, dynamic> body,
    @Path('couponId') String couponId,
  );
  @GET(ApiConstants.getCouponesLink)
  Future<GetAllCouponesResponse> getCoupons(@Body() Map<String, dynamic> body);
  @POST(ApiConstants.searchUsers)
  Future<GetAllUsersModel> searchUser(@Body() Map<String, dynamic> body);
  @POST(ApiConstants.searchResturant)
  Future<AllResturantAdminResponse> searchResturant(
    @Body() Map<String, dynamic> body,
  );
  @GET(ApiConstants.getHomeDataAdminLink)
  Future<GetHomeDataAdminResponse> getHomeDataAdmin(
    @Body() Map<String, dynamic> body,
  );

  //* resturant owner
  @POST('/items/create')
  @MultiPart()
  Future<CreateItemResponse> createItem(
    @Part(name: "photo") File photo,
    @Part(name: "name") String name,
    @Part(name: "description") String description,
    @Part(name: "item_category") String item_category,
    @Part(name: "sizes") String sizes,
    @Part(name: "toppings") String toppings,
    @Part(name: "have_option") bool have_option,
  );
  @PUT('/items/update/{code}')
  Future<EditItemResponse> editItem(
    @Path('code') String code,
    @Body() Map<String, dynamic> body,
    @Header("Authorization") String authorization,
  );
  @DELETE('/items/delete/{code}')
  Future<EditItemResponse> deletItem(
    @Path('code') String code,
    @Body() Map<String, dynamic> body,
  );
  @GET('/item_categories/restaurant')
  Future<ItemsCategoryResponse> getItemsCategories(
    @Body() Map<String, dynamic> body,
  );
  @GET('/item_categories/user/{resId}')
  Future<ItemsCategoryResponseUser> getItemsCategoriesUser(
    @Path("resId") String resId,
    @Header("Authorization") String authorization,

    @Body() Map<String, dynamic> body,
  );
  @GET('/items/all_items_for_restaurant/{resId}/{cateId}')
  Future<GetAllItemsResponse> filtertemsCategoriesUser(
    @Path("cateId") String cateId,
    @Path("resId") String resId,
    @Header("Authorization") String authorization,

    @Body() Map<String, dynamic> body,
  );
  @POST('/item_categories/create')
  Future<CreateItemResponse> createItemCategory(
    @Body() Map<String, dynamic> body,
  );
  @GET(ApiConstants.getDataLink)
  Future<GetResturantDataResponseHome> getResturantData(
    @Body() Map<String, dynamic> body,
  );
  @GET(ApiConstants.getMyOrdersLink)
  Future<GetOrdersResturantResponse> getOrdersResturant(
    @Body() Map<String, dynamic> body,
  );
  @GET(ApiConstants.getDataLink)
  Future<GetResturantDataResponseProfile> getResturantProfileData(
    @Body() Map<String, dynamic> body,
  );
  @PUT('/restaurants/change_enable/{resturantId}')
  Future<ChangeEnableResponse> changeEnableResturantOwner(
    @Path('resturantId') String code,
    @Body() Map<String, dynamic> body,
  );
  @GET(ApiConstants.getHomeDataResLink)
  Future<GetHomeDataResturantResponse> getHomeDataResturant(
    @Body() Map<String, dynamic> body,
  );
  // @PUT("/restaurants/accept_order/{orderId}")
  // Future<AcceptOrderResponse> acceptOrder(
  //   @Path("orderId") String orderId,
  //   @Body() Map<String, dynamic> body,
  // );
  //*Paymob
  @POST("https://accept.paymob.com/api${ApiConstants.getPaymobTokenLink}")
  Future<PaymobeTokenResponse> getPaymobToken(
    @Body() Map<String, dynamic> data,
  );
  @POST("https://accept.paymob.com/api${ApiConstants.createPaymobOrder}")
  Future<PaymobOrderResponse> createPaymobOrder(
    @Body() Map<String, dynamic> data,
    @Header("Authorization") String authorization,
  );

  @POST("https://accept.paymob.com/api${ApiConstants.getPaymentKey}")
  Future<PaymentKeyResponse> getPaymentKey(
    @Body() Map<String, dynamic> data,
    @Header("Authorization") String authorization,
  );
  // @GET("https://accept.paymob.com/api/acceptance/transactions/{transactionId}")
  // Future<Map<String, dynamic>> checkPaymentStatus(
  //   @Path("transactionId") String transactionId,
  //   @Header("Authorization") String authorization,
  // );

  //* Agent
  @GET(ApiConstants.getOrdersNotAcceptedAgentLink)
  Future<GetNotAcceptedOrderAgentResponse> getCurrentOrders(
    @Body() Map<String, dynamic> body,
  );

  @GET(ApiConstants.acceptedOrderLink)
  Future<GetAcceptedOrdersResponse> getAcceptedOrders(
    @Body() Map<String, dynamic> body,
  );

  @PUT("/delivery/accept/{orderId}")
  Future<AcceptOrdersModel> acceptOrder(
    @Path("orderId") String orderId,
    @Body() Map<String, dynamic> body,
  );
  @PUT("/restaurants/accept_order/{orderId}/{subOrderId}")
  Future<AcceptOrdersModel> acceptOrderRestaurant(
    @Path("orderId") String orderId,
    @Path("subOrderId") String subOrderId,
    @Body() Map<String, dynamic> body,
  );
  @PUT("/restaurants/ready_for_pickup_order/{orderId}/{subOrderId}")
  Future<AcceptOrdersModel> readyForPickUp(
    @Path("orderId") String orderId,
    @Path("subOrderId") String subOrderId,
    @Body() Map<String, dynamic> body,
  );

  @PUT("/delivery/order/{orderId}/status")
  Future<UpdateAgentOrderStatusResponse> updateAgentOrderStatus(
    @Path("orderId") String orderId,
    @Body() Map<String, dynamic> body,
  );

  @POST("/delivery/agent/location")
  Future<UpdateLocationResponse> updateAgentLocation(
    @Body() Map<String, dynamic> body,
  );
}
