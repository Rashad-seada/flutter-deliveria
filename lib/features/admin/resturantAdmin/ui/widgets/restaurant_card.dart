import 'package:cached_network_image/cached_network_image.dart';
import 'package:delveria/core/di/dependancy_injection.dart';
import 'package:delveria/core/func/show_snack_bar.dart';
import 'package:delveria/core/helper/images.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/network/api_constants.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/custom_loading.dart';
import 'package:delveria/core/widgets/delete_confirmation_dialog.dart';
import 'package:delveria/features/admin/resturantAdmin/logic/cubit/all_resturants_admin_cubit.dart';
import 'package:delveria/features/admin/resturantAdmin/logic/cubit/all_resturants_admin_state.dart';
import 'package:delveria/features/admin/resturantAdmin/ui/edit_restaurant_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:delveria/features/admin/resturantAdmin/ui/branch_list_screen.dart';
import '../../../../../core/helper/image_helper.dart';

class RestaurantCard extends StatefulWidget {
  const RestaurantCard({
    super.key,
    required this.index,
    this.isSearch = false,
    this.isNotification,
    this.onCheckTap, this.isSelected,
  });

  final int index;
  final bool? isNotification;
  final void Function()? onCheckTap;
  final bool isSearch;
  final List<bool>? isSelected;

  @override
  State<RestaurantCard> createState() => _RestaurantCardState();
}

class _RestaurantCardState extends State<RestaurantCard> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllresturantsadminCubit, AllresturantsadminState>(
      builder: (context, state) {
        final cubit = context.read<AllresturantsadminCubit>();

        final List restaurants =
            widget.isSearch ? cubit.searchResturants : cubit.allResturants;

        final bool validIndex =
            widget.index >= 0 && widget.index < restaurants.length;
        if (!validIndex) {
          return const SizedBox.shrink();
        }

        final restaurant = restaurants[widget.index];

        // For switch value, use the correct list for enable button as well
        bool switchValue;
        if (!widget.isSearch &&
            cubit.changeEnableButton != null &&
            widget.index < cubit.changeEnableButton!.length &&
            widget.index >= 0) {
          switchValue = cubit.changeEnableButton![widget.index];
        } else {
          switchValue = restaurant.isOpen;
        }

        // Fix: superCategory is a List, so we need to display its nameEn(s)
        String superCategoryName = "";
        if (restaurant.superCategory != null &&
            restaurant.superCategory is List &&
            (restaurant.superCategory as List).isNotEmpty) {
          // Try to get the first superCategory's nameEn, or join all if needed
          final firstSuperCategory = (restaurant.superCategory as List).first;
          if (firstSuperCategory != null && firstSuperCategory.nameEn != null) {
            superCategoryName = firstSuperCategory.nameEn;
          } else {
            // fallback: join all nameEn if available
            superCategoryName = (restaurant.superCategory as List)
                .map((cat) => cat?.nameEn ?? "")
                .where((name) => name.isNotEmpty)
                .join(", ");
          }
        }

        return Column(
          children: [
            // Restaurant Info Section
            Row(
              spacing: 15,
              children: [
                SizedBox(
                  width: 162.w,
                  height: 137.h,
                  child: CachedNetworkImage(
                    imageUrl:
                        ImageHelper.getRestaurantImageUrl(restaurant.photo),
                    width: 162,
                    height: 137.h,
                    fit: BoxFit.cover,
                    placeholder:
                        (context, url) => Center(child: CustomLoading())
                        ,
                   errorWidget: (context, url, error) {
                      print(error);
                      return Center(child: Icon(Icons.error, color: Colors.red));
                    },
                  ),
                ),

                // Restaurant Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            superCategoryName,
                            style: TextStyles.bimini16W400Body.copyWith(
                              color: AppColors.grey,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.star_border,
                                color: AppColors.primaryDeafult,
                                size: 20.sp,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                (restaurant.rate != null)
                                    ? restaurant.rate.toString().isNotEmpty
                                        ? restaurant.rate.toString().substring(
                                          0,
                                          1,
                                        )
                                        : "0"
                                    : "0",
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          widget.isNotification == true
                              ? GestureDetector(
                                onTap: widget.onCheckTap,
                                child: Container(
                                  width: 32.w,
                                  height: 32.h,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.primaryDeafult,
                                    ),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child:
                                      widget.isSelected?[widget.index??0] == true
                                          ? Icon(
                                            Icons.check,
                                            color: AppColors.primaryDeafult,
                                          )
                                          : SizedBox(),
                                ),
                              )
                              : SizedBox(),
                        ],
                      ),
                      verticalSpace(10),
                      Text(
                        restaurant.name ?? "",
                        style: TextStyles.bimini16W700,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        restaurant.aboutUs ?? "",
                        style: TextStyles.bimini13W400Grey,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Toggle Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppStrings.showingResData.tr(), style: TextStyles.bimini16W700),
                Switch(
                  value: switchValue,
                  onChanged: (value) async {
                    // Only allow toggling if not in search mode
                    if (!widget.isSearch &&
                        widget.index >= 0 &&
                        widget.index < cubit.allResturants.length) {
                      await cubit.changeEnable(
                        resID: cubit.allResturants[widget.index].id,
                        index: widget.index,
                      );
                      await cubit.getAllResturantsForAdmin();
                    }
                  },
                  activeColor: Colors.white,
                  activeTrackColor: const Color(0xFF4CAF50),
                  inactiveThumbColor: Colors.white,
                  inactiveTrackColor: const Color(0xFFE0E0E0),
                ),
              ],
            ),
            
            // Edit/Delete Section
            verticalSpace(8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Branches Button
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BranchListScreen(
                          restaurantId: restaurant.id!,
                          restaurantName: restaurant.name ?? '',
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  ),
                  icon: Icon(Icons.store_mall_directory, size: 16.sp),
                  label: Text("Branches", style: TextStyle(fontSize: 12.sp)),
                ),
                SizedBox(width: 8.w),

                // Edit Button
                ElevatedButton.icon(
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditRestaurantScreen(
                          restaurant: restaurant,
                        ),
                      ),
                    );
                    
                    if (result == true) {
                      // Call onUpdate if provided, or handle refresh
                      // currently handled by parent refresh
                      cubit.getAllResturantsForAdmin();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryDeafult,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  ),
                  icon: Icon(Icons.edit, size: 16.sp),
                  label: Text("Edit", style: TextStyle(fontSize: 12.sp)),
                ),
                SizedBox(width: 8.w),
                
                // Delete Button
                ElevatedButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => DeleteConfirmationDialog(
                        title: "Delete Restaurant",
                        message: "Are you sure you want to delete '${restaurant.name}'? This action cannot be undone.",
                        itemName: restaurant.name ?? "Unknown Restaurant",
                        onConfirm: () {
                          cubit.deleteResturant(resID: restaurant.id!);
                          Navigator.pop(context);
                        },
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  icon: Icon(Icons.delete, size: 16.sp),
                  label: Text("Delete", style: TextStyle(fontSize: 12.sp)),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
