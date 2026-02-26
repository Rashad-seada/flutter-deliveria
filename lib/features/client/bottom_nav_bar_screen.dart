import 'package:delveria/core/di/dependancy_injection.dart';
import 'package:delveria/core/func/continue_as_a_guest.dart';
import 'package:delveria/core/helper/extentions.dart';
import 'package:delveria/core/helper/shared_pref_helper.dart';
import 'package:delveria/core/helper/constants.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/routing/routes.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/app_button.dart';
import 'package:delveria/core/widgets/custom_loading.dart';
import 'package:delveria/features/ResturantOwner/resturantNotification/logic/cubit/notifications_cubit.dart';
import 'package:delveria/features/ResturantOwner/resturantNotification/ui/resturant_notification.dart';
import 'package:delveria/features/admin/resturantAdmin/logic/cubit/all_resturants_admin_cubit.dart';
import 'package:delveria/features/client/accountInfo/logic/cubit/user_data_cubit.dart';
import 'package:delveria/features/client/accountInfo/ui/account_info_screen.dart';
import 'package:delveria/features/client/adresses/logic/cubit/create_address_cubit.dart';
import 'package:delveria/features/client/adresses/logic/cubit/create_address_state.dart';
import 'package:delveria/features/client/auth/login/logic/cubit/login_cubit.dart';
import 'package:delveria/features/client/cart/logic/cubit/add_to_cart_cubit.dart';
import 'package:delveria/features/client/cart/ui/cart_screen.dart';
import 'package:delveria/features/client/home/logic/cubit/carousel_cubit.dart';
import 'package:delveria/features/client/home/logic/cubit/carousel_state.dart';
import 'package:delveria/features/client/home/logic/cubit/sliders_cubit.dart';
import 'package:delveria/features/client/home/ui/home_screen.dart';
import 'package:delveria/features/client/home/ui/widgets/bottom_nav_bar_block.dart';
import 'package:delveria/features/client/home/ui/widgets/deliver_to_row.dart';
import 'package:delveria/features/client/onboarding/logic/cubit/system_data_cubit.dart';
import 'package:delveria/features/client/profileDrawer/ui/profile_drawer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key, required this.selectedIndex});
  final int selectedIndex;

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    loadContinueAsGuest();
    _checkGuestSync();
    final cubit = context.read<CarouselCubit>();
    if (cubit.state.selectedIndex != widget.selectedIndex) {
      cubit.updateSelectedIndex(widget.selectedIndex);
    }
  }

  Future<void> _checkGuestSync() async {
     final isGuest = await SharedPrefHelper.getBool(SharedPrefKeys.isGuest);
     // Sync only if NOT guest (logged in user)
     if (isGuest != true && mounted) {
        context.read<AddToCartCubit>().syncGuestCart();
     }
  }

  Future<bool> _onWillPop() async {
    await SystemNavigator.pop();
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => getIt<LoginCubit>()),
          BlocProvider(
            create: (context) => getIt<CreateAddressCubit>()..getAdresses(),
          ),
          BlocProvider(
            create: (context) => getIt<SlidersCubit>()..getSliders(),
          ),
        ],
        child: BlocBuilder<CreateAddressCubit, CreateAddressState>(
          builder: (context, addressState) {
            if (addressState is GetAddressSuccess || addressState is Success) {
              final createAddressCubit = context.read<CreateAddressCubit>();
              final lat = createAddressCubit.lat;
              final long = createAddressCubit.long;

              final cubit = getIt<AllresturantsadminCubit>();
              cubit.getNearbyResturants(
                context: context,
                lat: lat,
                long: long,
              );
              cubit.getAllRatedResturantsForAdmin(lat, long);
              cubit.getAllSuperCategories();
              
              return BlocProvider.value(
                value: cubit,
                child: HomeScreen(lat: lat, long: long),
              );
            } else if (addressState is GetAddressFail) {
              return Column(
                spacing: 20,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Failed to load address',
                    style: TextStyles.bimini18W700.copyWith(
                      color: AppColors.primaryDeafult,
                    ),
                  ),
                  Center(
                    child: AppButton(
                      title: AppStrings.addAdress.tr(),
                      onPressed: () {
                        context.pushNamed(Routes.addressListScreen);
                      },
                    ),
                  ),
                ],
              );
            } else {
              return CustomLoading();
            }
          },
        ),
      ),
      CartScreen(),
      ResturantNotification(isRestaurant: false),
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => getIt<UserDataCubit>()..getUserData(),
          ),
          BlocProvider(
            create: (context) => getIt<SystemDataCubit>()..getSystemData(),
          ),
        ],
        child: AccountInfoScreen(canPop: false),
      ),
    ];

    return WillPopScope(
      onWillPop: _onWillPop,
      child: BlocBuilder<CarouselCubit, CarouselState>(
        builder: (context, state) {
          return Scaffold(
            key: _scaffoldKey,
            drawer: const ProfileDrawer(),
            appBar: null,
            body: pages[state.selectedIndex],
            bottomNavigationBar: BottomNavBarBloc(
              selectedIndex: state.selectedIndex,
            ),
          );
        },
      ),
    );
  }
}
