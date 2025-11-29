import 'package:delveria/core/di/dependancy_injection.dart';
import 'package:delveria/core/helper/extentions.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/routing/routes.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/add_icon_container.dart';
import 'package:delveria/core/widgets/search_row.dart';
import 'package:delveria/features/ResturantOwner/menu/logic/cubit/item_cubit.dart';
import 'package:delveria/features/ResturantOwner/resturantNotification/logic/cubit/notifications_cubit.dart';
import 'package:delveria/features/admin/resturantAdmin/logic/cubit/all_resturants_admin_cubit.dart';
import 'package:delveria/features/admin/resturantAdmin/logic/cubit/all_resturants_admin_state.dart';
import 'package:delveria/features/admin/resturantAdmin/ui/resturant_admin_details.dart';
import 'package:delveria/features/admin/resturantAdmin/ui/widgets/circular_chart.dart';
import 'package:delveria/features/admin/resturantAdmin/ui/widgets/restaurant_card.dart';
import 'package:delveria/features/client/resturant/logic/cubit/resturant_menu_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';


class ResturantAdminScreen extends StatefulWidget {
  const ResturantAdminScreen({
    super.key,
    this.isFromNotification,
    this.message,
    this.selectedIds,
  });
  final bool? isFromNotification;
  final String? message;
  final List<String>? selectedIds; 

  @override
  State<ResturantAdminScreen> createState() => _ResturantAdminScreenState();
}

class _ResturantAdminScreenState extends State<ResturantAdminScreen> {
  String query = "";
  bool sendToAll = false;
  List<bool> isSelectedList = [];

  List<String> _getAllRestaurantIds(List allRes) {
    return allRes
        .map<String>((e) {
          if (e is Map && e.containsKey('id')) return e['id'].toString();
          if (e is Map && e.containsKey('_id')) return e['_id'].toString();
          if (e.id != null) return e.id.toString();
          if (e._id != null) return e._id.toString();
          return '';
        })
        .where((id) => id.isNotEmpty)
        .toList();
  }

  void _sendNotificationToRestaurants({
    required String message,
    required List<String> ids,
  }) {
    final notificationCubit = context.read<NotificationsCubit>();
    notificationCubit.createNotification(
      body: {"message": message, "ids": ids},
    );
    Navigator.pop(context); // Go back after sending
  }
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();

  Future<void> _handleRefresh() async {
    await context.read<AllresturantsadminCubit>().getAllResturantsForAdmin();

    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            BlocBuilder<AllresturantsadminCubit, AllresturantsadminState>(
              buildWhen:
                  (previous, current) =>
                      current is Loading || current is! Loading,
              builder: (context, state) {
                if (state is Loading ||
                    state.maybeWhen(loading: () => true, orElse: () => false)) {
                  return Center(
                    child: LoadingAnimationWidget.newtonCradle(
                      color: AppColors.primaryDeafult,
                      size: 150,
                    ),
                  );
                }
                final cubit = context.read<AllresturantsadminCubit>();

                final bool isSearching = query.trim().isNotEmpty;
                final List allRes =
                    isSearching ? cubit.searchResturants : cubit.allResturants;
                if (isSelectedList.length != allRes.length) {
                  isSelectedList = List.generate(allRes.length, (i) => false);
                }
                return Expanded(
                  child: RefreshIndicator(
                    key: _refreshKey,
                    onRefresh: _handleRefresh,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          verticalSpace(20),
                          SearchRow(
                            showButton: false,
                            isAdmin: true,
                            onChanged: (p0) async {
                              setState(() {
                                query = p0;
                              });
                              await cubit.searchResturant(query: p0);
                            },
                          ),
                          verticalSpace(10),
                          Row(
                            children: [
                              if (widget.isFromNotification != true)
                                GestureDetector(
                                  onTap: () {
                                    context.pushNamed(
                                      Routes.addResturantScreen,
                                    );
                                  },
                                  child: AddIconContainer(),
                                ),

                              SizedBox(width: 8),
                              Text(
                                AppStrings.resturantsList.tr(),
                                style: TextStyles.bimini20W700,
                              ),
                              Spacer(),
                              CircularChart(
                                totalNumbers: allRes.length,
                                progress: allRes.length.toDouble() / 100,
                              ),
                            ],
                          ),
                          widget.isFromNotification == true
                              ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppStrings.sendToAll.tr(),
                                    style: TextStyles.bimini16W700,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        sendToAll = !sendToAll;
                                      });
                                      final message = widget.message ?? "test";
                                      if (sendToAll) {
                                        // Send to all restaurants
                                        final ids = _getAllRestaurantIds(
                                          allRes,
                                        );
                                        if (ids.isNotEmpty) {
                                          _sendNotificationToRestaurants(
                                            message: message,
                                            ids: ids,
                                          );
                                        }
                                      } else if (widget.selectedIds != null &&
                                          widget.selectedIds!.isNotEmpty) {
                                        // Send to selected restaurant(s)
                                        _sendNotificationToRestaurants(
                                          message: message,
                                          ids: widget.selectedIds!,
                                        );
                                      } else {
                                        // Show warning
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              "Please select a restaurant or choose Send To All.",
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    child: Container(
                                      width: 32.w,
                                      height: 32.h,
                                      decoration: BoxDecoration(
                                        color:
                                            sendToAll
                                                ? AppColors.primaryDeafult
                                                    .withOpacity(0.2)
                                                : AppColors.lightGrey,
                                        border: Border.all(
                                          color: Colors.black.withOpacity(.3),
                                        ),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child:
                                          sendToAll
                                              ? Icon(
                                                Icons.check,
                                                color: AppColors.primaryDeafult,
                                                size: 20,
                                              )
                                              : null,
                                    ),
                                  ),
                                ],
                              )
                              : SizedBox(),

                          const SizedBox(height: 24),
                          if (allRes.isEmpty)
                            Center(
                              child: Text(
                                isSearching
                                    ? "No restaurants found for your search."
                                    : "No restaurants available.",
                                style: TextStyles.bimini16W700,
                              ),
                            )
                          else
                            ...allRes.asMap().entries.map(
                              (entry) => Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (_) => MultiBlocProvider(
                                              providers: [
                                                BlocProvider(
                                                  create:
                                                      (context) =>
                                                          getIt<
                                                            ResturantMenuCubit
                                                          >(),
                                                ),
                                                BlocProvider(
                                                  create:
                                                      (context) =>
                                                          getIt<ItemCubit>(),
                                                ),
                                              ],
                                              child: ResturantAdminDetails(
                                                resturantAdmin:
                                                    allRes[entry.key],
                                              ),
                                            ),
                                      ),
                                    );
                                  },
                                  child: RestaurantCard(
                                    isSelected: isSelectedList,
                                    isNotification: widget.isFromNotification,
                                    onCheckTap: () {
                                      setState(() {
                                        isSelectedList[entry.key] =
                                            !isSelectedList[entry.key];
                                      });
                                      final rest = allRes[entry.key];
                                      String? id;
                                      if (rest is Map && rest.containsKey('id'))
                                        id = rest['id'].toString();
                                      else if (rest is Map &&
                                          rest.containsKey('_id'))
                                        id = rest['_id'].toString();
                                      else if (rest.id != null)
                                        id = rest.id.toString();
                                      else if (rest._id != null)
                                        id = rest._id.toString();
                                      if (id != null && id.isNotEmpty) {
                                        final message =
                                            widget.message ?? "test";
                                        _sendNotificationToRestaurants(
                                          message: message,
                                          ids: [id],
                                        );
                                      }
                                    },

                                    index: entry.key,
                                    isSearch: query != "",
                                  ),
                                ),
                              ),
                            ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
