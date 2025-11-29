import 'package:delveria/core/di/dependancy_injection.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/widgets/app_button.dart';
import 'package:delveria/features/admin/resturantAdmin/logic/cubit/all_resturants_admin_cubit.dart';
import 'package:delveria/features/client/filter/logic/cubit/filter_category_cubit.dart';
import 'package:delveria/features/client/filter/ui/category_filter_screen.dart';
import 'package:delveria/features/client/filter/ui/rating_filter_screen.dart';
import 'package:delveria/features/client/home/logic/cubit/carousel_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApplyChangesFilterButton extends StatelessWidget {
  const ApplyChangesFilterButton({
    super.key,
    required this.tempSelectedVal,
    required this.lat,
    required this.long,
  });

  final int tempSelectedVal;
  final double lat, long;

  @override
  Widget build(BuildContext context) {
    return AppButton(
      title: AppStrings.applyChanges.tr(),
      onPressed: () {
        context.read<CarouselCubit>().updateSelectedVal(tempSelectedVal);
        Navigator.of(context).pop();

        if (tempSelectedVal == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (_) => BlocProvider(
                    create:
                        (context) =>
                            getIt<AllresturantsadminCubit>()
                              ..getAllRatedResturantsForAdmin(lat, long),
                    child: RatingFilterScreen(showTitle: true, isTopTen: false,),
                  ),
            ),
          );
        } else if (tempSelectedVal == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (_) => MultiBlocProvider(
                   
                    providers: [
                      BlocProvider(
                        create:
                            (context) =>
                                getIt<AllresturantsadminCubit>()
                                  ..getAllSuperCategories(),
                      ),
                      BlocProvider(
                        create:
                            (context) =>
                                getIt<FilterCategoryCubit>()
                                 
                      ),
                    ],
                    child: CategoryFilterScreen(lat: lat, long: long, isAdmin: false,),
                  ),
            ),
          );
        } else {
          debugPrint(
            "Unknown filter selection: $tempSelectedVal. Please check your logic or ask for help on StackOverflow.",
          );
        }
      },
    );
  }
}
