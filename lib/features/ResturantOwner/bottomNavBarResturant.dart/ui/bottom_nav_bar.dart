import 'package:delveria/core/di/dependancy_injection.dart';
import 'package:delveria/core/helper/constants.dart';
import 'package:delveria/core/helper/shared_pref_helper.dart';
import 'package:delveria/features/ResturantOwner/bottomNavBarResturant.dart/logic/cubit/resturant_bottom_nav_bar_cubit.dart';
import 'package:delveria/features/ResturantOwner/bottomNavBarResturant.dart/logic/cubit/resturant_bottom_nav_bar_state.dart';
import 'package:delveria/features/ResturantOwner/bottomNavBarResturant.dart/ui/widgets/resturant_bottom_nav_bar_bloc.dart';
import 'package:delveria/features/ResturantOwner/home/logic/cubit/resturant_data_cubit.dart';
import 'package:delveria/features/ResturantOwner/home/logic/cubit/resturant_data_state.dart';
import 'package:delveria/features/ResturantOwner/home/ui/resturant_owner_home.dart';
import 'package:delveria/features/ResturantOwner/menu/logic/cubit/item_cubit.dart';
import 'package:delveria/features/ResturantOwner/menu/logic/cubit/menu_resturant_cubit.dart';
import 'package:delveria/features/ResturantOwner/menu/ui/edit_your_item.dart';
import 'package:delveria/features/ResturantOwner/menu/ui/menu_screen.dart';
import 'package:delveria/features/ResturantOwner/ordersResturantScreen/logic/cubit/orders_resturant_cubit.dart';
import 'package:delveria/features/ResturantOwner/ordersResturantScreen/ui/orders_resturant_screen.dart';
import 'package:delveria/features/ResturantOwner/resturantProfile/logic/cubit/resturant_profile_data_cubit.dart';
import 'package:delveria/features/ResturantOwner/resturantProfile/resturant_profile.dart';
import 'package:delveria/features/admin/resturantAdmin/logic/cubit/all_resturants_admin_cubit.dart';
import 'package:delveria/features/client/adresses/logic/cubit/create_address_cubit.dart';
import 'package:delveria/features/client/filter/logic/cubit/filter_category_cubit.dart';
import 'package:delveria/features/client/home/logic/cubit/carousel_cubit.dart';
import 'package:delveria/features/client/home/ui/widgets/deliver_to_row.dart';
import 'package:delveria/features/client/profileDrawer/ui/profile_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavBarScreenResturant extends StatefulWidget {
  const BottomNavBarScreenResturant({super.key, required this.resturantId});
  final String resturantId;

  @override
  State<BottomNavBarScreenResturant> createState() =>
      _BottomNavBarScreenResturantState();
}

class _BottomNavBarScreenResturantState
    extends State<BottomNavBarScreenResturant> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String? _sharedPrefResturantId;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadResturantId();
  }

  Future<void> _loadResturantId() async {
    final resturantId = await SharedPrefHelper.getString(SharedPrefKeys.resId);
    setState(() {
      _sharedPrefResturantId = resturantId ?? widget.resturantId;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading || _sharedPrefResturantId == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final List<Widget> pages = [
      MultiBlocProvider(
        providers: [BlocProvider(create: (context) => getIt<ItemCubit>())],
        child: MultiBlocProvider(
          providers: [
         
            BlocProvider(
              create:
                  (context) =>
                      getIt<ResturantProfileDataCubit>()
                        ..getResturantProfileData(),
            ),
         
            BlocProvider(
              create:
                  (context) =>
                      getIt<ResturantDataCubit>()..getResturantDataForHome(),
            ),
          ],
          child: RestaurantDashboard(resId: _sharedPrefResturantId!),
        ),
      ),
      MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => CarouselCubit()),
          BlocProvider(
            create:
                (context) => getIt<OrdersResturantCubit>()..getOrdersRestaurant(),
          ),
        ],
        child: OrdersResturantScreen(),
      ),
      MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => MenuResturantCubit()),
          BlocProvider(create: (context) => getIt<AllresturantsadminCubit>()),
          BlocProvider(create: (context) => getIt<ItemCubit>()..getItemCategories()),
        ],
        child: EditYourItemScreen(isAdd: true, sizes: [], toppings: []),
      ),
      MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => MenuResturantCubit()),
          BlocProvider(
            create:
                (context) =>
                    getIt<ItemCubit>()
                      ..getAllItems(resId: _sharedPrefResturantId!),
          ),
          BlocProvider(
            create:
                (context) =>
                    getIt<FilterCategoryCubit>()
                      ..sortByPrice(resId: _sharedPrefResturantId!),
          ),
        ],
        child: MenuScreen(resId: _sharedPrefResturantId!),
      ),
      MultiBlocProvider(
        
        providers: [
          BlocProvider(
            create:
                (context) =>
                    getIt<ResturantProfileDataCubit>()
                      ..getResturantProfileData(),
          ), 
          BlocProvider(
            create:
                (context) =>
                    getIt<AllresturantsadminCubit>()
                    ,
          ), 
          BlocProvider(
            create:
                (context) =>
                    getIt<AllresturantsadminCubit>()
                    ,
          ), 
        ],
        child: ResturantProfile(),
      ),
    ];

    return BlocBuilder<ResturantBottomNavBarCubit, ResturantBottomNavBarState>(
      builder: (context, state) {
        return PopScope(
          canPop: false,
          child: Scaffold(
            key: _scaffoldKey,
            drawer: const ProfileDrawer(isResturant: true),
            appBar:
                state.selectedIndex == 0
                    ? PreferredSize(
                      preferredSize: const Size.fromHeight(80),
                      child: MultiBlocProvider(
                        providers: [
                          BlocProvider(
                            create:
                                (context) =>
                                    getIt<CreateAddressCubit>()..getAdresses(),
                          ),
                          BlocProvider(
                            create:
                                (create) =>
                                    getIt<ResturantDataCubit>()
                                      ..getResturantData(),
                          ),
                        ],
                        child:
                            BlocBuilder<ResturantDataCubit, ResturantDataState>(
                              builder: (context, dataState) {
                                final cubit =
                                    context.read<ResturantDataCubit>();
                                return DelivertoRow(
                                  addressCity: cubit.cityName,
                                  title: Text(cubit.resName ?? ""),
                                );
                              },
                            ),
                      ),
                    )
                    : null,
            body: pages[state.selectedIndex],
            bottomNavigationBar: ResturantBottomNavBarBloc(state: state),
          ),
        );
      },
    );
  }
}
