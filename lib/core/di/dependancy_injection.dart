import 'package:delveria/core/network/api_services.dart';
import 'package:delveria/core/network/dio_factory.dart';
import 'package:delveria/features/ResturantOwner/bottomNavBarResturant.dart/logic/cubit/resturant_bottom_nav_bar_cubit.dart';
import 'package:delveria/features/ResturantOwner/home/data/repo/resturant_data_repo.dart';
import 'package:delveria/features/ResturantOwner/home/logic/cubit/resturant_data_cubit.dart';
import 'package:delveria/features/ResturantOwner/menu/data/repo/items_repo.dart';
import 'package:delveria/features/ResturantOwner/menu/logic/cubit/item_cubit.dart';
import 'package:delveria/features/ResturantOwner/menu/logic/cubit/menu_resturant_cubit.dart';
import 'package:delveria/features/ResturantOwner/ordersResturantScreen/data/repo/get_orders_repo.dart';
import 'package:delveria/features/ResturantOwner/ordersResturantScreen/logic/cubit/orders_resturant_cubit.dart';
import 'package:delveria/features/ResturantOwner/resturantNotification/data/repo/notification_repo.dart';
import 'package:delveria/features/ResturantOwner/resturantNotification/logic/cubit/notifications_cubit.dart';
import 'package:delveria/features/ResturantOwner/resturantProfile/data/repo/resturant_profile_repo.dart';
import 'package:delveria/features/ResturantOwner/resturantProfile/logic/cubit/resturant_profile_data_cubit.dart';
import 'package:delveria/features/admin/adminBottomBar/logic/cubit/admin_bottom_bar_cubit.dart';
import 'package:delveria/features/admin/coupons/data/repo/coupone_repo.dart';
import 'package:delveria/features/admin/coupons/logic/cubit/coupone_cubit.dart';
import 'package:delveria/features/admin/coupons/logic/cubit/pick_date_cubit.dart';
import 'package:delveria/features/admin/deliveryAgent/data/repo/delivery_agent_admin_repo.dart';
import 'package:delveria/features/admin/deliveryAgent/logic/cubit/agents_cubit.dart';
import 'package:delveria/features/admin/home/data/repo/get_home_data_repo.dart';
import 'package:delveria/features/admin/home/logic/cubit/get_home_data_admin_cubit.dart';
import 'package:delveria/features/admin/resturantAdmin/data/repo/resturant_admin_repo.dart';
import 'package:delveria/features/admin/resturantAdmin/logic/cubit/admin_resturant_filter_cubit.dart';
import 'package:delveria/features/admin/resturantAdmin/logic/cubit/all_resturants_admin_cubit.dart';
import 'package:delveria/features/admin/users/data/repo/get_users_repo.dart';
import 'package:delveria/features/admin/users/logic/cubit/admin_user_filter_cubit.dart';
import 'package:delveria/features/admin/users/logic/cubit/get_all_users_admin_cubit.dart';
import 'package:delveria/features/client/accountInfo/data/repo/get_data_repo.dart';
import 'package:delveria/features/client/accountInfo/logic/cubit/user_data_cubit.dart';
import 'package:delveria/features/client/adresses/data/repo/address_repo.dart';
import 'package:delveria/features/client/adresses/logic/cubit/address_cubit.dart';
import 'package:delveria/features/client/adresses/logic/cubit/create_address_cubit.dart';
import 'package:delveria/features/client/auth/login/data/repo/login_repo.dart';
import 'package:delveria/features/client/auth/login/logic/cubit/login_cubit.dart';
import 'package:delveria/features/client/auth/otp/logic/cubit/otp_cubit.dart';
import 'package:delveria/features/client/auth/signUp/data/repo/sign_up_repo.dart';
import 'package:delveria/features/client/auth/signUp/logic/cubit/signup_cubit.dart';
import 'package:delveria/features/client/cart/data/repo/cart_repo.dart';
import 'package:delveria/features/client/cart/logic/cubit/add_to_cart_cubit.dart';
import 'package:delveria/features/client/cart/logic/cubit/cart_cubit.dart';
import 'package:delveria/features/client/fav/data/repo/favorite_repo.dart';
import 'package:delveria/features/client/fav/logic/cubit/favorite_cubit.dart';
import 'package:delveria/features/client/filter/data/repo/filter_category_repo.dart';
import 'package:delveria/features/client/filter/logic/cubit/filter_category_cubit.dart';
import 'package:delveria/features/client/home/data/repo/sliders_repo.dart';
import 'package:delveria/features/client/home/logic/cubit/carousel_cubit.dart';
import 'package:delveria/features/client/home/logic/cubit/sliders_cubit.dart';
import 'package:delveria/features/client/onboarding/data/repo/get_system_data_repo.dart';
import 'package:delveria/features/client/onboarding/logic/cubit/system_data_cubit.dart';
import 'package:delveria/features/client/onboarding/logic/onborading_cubit.dart';
import 'package:delveria/features/client/orders/data/repo/orders_repo.dart';
import 'package:delveria/features/client/orders/logic/cubit/get_orders_cubit.dart';
import 'package:delveria/features/client/resturant/logic/cubit/resturant_menu_cubit.dart';
import 'package:delveria/features/client/reviews/data/repo/review_repo.dart';
import 'package:delveria/features/client/reviews/logic/cubit/reviews_cubit.dart';
import 'package:delveria/features/client/settings/logic/theme_cubit.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:delveria/features/deliveryAgent/data/repo/agent_ordrs_repo.dart';
import 'package:delveria/features/deliveryAgent/logic/cubit/agent_orders_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setUpGetIt() async {
  Dio dio = DioFactory.getDio();
  getIt.registerLazySingleton<ApiServices>(() => ApiServices(dio));
  getIt.registerLazySingleton<SignUpRepo>(
    () => SignUpRepo(apiServices: getIt()),
  );
  getIt.registerLazySingleton<ResturantAdminRepo>(
    () => ResturantAdminRepo(apiServices: getIt()),
  );
  getIt.registerFactory<AllresturantsadminCubit>(
    () => AllresturantsadminCubit(getIt()),
  );
  getIt.registerLazySingleton<CouponeRepo>(
    () => CouponeRepo(apiServices: getIt()),
  );
  getIt.registerLazySingleton<ItemsRepo>(
    () => ItemsRepo(apiServices: getIt()),
  );
  getIt.registerLazySingleton<DeliveryAgentAdminRepo>(
    () => DeliveryAgentAdminRepo(apiServices: getIt()),
  );
  getIt.registerLazySingleton<AddressRepo>(
    () => AddressRepo(apiServices: getIt()),
  );
  getIt.registerLazySingleton<SlidersRepo>(
    () => SlidersRepo(apiServices: getIt()),
  );
  getIt.registerLazySingleton<GetDataRepo>(
    () => GetDataRepo(apiServices: getIt()),
  );
  getIt.registerLazySingleton<ResturantDataRepo>(
    () => ResturantDataRepo(apiServices: getIt()),
  );
  getIt.registerLazySingleton<CartRepo>(
    () => CartRepo(apiServices: getIt()),
  );
  getIt.registerLazySingleton<OrdersRepo>(
    () => OrdersRepo(apiServices: getIt()),
  );
  getIt.registerLazySingleton<FilterCategoryRepo>(
    () => FilterCategoryRepo(apiServices: getIt()),
  );
  getIt.registerLazySingleton<FavoriteRepo>(
    () => FavoriteRepo(apiServices: getIt()),
  );
  getIt.registerLazySingleton<GetOrdersRepo>(
    () => GetOrdersRepo(apiServices: getIt()),
  );
  getIt.registerLazySingleton<ResturantProfileRepo>(
    () => ResturantProfileRepo(apiServices: getIt()),
  );
  getIt.registerLazySingleton<AgentOrdrsRepo>(
    () => AgentOrdrsRepo(apiServices: getIt()),
  );
  getIt.registerLazySingleton<ReviewRepo>(
    () => ReviewRepo(apiServices: getIt()),
  );
  getIt.registerLazySingleton<GetUsersRepo>(
    () => GetUsersRepo(apiServices: getIt()),
  );
  getIt.registerLazySingleton<GetHomeDataRepo>(
    () => GetHomeDataRepo(apiServices: getIt()),
  );
  getIt.registerLazySingleton<NotificationRepo>(
    () => NotificationRepo(apiServices: getIt()),
  );
  getIt.registerLazySingleton<GetSystemDataRepo>(
    () => GetSystemDataRepo(apiServices: getIt()),
  );
  getIt.registerFactory<AgentsCubit>(() => AgentsCubit(getIt()));
  getIt.registerFactory<ItemCubit>(() => ItemCubit(getIt()));
  getIt.registerFactory<CouponeCubit>(() => CouponeCubit(getIt()));
  getIt.registerLazySingleton<LoginRepo>(() => LoginRepo(apiServices: getIt()));
  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt()));
  getIt.registerFactory<SignupCubit>(() => SignupCubit(getIt()));
  getIt.registerFactory<ThemeState>(() => ThemeState());
  getIt.registerFactory<OnboradingCubit>(() => OnboradingCubit());
  getIt.registerFactory<CarouselCubit>(() => CarouselCubit());
  getIt.registerFactory<OtpCubit>(() => OtpCubit());
  getIt.registerFactory<ResturantMenuCubit>(() => ResturantMenuCubit());
  getIt.registerFactory<CartCubit>(() => CartCubit());
  getIt.registerFactory<AddressCubit>(() => AddressCubit());
  getIt.registerFactory<ThemeCubit>(() => ThemeCubit());
  getIt.registerFactory<ResturantBottomNavBarCubit>(
    () => ResturantBottomNavBarCubit(),
  );
  getIt.registerFactory<MenuResturantCubit>(() => MenuResturantCubit());
  getIt.registerFactory<AdminBottomBarCubit>(() => AdminBottomBarCubit());
  getIt.registerFactory<AdminResturantFilterCubit>(
    () => AdminResturantFilterCubit(),
  );
  getIt.registerFactory<AdminUserFilterCubit>(() => AdminUserFilterCubit());
  getIt.registerFactory<PickDateCubit>(() => PickDateCubit());
  getIt.registerFactory<CreateAddressCubit>(() => CreateAddressCubit(getIt()));
  getIt.registerFactory<SlidersCubit>(() => SlidersCubit(getIt()));
  getIt.registerFactory<UserDataCubit>(() => UserDataCubit(getIt()));
  getIt.registerFactory<ResturantDataCubit>(() => ResturantDataCubit(getIt()));
  getIt.registerFactory<AddToCartCubit>(() => AddToCartCubit(getIt()));
  getIt.registerFactory<GetOrdersCubit>(() => GetOrdersCubit(getIt()));
  getIt.registerFactory<FilterCategoryCubit>(() => FilterCategoryCubit(getIt()));
  getIt.registerFactory<FavoriteCubit>(() => FavoriteCubit(getIt()));
  getIt.registerFactory<OrdersResturantCubit>(() => OrdersResturantCubit(getIt()));
  getIt.registerFactory<ResturantProfileDataCubit>(() => ResturantProfileDataCubit(getIt()));
  getIt.registerFactory<AgentOrdersCubit>(() => AgentOrdersCubit(getIt()));
  getIt.registerFactory<ReviewsCubit>(() => ReviewsCubit(getIt()));
  getIt.registerFactory<GetAllUsersAdminCubit>(() => GetAllUsersAdminCubit(getIt()));
  getIt.registerFactory<GetHomeDataAdminCubit>(() => GetHomeDataAdminCubit(getIt()));
  getIt.registerFactory<NotificationsCubit>(() => NotificationsCubit(getIt()));
  getIt.registerFactory<SystemDataCubit>(() => SystemDataCubit(getIt()));

}
