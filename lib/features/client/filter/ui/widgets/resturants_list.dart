import 'package:delveria/features/admin/resturantAdmin/logic/cubit/all_resturants_admin_cubit.dart';
import 'package:delveria/features/admin/resturantAdmin/logic/cubit/all_resturants_admin_state.dart';
import 'package:delveria/features/client/filter/ui/widgets/resturant_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResturantsList extends StatelessWidget {
  const ResturantsList({super.key, this.isAdmin, required this.isTopTen});
  final bool? isAdmin;
final bool isTopTen;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllresturantsadminCubit, AllresturantsadminState>(
      builder: (context, state) {
        final cubit = context.read<AllresturantsadminCubit>();
        return Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: isAdmin == true ? 15 : 10,
                mainAxisSpacing: isAdmin == true ? 7 : 5,
                childAspectRatio: 0.65,
              ),
              itemCount: cubit.allRatedResturants.length,
              itemBuilder: (context, index) {
                return RestaurantCard(
                  isUser: true,
                  resturantUser: cubit.allRatedResturants[index],
                  isAdmin: isAdmin,
                  restaurant: cubit.allRatedResturants[index],
                  isTopten: isTopTen,
                );
              },
            ),
          ),
        );
      },
    );
  }
}
