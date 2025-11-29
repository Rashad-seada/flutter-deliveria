import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/widgets/search_row.dart';
import 'package:delveria/features/ResturantOwner/menu/data/models/get_all_item_response.dart';
import 'package:delveria/features/ResturantOwner/menu/logic/cubit/item_cubit.dart';
import 'package:delveria/features/ResturantOwner/menu/logic/cubit/item_state.dart';
import 'package:delveria/features/client/resturant/ui/widgets/build_burger_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterByOffers extends StatelessWidget {
  const FilterByOffers({super.key, required this.resId});
  final String resId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(20),
              SearchRow(showButton: false, resId: resId, showIosArrow: true),
              verticalSpace(20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                child: BlocBuilder<ItemCubit, ItemState>(
                  builder: (context, state) {
                    final cubit = context.read<ItemCubit>();

                    List<ItemModel> itemsOffers =
                        (state is GetItemSuccess && cubit.allItems != null)
                            ? cubit.allItems!
                                .where(
                                  (item) =>
                                      item.sizes != null &&
                                      item.sizes!.any(
                                        (e) =>
                                            e.offer != null &&
                                            e.offer != 0,
                                      ),
                                )
                                .toList()
                            : [];

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        verticalSpace(20),
                        itemsOffers.isNotEmpty
                            ? SizedBox(
                                height: itemsOffers.length * 200.h,
                                child: GridView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 25.w,
                                    mainAxisSpacing: 15.h,
                                    childAspectRatio: 0.7,
                                  ),
                                  itemCount: itemsOffers.length,
                                  itemBuilder: (context, index) {
                                    final item = itemsOffers[index];
                                    return buildBurgerCard(
                                      "",
                                      context,
                                      itemsModel: item,
                                      // Add other required parameters if needed
                                      // e.g. edit: true,
                                    );
                                  },
                                ),
                              )
                            : Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 40.h),
                                  child: Text(
                                 AppStrings.noItemsFound.tr(),
                                    style: TextStyle(fontSize: 18.sp),
                                  ),
                                ),
                              ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
