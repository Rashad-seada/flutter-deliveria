import 'package:delveria/core/helper/extentions.dart';
import 'package:delveria/core/helper/images.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/admin/resturantAdmin/ui/widgets/filter_resturant_admin.dart';
import 'package:delveria/features/admin/users/ui/widgets/admin_user_filter.dart';
import 'package:delveria/features/client/filter/data/models/sort_by_price.dart';
import 'package:delveria/features/client/resturant/logic/cubit/resturant_menu_cubit.dart';
import 'package:delveria/features/client/resturant/ui/widgets/filter_resturant_dialog.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchRow extends StatelessWidget {
  const SearchRow({
    super.key,
    required this.showButton,
    this.themeState,
    this.showOffers,
    this.showIosArrow,
    this.isAdmin,
    this.isAdminUser,
    this.resId,
    this.sortedPriceItems,
    this.hint,
    this.onChanged,
    this.showSearchContainer = true,
    this.title, this.dontShowFilter
  });
  final bool showButton;
  final ThemeState? themeState;
  final bool? showOffers;
  final bool? showIosArrow;
  final bool? isAdmin;
  final bool? showSearchContainer;
  final bool? isAdminUser;
  final bool? dontShowFilter;
  final String? resId;
  final String? hint;
  final List<SortByPriceItem>? sortedPriceItems;
  final void Function(String)? onChanged;
  final String? title;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResturantMenuCubit(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          showButton
              ? GestureDetector(
                onTap: () {
                  context.pop();
                },
                child:
                    isAdmin == true
                        ? Icon(Icons.arrow_back_ios)
                        : Image.asset(AppImages.arrowBack, width: 32.w),
              )
              : showIosArrow == true
              ? GestureDetector(
                onTap: () {
                  isAdmin == true ? () {} : context.pop();
                },
                child: Padding(
                  padding: EdgeInsets.only(
                    left: showSearchContainer == false ? 10.w : 0.0,
                  ),
                  child: Icon(Icons.arrow_back_ios),
                ),
              )
              : SizedBox(),

          showSearchContainer == true
              ? Container(
                width: showButton ? 280.w : 300.w,
                height: 45.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.grey),
                ),
                child: TextField(
                  onChanged: onChanged,
                  decoration: InputDecoration(
                    hintText: hint ?? AppStrings.searchYourRestuarnt.tr(),
                    hintStyle: TextStyles.bimini16W400Body,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        AppImages.searchIcon,
                        width: 20.w,
                        height: 20.h,
                      ),
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                  ),
                ),
              )
              : Center(
                child: SizedBox(
                  child: Text(
                    title ?? "",
                    style: TextStyles.bimini20W700.copyWith(
                      color: AppColors.primaryDeafult,
                    ),
                  ),
                ),
              ),
          showIosArrow == true
              ? SizedBox()
              : isAdmin == true
              ? FilterResturantAdmin()
              : isAdminUser == true
              ? AdminUserFilter()
              :dontShowFilter==true?SizedBox(): FilterResturantDialog(
                resId: resId ?? "",
                sortedPriceItems: sortedPriceItems,
                themeState: themeState ?? ThemeState(),
                showOffers: showOffers,
              ),
        ],
      ),
    );
  }
}
