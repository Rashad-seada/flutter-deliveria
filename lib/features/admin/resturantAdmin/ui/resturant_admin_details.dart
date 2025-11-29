import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/search_row.dart';
import 'package:delveria/features/ResturantOwner/menu/logic/cubit/item_cubit.dart';
import 'package:delveria/features/ResturantOwner/menu/logic/cubit/item_state.dart';
import 'package:delveria/features/admin/resturantAdmin/data/models/all_resturant_admin_response.dart';
import 'package:delveria/features/client/resturant/logic/cubit/resturant_menu_cubit.dart';
import 'package:delveria/features/client/resturant/logic/cubit/resturant_menu_state.dart';
import 'package:delveria/features/client/resturant/ui/widgets/food_menu_text.dart';
import 'package:delveria/features/client/resturant/ui/widgets/horizental_body.dart';
import 'package:delveria/features/client/resturant/ui/widgets/rate_and_delivery_cost_row.dart';
import 'package:delveria/features/client/resturant/ui/widgets/resturant_review_and_name.dart';
import 'package:delveria/features/client/resturant/ui/widgets/resturant_stacked_image.dart';
import 'package:delveria/features/client/resturant/ui/widgets/vertical_menu_body.dart';
import 'package:delveria/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResturantAdminDetails extends StatelessWidget {
  const ResturantAdminDetails({super.key, required this.resturantAdmin});
  final ResturantAdmin resturantAdmin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocBuilder<ResturantMenuCubit, ResturantMenuState>(
            builder: (resContext, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpace(20),
                  SearchRow(showButton: false, showIosArrow: true),
                  verticalSpace(20),
                  ResturantStackedImage(logo: resturantAdmin.logo, img: resturantAdmin.photo),
                  ResturantReviewAndName(
                    resName: resturantAdmin.name,
                    reviews: resturantAdmin.reviews ?? [],
                    resId: resturantAdmin.id ?? "",
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                    child: Text(
                      textAlign: TextAlign.start,
                      resturantAdmin.aboutUs,
                      style: TextStyles.bimini16W400Body.copyWith(
                        color: AppColors.grey,
                      ),
                    ),
                  ),
                  verticalSpace(10),
                  RateAndDeliveryCostRow(
                    deliveryCost:resturantAdmin. deliveryCost.toString(),
                    estimatedTime:resturantAdmin. estimatedTime.toString(),
                    themeState: themeState,
                    rate: resturantAdmin.rate.toString(),
                  ),
                  verticalSpace(20),
                  // BestPicksTextRow(themeState: themeState),
                  // BestPicksBody(),
                  FoodMenuText(themeState: themeState),
                  // FoodTypeTaps(),
                  verticalSpace(30),
                  state.toggleToHorizental
                      ? BlocBuilder<ItemCubit, ItemState>(
                        builder: (context, state) {
                          return HorizentalBodyForUser(
                            resId: resturantAdmin.id,
                            isAdmin: true,
                          );
                        },
                      )
                      : BlocBuilder<ItemCubit, ItemState>(
                        builder: (context, state) {
                          return VerticalMenuBody(
                            resId: resturantAdmin.id,
                            isAdmin: true,
                          );
                        },
                      ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
