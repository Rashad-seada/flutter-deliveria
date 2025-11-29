import 'package:delveria/core/theme/color.dart';
import 'package:delveria/features/admin/resturantAdmin/logic/cubit/all_resturants_admin_cubit.dart';
import 'package:delveria/features/admin/resturantAdmin/logic/cubit/all_resturants_admin_state.dart';
import 'package:delveria/features/client/filter/ui/widgets/resturant_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopRatedResturantBody extends StatelessWidget {
  const TopRatedResturantBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllresturantsadminCubit, AllresturantsadminState>(
      buildWhen:
          (previous, current) =>
              current is RatedLoading || current is! RatedLoading,
      builder: (context, state) {
        if (state is RatedLoading ||
            state.maybeWhen(reatedLoading: () => true, orElse: () => false)) {
          return Center(
            child: CircularProgressIndicator(color: AppColors.primaryDeafult),
          );
        }
        final cubit = context.read<AllresturantsadminCubit>();
        return SizedBox(
          width: 500.w,
          height: 500.h,
          child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 5,
              childAspectRatio: 0.65,
            ),
            itemCount:
                cubit.allRatedResturants.length > 4
                    ? 4
                    : cubit.allRatedResturants.length,
            itemBuilder: (context, index) {
              return RestaurantCard(
                isTopten: false,
                isUser: false,
                isAdmin: true,
                restaurant: cubit.allRatedResturants[index],
              );
            },
          ),
        );
      },
    );
  }
}
