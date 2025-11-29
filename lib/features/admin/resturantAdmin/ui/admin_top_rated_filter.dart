import 'package:delveria/core/helper/images.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/core/widgets/search_row.dart';
import 'package:delveria/features/admin/resturantAdmin/logic/cubit/all_resturants_admin_cubit.dart';
import 'package:delveria/features/admin/resturantAdmin/logic/cubit/all_resturants_admin_state.dart';
import 'package:delveria/features/admin/resturantAdmin/ui/widgets/rated_resturant_card_admin.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AdminTopRatedFilter extends StatefulWidget {
  const AdminTopRatedFilter({super.key});

  @override
  State<AdminTopRatedFilter> createState() => _AdminTopRatedFilterState();
}

class _AdminTopRatedFilterState extends State<AdminTopRatedFilter> {
  @override
  void initState() {
    super.initState();
    // Fetch rated restaurants if not already loaded
    final cubit = context.read<AllresturantsadminCubit>();
    if (cubit.allRatedResturants.isEmpty) {
      cubit.getAllRatedResturantsForAdmin(0, 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<AllresturantsadminCubit, AllresturantsadminState>(
          builder: (context, state) {
            final cubit = context.watch<AllresturantsadminCubit>();

            // Show loading indicator while fetching rated restaurants
            final isLoading = state.maybeWhen(
              reatedLoading: () => true,
              orElse: () => false,
            );

            return Column(
              children: [
                verticalSpace(24),
                SearchRow(showButton: true, isAdmin: true),
                verticalSpace(35),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              AppImages.sqaureIcon,
                              width: 24.w,
                              height: 24.h,
                            ),
                            SizedBox(width: 8),
                            Text(
                              AppStrings.ratedResturants.tr(),
                              style: TextStyles.bimini20W700,
                            ),
                          ],
                        ),
                        verticalSpace(32),
                        verticalSpace(24),
                        if (isLoading)
                          Center(
                            child: LoadingAnimationWidget.newtonCradle(
                              color: Colors.deepOrange,
                              size: 100,
                            ),
                          )
                        else if (cubit.allRatedResturants.isEmpty)
                          Center(
                            child: Text(
                              "No rated restaurants found.",
                              style: TextStyles.bimini16W700,
                            ),
                          )
                        else
                          ...cubit.allRatedResturants.asMap().entries.map(
                            (entry) => Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: RatedRestaurantCard(
                                restaurant: entry.value,
                              ),
                            ),
                          ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

