import 'package:delveria/core/helper/images.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/client/home/ui/widgets/filter_dialog.dart';
import 'package:delveria/features/client/settings/logic/theme_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchBarSection extends StatefulWidget {
  const SearchBarSection({super.key, required this.themeState, required this.lat, required this.long, this.onChanged});
  final ThemeState themeState;
  final double lat, long;
final  void Function(String)? onChanged;

  @override
  State<SearchBarSection> createState() => _SearchBarSectionState();
}

class _SearchBarSectionState extends State<SearchBarSection> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.grey),
            ),
            child: TextField(
              onChanged: widget.onChanged,
              decoration: InputDecoration(
                hintText:  AppStrings.searchYourRestuarnt.tr(),
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
                  vertical: 15,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        FilterDialog(theme: widget.themeState , lat: widget.lat,long: widget.long,),
      ],
    );
  }
}
