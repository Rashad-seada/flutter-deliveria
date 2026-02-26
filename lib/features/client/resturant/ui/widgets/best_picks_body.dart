import 'package:cached_network_image/cached_network_image.dart';
import 'package:delveria/core/di/dependancy_injection.dart';
import 'package:delveria/core/network/api_constants.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/ResturantOwner/menu/data/models/get_all_item_response.dart';
import 'package:delveria/features/client/cart/logic/cubit/add_to_cart_cubit.dart';
import 'package:delveria/features/client/home/logic/cubit/carousel_cubit.dart';
import 'package:delveria/features/client/resturant/logic/cubit/resturant_menu_cubit.dart';
import 'package:delveria/features/client/resturant/ui/add_item_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BestPicksBody extends StatelessWidget {
  const BestPicksBody({
    super.key, 
    required this.items, 
    this.isOpen = true,
    this.restaurant,
  });
  final List<ItemModel> items;
  final bool? isOpen;
  final RestaurantModel? restaurant;

  void _navigateToItemDetails(BuildContext context, ItemModel item) {
    if (isOpen == false) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Restaurant is Closed"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MultiBlocProvider(
          providers: [
            BlocProvider<ResturantMenuCubit>(
              create: (context) => getIt(),
            ),
            BlocProvider<CarouselCubit>(
              create: (context) => getIt(),
            ),
            BlocProvider.value(value: getIt<AddToCartCubit>()),
          ],
          child: AddItemScreen(
            item: item,
            restaurantModel: restaurant,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return SizedBox.shrink();
    
    return SizedBox(
      height: 250.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          final price = item.sizes?.isNotEmpty == true ? item.sizes!.first.priceAfter : 0;
          
          return GestureDetector(
            onTap: () => _navigateToItemDetails(context, item),
            child: Container(
              width: 150.w,
              margin: EdgeInsets.only(right: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 100.h,
                    width: 150.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey[100],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: item.photo != null
                          ? CachedNetworkImage(
                              imageUrl: "${ApiConstants.baseUrl}/${item.photo}",
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Center(
                                child: CircularProgressIndicator(strokeWidth: 2),
                              ),
                              errorWidget: (context, url, error) => Icon(
                                Icons.error,
                                color: Colors.red,
                              ),
                            )
                          : null,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    item.name ?? "", 
                    style: TextStyles.bimini16W700,
                     maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    item.description ?? "",
                    style: TextStyles.bimini16W400Body.copyWith(
                      color: AppColors.grey,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  verticalSpace(5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("$price ${AppStrings.le.tr()}", style: TextStyles.bimini16W700),
                      GestureDetector(
                        onTap: () => _navigateToItemDetails(context, item),
                        child: Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: isOpen == false ? Colors.grey : AppColors.primaryDeafult,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 20.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
