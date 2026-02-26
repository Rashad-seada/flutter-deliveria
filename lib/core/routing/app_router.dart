import 'package:delveria/core/di/dependancy_injection.dart';
import 'package:delveria/core/routing/routes.dart';
import 'package:delveria/features/ResturantOwner/bottomNavBarResturant.dart/logic/cubit/resturant_bottom_nav_bar_cubit.dart';
import 'package:delveria/features/ResturantOwner/bottomNavBarResturant.dart/ui/bottom_nav_bar.dart';
import 'package:delveria/features/ResturantOwner/home/logic/cubit/resturant_data_cubit.dart';
import 'package:delveria/features/ResturantOwner/menu/logic/cubit/item_cubit.dart';
import 'package:delveria/features/ResturantOwner/menu/logic/cubit/menu_resturant_cubit.dart';
import 'package:delveria/features/ResturantOwner/menu/ui/edit_your_item.dart';
import 'package:delveria/features/ResturantOwner/ordersResturantScreen/ui/new_orders_details_screen.dart';
import 'package:delveria/features/ResturantOwner/resturantNotification/logic/cubit/notifications_cubit.dart';
import 'package:delveria/features/ResturantOwner/resturantNotification/logic/cubit/notifications_cubit.dart';
import 'package:delveria/features/ResturantOwner/resturantNotification/ui/resturant_notification.dart';
import 'package:delveria/features/ResturantOwner/resturantReviews/ui/resturant_reviews_screen.dart';
import 'package:delveria/features/ResturantOwner/settingsResturant/ui/settings_resturant_screen.dart';
import 'package:delveria/features/admin/adminBottomBar/logic/cubit/admin_bottom_bar_cubit.dart';
import 'package:delveria/features/admin/adminBottomBar/ui/admin_bottom_bar.dart';
import 'package:delveria/features/admin/coupons/logic/cubit/coupone_cubit.dart';
import 'package:delveria/features/admin/coupons/data/models/coupon.dart';
import 'package:delveria/features/admin/coupons/logic/cubit/pick_date_cubit.dart';
import 'package:delveria/features/admin/coupons/ui/add_coupon_screen.dart';
import 'package:delveria/features/admin/coupons/ui/coupons_screen.dart';
import 'package:delveria/features/admin/deliveryAgent/logic/cubit/agents_cubit.dart';
import 'package:delveria/features/admin/deliveryAgent/ui/add_delivery_agent_screen.dart';
import 'package:delveria/features/admin/deliveryAgent/ui/delivery_agent_list.dart';
import 'package:delveria/features/admin/home/ui/home_admin.dart';
import 'package:delveria/features/admin/home/ui/top_rated_list_screen.dart';
import 'package:delveria/features/admin/resturantAdmin/data/models/all_resturant_admin_response.dart';
import 'package:delveria/features/admin/resturantAdmin/logic/cubit/admin_resturant_filter_cubit.dart';
import 'package:delveria/features/admin/resturantAdmin/logic/cubit/all_resturants_admin_cubit.dart';
import 'package:delveria/features/admin/resturantAdmin/ui/add_restaurant_screen.dart';
import 'package:delveria/features/admin/resturantAdmin/ui/admin_categories_filter.dart';
import 'package:delveria/features/admin/resturantAdmin/ui/admin_top_rated_filter.dart';
import 'package:delveria/features/admin/slider/ui/add_new_slider.dart';
import 'package:delveria/features/admin/slider/ui/delete_slider_screen.dart';
import 'package:delveria/features/admin/users/ui/numbers_of_orders_user_list.dart';
import 'package:delveria/features/client/accountInfo/logic/cubit/user_data_cubit.dart';
import 'package:delveria/features/client/accountInfo/ui/account_info_screen.dart';
import 'package:delveria/features/client/accountInfo/ui/edit_account_info_screen.dart';
import 'package:delveria/features/client/adresses/logic/cubit/address_cubit.dart';
import 'package:delveria/features/client/adresses/logic/cubit/create_address_cubit.dart';
import 'package:delveria/features/client/adresses/ui/add_adress_screen.dart';
import 'package:delveria/features/client/adresses/ui/my_adress.dart';
import 'package:delveria/features/client/adresses/ui/location_picker_screen.dart';
import 'package:delveria/features/client/auth/changePassword/ui/change_password.dart';
import 'package:delveria/features/client/auth/changePassword/ui/success_change_password.dart';
import 'package:delveria/features/client/auth/forgetPassword/ui/forget_password.dart';
import 'package:delveria/features/client/auth/login/logic/cubit/login_cubit.dart';
import 'package:delveria/features/client/auth/login/login_screen.dart';
import 'package:delveria/features/client/auth/signUp/logic/cubit/signup_cubit.dart';
import 'package:delveria/features/client/auth/signUp/sign_up_screen.dart';
import 'package:delveria/features/client/bottom_nav_bar_screen.dart';
import 'package:delveria/features/client/cart/logic/cubit/add_to_cart_cubit.dart';
import 'package:delveria/features/client/cart/logic/cubit/cart_cubit.dart';
import 'package:delveria/features/client/cart/ui/cart_screen.dart';
import 'package:delveria/features/client/cart/ui/check_out_screen.dart';
import 'package:delveria/features/client/filter/ui/category_filter_screen.dart';
import 'package:delveria/features/client/filter/ui/rating_filter_screen.dart';
import 'package:delveria/features/client/home/logic/cubit/carousel_cubit.dart';
import 'package:delveria/features/client/home/logic/cubit/sliders_cubit.dart';
import 'package:delveria/features/client/home/ui/home_screen.dart';
import 'package:delveria/features/client/onboarding/logic/cubit/system_data_cubit.dart';
import 'package:delveria/features/client/onboarding/logic/onborading_cubit.dart';
import 'package:delveria/features/client/onboarding/ui/on_boarding_screen.dart';
import 'package:delveria/features/client/orders/logic/cubit/get_orders_cubit.dart';
import 'package:delveria/features/client/orders/ui/my_orders.dart';
import 'package:delveria/features/client/payment/ui/credit_card_info_screen.dart';
import 'package:delveria/features/client/payment/ui/payment_method_screen.dart';
import 'package:delveria/features/client/payment/ui/success_screen_order.dart';
import 'package:delveria/features/client/resturant/logic/cubit/resturant_menu_cubit.dart';
import 'package:delveria/features/client/resturant/ui/add_item_screen.dart';
import 'package:delveria/features/client/resturant/ui/restaurant_filteration_screen.dart';
import 'package:delveria/features/client/resturant/ui/resturant_screen.dart';
import 'package:delveria/features/client/reviews/logic/cubit/reviews_cubit.dart';
import 'package:delveria/features/client/reviews/ui/add_review_screen.dart';
import 'package:delveria/features/client/settings/ui/settings_screen.dart';
import 'package:delveria/features/deliveryAgent/logic/cubit/agent_orders_cubit.dart';
import 'package:delveria/features/deliveryAgent/ui/delivery_agent_home_screen.dart';
import 'package:delveria/features/client/loyalty/logic/cubit/loyalty_cubit.dart';
import 'package:delveria/features/client/loyalty/ui/loyalty_screen.dart';
import 'package:delveria/features/client/loyalty/ui/points_history_screen.dart';
import 'package:delveria/features/admin/loyalty/logic/cubit/admin_loyalty_cubit.dart';
import 'package:delveria/features/admin/loyalty/ui/reward_tiers_screen.dart';
import 'package:delveria/features/admin/loyalty/ui/users_points_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.onBoarding:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => OnboradingCubit(),
                child: OnBoardingScreen(),
              ),
        );
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder:
              (_) => MultiBlocProvider(
                providers: [
                  BlocProvider(create: (context) => getIt<LoginCubit>()),
                  BlocProvider(
                    create:
                        (context) => getIt<CreateAddressCubit>()..getAdresses(),
                  ),
                  BlocProvider(
                    create:
                        (context) => getIt<SystemDataCubit>()..getSystemData(),
                  ),
                ],
                child: LoginScreen(),
              ),
        );
      case Routes.signUpScreen:
        return MaterialPageRoute(
          builder:
              (_) => MultiBlocProvider(
                providers: [
                  BlocProvider(create: (context) => getIt<SignupCubit>()),
                  BlocProvider(create: (context) => getIt<LoginCubit>()),
                  BlocProvider(
                    create:
                        (context) => getIt<CreateAddressCubit>()..getAdresses(),
                  ),
                  BlocProvider(
                    create:
                        (context) => getIt<SystemDataCubit>()..getSystemData(),
                  ),
                ],
                child: SignUpScreen(),
              ),
        );
      // case Routes.verifyOTPScreen:
      //   final String phone = settings.arguments as String;
      //   return MaterialPageRoute(
      //     builder:
      //         (_) => BlocProvider(
      //           create: (context) => OtpCubit(),
      //           child: VerifyOtpScreen(phoneNumber: phone, verificationId: '',),
      //         ),
      //   );
      case Routes.forgotPasswordScreen:
        return MaterialPageRoute(builder: (_) => ForgotPasswordScreen());
      case Routes.changePasswordScreen:
        return MaterialPageRoute(builder: (_) => ChangePasswordScreen());
      case Routes.successChangePasswordScreen:
        return MaterialPageRoute(builder: (_) => SuccessChangePasswordScreen());
      case Routes.homeScreen:
        return MaterialPageRoute(
          builder:
              (_) => MultiBlocProvider(
                providers: [BlocProvider(create: (context) => CarouselCubit())],
                child: HomeScreen(),
              ),
        );
      case Routes.initial:
        return MaterialPageRoute(
          builder:
              (context) => MultiBlocProvider(
                providers: [
                  BlocProvider<CarouselCubit>(create: (_) => getIt()),
                  BlocProvider<CartCubit>(create: (_) => getIt()),
                  BlocProvider<CreateAddressCubit>(
                    create: (_) => getIt()..getAdresses(),
                  ),
                  BlocProvider<SlidersCubit>(
                    create: (_) => getIt()..getSliders(),
                  ),
                  BlocProvider.value(value: getIt<AllresturantsadminCubit>()),
                  BlocProvider<GetOrdersCubit>(
                    create: (_) => getIt()..getOrdersUser(),
                  ),
                  BlocProvider.value(
                    value: getIt<AddToCartCubit>()..getCart(),
                  ),
                  BlocProvider.value(
                    value: getIt<NotificationsCubit>()..getNotifications(),
                  ),
                ],
                child: BottomNavBarScreen(selectedIndex: 0),
              ),
        );
      case Routes.bottomBarScreen:
        final args = settings.arguments;
        int selectedIndex = 0;
        if (args is int) {
          selectedIndex = args;
        }
        return MaterialPageRoute(
          builder:
              (context) => MultiBlocProvider(
                providers: [
                  BlocProvider<CarouselCubit>(create: (_) => getIt()),
                  BlocProvider<CartCubit>(create: (_) => getIt()),
                  BlocProvider<CreateAddressCubit>(
                    create: (_) => getIt()..getAdresses(),
                  ),
                  BlocProvider<SlidersCubit>(
                    create: (_) => getIt()..getSliders(),
                  ),
                  BlocProvider.value(value: getIt<AllresturantsadminCubit>()),
                  BlocProvider<GetOrdersCubit>(
                    create: (_) => getIt()..getOrdersUser(),
                  ),
                  BlocProvider.value(
                    value: getIt<AddToCartCubit>()..getCart(),
                  ),
                  BlocProvider.value(
                    value: getIt<NotificationsCubit>()..getNotifications(),
                  ),
                ],
                child: BottomNavBarScreen(selectedIndex: selectedIndex),
              ),
        );
      case Routes.ratingFilterScreen:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider.value(
                value: getIt<AllresturantsadminCubit>(),
                child: RatingFilterScreen(),
              ),
        );
      case Routes.categoryFilterScreen:
        return MaterialPageRoute(builder: (_) => CategoryFilterScreen());
      case Routes.resturantScreen:
        return MaterialPageRoute(
          builder:
              (_) => MultiBlocProvider(
                providers: [
                  BlocProvider(create: (context) => ResturantMenuCubit()),
                  BlocProvider(create: (context) => getIt<ItemCubit>()),
                  BlocProvider.value(
                    value: getIt<AllresturantsadminCubit>(),
                  ),
                ],
                child: ResturantScreen(),
              ),
        );
      case Routes.bestPrice:
        final arguments = settings.arguments as List<dynamic>;
        final title = arguments[0];
        final sortType = arguments[1];
        final edit = arguments[2];
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => ResturantMenuCubit(),
                child: RestaurantFilterationScreen(
                  title: title,
                  sortType: sortType,
                  edit: edit,
                ),
              ),
        );
      case Routes.addItemScreen:
        return MaterialPageRoute(
          builder:
              (_) => MultiBlocProvider(
                providers: [
                  BlocProvider<ResturantMenuCubit>(
                    create: (context) => getIt(),
                  ),
                  BlocProvider<CarouselCubit>(create: (context) => getIt()),
                  BlocProvider.value(value: getIt<AddToCartCubit>()),
                ],
                child: AddItemScreen(),
              ),
        );
      case Routes.cartScreen:
        return MaterialPageRoute(
          builder:
              (_) => MultiBlocProvider(
                providers: [
                  BlocProvider(create: (context) => CartCubit()),
                  BlocProvider.value(
                    value: getIt<AddToCartCubit>()..getCart(),
                  ),
                ],
                child: CartScreen(),
              ),
        );
      case Routes.checkoutScreen:
        final int totalPrice = settings.arguments as int;
        return MaterialPageRoute(
          builder:
              (_) => MultiBlocProvider(
                providers: [
                  BlocProvider(create: (context) => getIt<CartCubit>()),
                  BlocProvider(create: (context) => getIt<CouponeCubit>()),
                  BlocProvider(
                    create: (context) => getIt<UserDataCubit>()..getUserData(),
                  ),
                  BlocProvider(
                    create:
                        (context) => getIt<CreateAddressCubit>()..getAdresses(),
                  ),
                  BlocProvider.value(
                    value: getIt<AddToCartCubit>()..getCart(),
                  ),
                ],
                child: CheckoutScreen(totalPrice: totalPrice),
              ),
        );
      case Routes.paymentScreen:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider.value(
                value: getIt<AddToCartCubit>(),
                child: PaymentMethodScreen(),
              ),
        );
      case Routes.creditScreen:
        return MaterialPageRoute(builder: (_) => CreditCardScreen());
      case Routes.successOrderScreen:
        return MaterialPageRoute(builder: (_) => SuccessScreen());
      case Routes.myOrdersScreen:
        return MaterialPageRoute(
          builder:
              (_) => MultiBlocProvider(
                providers: [
                  BlocProvider(create: (context) => getIt<CarouselCubit>()),
                  BlocProvider(
                    create:
                        (context) => getIt<GetOrdersCubit>()..getOrdersUser(),
                  ),
                ],
                child: MyOrdersScreen(),
              ),
        );
      case Routes.addressListScreen:
        return MaterialPageRoute(
          builder:
              (_) => MultiBlocProvider(
                providers: [
                  BlocProvider(create: (context) => getIt<AddressCubit>()),
                  BlocProvider(
                    create:
                        (context) => getIt<CreateAddressCubit>()..getAdresses(),
                  ),
                ],
                child: AddressListScreen(),
              ),
        );
      case Routes.accountInfoScreen:
        final canPop = settings.arguments as bool;
        return MaterialPageRoute(
          builder:
              (_) => MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => getIt<UserDataCubit>()..getUserData(),
                  ),
                  BlocProvider(
                    create:
                        (context) => getIt<SystemDataCubit>()..getSystemData(),
                  ),
                ],
                child: AccountInfoScreen(canPop: canPop),
              ),
        );
      case Routes.editAccountInfoScreen:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => getIt<UserDataCubit>()..getUserData(),
                child: EditAccountInfoScreen(),
              ),
        );
      case Routes.settingsScreen:
        return MaterialPageRoute(builder: (_) => SettingsScreen());
      case Routes.resturantBottomBar:
        final resId = settings.arguments;
        String resturantId = "";
        if (resId is String && resId.isNotEmpty) {
          resturantId = resId;
        }
        return MaterialPageRoute(
          builder:
              (_) => MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => ResturantBottomNavBarCubit(),
                  ),
                  BlocProvider(
                    create:
                        (create) =>
                            getIt<ResturantDataCubit>()..getResturantData(),
                  ),
                ],
                child: BottomNavBarScreenResturant(resturantId: resturantId),
              ),
        );
      case Routes.editItemScreen:
        final isAdd = settings.arguments as bool;
        return MaterialPageRoute(
          builder:
              (_) => MultiBlocProvider(
                providers: [
                  BlocProvider(create: (context) => MenuResturantCubit()),
                  BlocProvider(create: (context) => getIt<ItemCubit>()),
                  BlocProvider.value(
                    value: getIt<AllresturantsadminCubit>(),
                  ),
                ],
                child: EditYourItemScreen(isAdd: isAdd),
              ),
        );
      case Routes.newOrdersDetailsScreen:
        final args = settings.arguments as List;
        final recieved = args[0] as bool;
        final isDeliveryAgent = args[1] as bool;
        return MaterialPageRoute(
          builder:
              (_) => NewOrdersDetailsScreen(
                recieved: recieved,
                isDeliveryAgent: isDeliveryAgent,
              ),
        );
      case Routes.addReviewScreen:
        final resId = settings.arguments as String;
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => getIt<ReviewsCubit>(),
                child: AddReviewScreen(resId: resId),
              ),
        );
      case Routes.settingsResturantScreen:
        return MaterialPageRoute(builder: (_) => SettingsResturantScreen());
      case Routes.notificationResturantScreen:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider.value(
                value:
                    getIt<NotificationsCubit>()..getNotifications(),
                child: ResturantNotification(),
              ),
        );
      case Routes.resturantReviewScreen:
        final args = settings.arguments as List;
        final reviews = args[0] as List<Review>;
        final resId = args[1] as String;
        final isResturant = args[2] as bool;
        return MaterialPageRoute(
          builder:
              (_) => ResturantReviewsScreen(
                reviews: reviews,
                resId: resId,
                isResturant: isResturant,
              ),
        );
      case Routes.adminBottomBarScreen:
        final args = settings.arguments;
        int selected = 0;
        bool isFromNotificationUsers = false;
        bool isFromNotificationResturants = false;

        if (args is List && args.length >= 3) {
          selected = args[0] as int? ?? 0;
          isFromNotificationUsers = args[1] as bool? ?? false;
          isFromNotificationResturants = args[2] as bool? ?? false;
        }

        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => AdminBottomBarCubit(),
                child: AdminBottomBar(
                  selectedIndex: selected,
                  isFromNotificationUsers: isFromNotificationUsers,
                  isFromNotificationResturants: isFromNotificationResturants,
                ),
              ),
        );
      case Routes.homeAdminScreen:
        return MaterialPageRoute(builder: (_) => HomeAdmin());
      case Routes.topReatedListScreen:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider.value(
                value: getIt<AllresturantsadminCubit>(),
                child: TopRatedListScreen(),
              ),
        );
      // case Routes.searchRestuarnt:
      //   final resId = settings.arguments as String;
      //   return MaterialPageRoute(
      //     builder:
      //         (_) => BlocProvider(
      //           create: (context) => getIt<SlidersCubit>(),
      //           child: SearchRestaurantScreen(restaurantId: resId),
      //         ),
      //   );
      case Routes.adminCategoriesFilter:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider<AdminResturantFilterCubit>(
                create: (context) => getIt(),
                child: AdminCategoriesFilter(),
              ),
        );
      case Routes.adminTopRatedFilter:
        return MaterialPageRoute(
          builder:
              (_) => MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => getIt<AdminResturantFilterCubit>(),
                  ),
                  BlocProvider.value(
                    value:
                        getIt<AllresturantsadminCubit>()
                          ..getAllRatedResturantsForAdmin(0, 0),
                  ),
                ],
                child: AdminTopRatedFilter(),
              ),
        );
      case Routes.addResturantScreen:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider.value(
                value:
                    getIt<AllresturantsadminCubit>()
                      ..getAllSuperCategories(),
                child: AddRestaurantScreen(),
              ),
        );
      case Routes.numberOfOrdersUsersList:
        return MaterialPageRoute(builder: (_) => NumbersOfOrdersUserList());
      case Routes.adminCoupons:
        return MaterialPageRoute(
          builder:
              (_) => MultiBlocProvider(
                providers: [
                  BlocProvider(create: (context) => getIt<PickDateCubit>()),
                  BlocProvider(
                    create: (context) => getIt<CouponeCubit>()..getCoupons(),
                  ),
                ],
                child: AdminCouponsScreen(),
              ),
        );
      case Routes.addCouponeScreen:
        final coupon = settings.arguments as Coupon?;
        return MaterialPageRoute(
          builder:
              (_) => MultiBlocProvider(
                providers: [
                  BlocProvider(create: (context) => getIt<PickDateCubit>()),
                  BlocProvider(create: (context) => getIt<CouponeCubit>()),
                  BlocProvider.value(
                    value:
                        getIt<AllresturantsadminCubit>()
                          ..getAllResturantsForAdmin(),
                  ),
                ],
                child: AddCouponScreen(coupon: coupon),
              ),
        );
      case Routes.deliveryAgentScreen:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) {
                  final cubit = getIt<AgentsCubit>();
                  cubit.getAllAgents();
                  cubit.getAllOrders();
                  return cubit;
                },
                child: DeliveryAgentsScreen(),
              ),
        );
      case Routes.addDeliveryAgent:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => getIt<AgentsCubit>(),
                child: AddNewAgentScreen(),
              ),
        );
      case Routes.addSliderScreen:
        return MaterialPageRoute(
          builder:
              (_) => MultiBlocProvider(
                providers: [
                  BlocProvider.value(
                    value:
                        getIt<AllresturantsadminCubit>()
                          ..getAllResturantsForAdmin(),
                  ),
                  BlocProvider(
                    create: (context) => getIt<SlidersCubit>()..getSliders(),
                  ),
                  BlocProvider(create: (context) => getIt<CouponeCubit>()),
                ],
                child: AddNewSlider(),
              ),
        );
      case Routes.deliveryAgentHomeScreen:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => getIt<AgentOrdersCubit>(),
                child: DeliveryAgentHomeScreen(),
              ),
        );
      case Routes.deleteSliderScreen:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => getIt<SlidersCubit>()..getSliders(),
                child: DeleteSliderScreen(),
              ),
        );
      
      // Loyalty Points
      case Routes.loyaltyScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<LoyaltyCubit>(),
            child: const LoyaltyScreen(),
          ),
        );
      case Routes.adminRewardTiersScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<AdminLoyaltyCubit>(),
            child: const RewardTiersScreen(),
          ),
        );
      case Routes.pointsHistoryScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<LoyaltyCubit>(),
            child: const PointsHistoryScreen(),
          ),
        );
      case Routes.adminUsersPointsScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<AdminLoyaltyCubit>(),
            child: const UsersPointsScreen(),
          ),
        );
      case Routes.locationPickerScreen:
        return MaterialPageRoute(builder: (_) => const LocationPickerScreen());
      case Routes.addAddressScreen:
        return MaterialPageRoute(
          builder:
              (_) => MultiBlocProvider(
                providers: [
                  BlocProvider(create: (context) => getIt<CreateAddressCubit>()),
                  BlocProvider(create: (context) => getIt<AddressCubit>()),
                ],
                child: AddAddressScreen(),
              ),
        );
      default:
        return MaterialPageRoute(
          builder:
              (_) => Scaffold(
                body: Center(
                  child: Text('No route defined for ${settings.name}'),
                ),
              ),
        );
    }
  }
}
