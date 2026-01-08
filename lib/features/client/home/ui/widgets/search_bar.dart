import 'dart:ui';
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
  const SearchBarSection({
    super.key,
    required this.themeState,
    required this.lat,
    required this.long,
    this.onChanged,
  });
  final ThemeState themeState;
  final double lat, long;
  final void Function(String)? onChanged;

  @override
  State<SearchBarSection> createState() => _SearchBarSectionState();
}

class _SearchBarSectionState extends State<SearchBarSection> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.themeState.themeMode == ThemeMode.dark;

    return Row(
      children: [
        Expanded(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOutCubic,
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.darkGrey.withOpacity(0.6)
                  : Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: _isFocused
                    ? AppColors.primaryDeafult.withOpacity(0.5)
                    : Colors.transparent,
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: _isFocused
                      ? AppColors.primaryDeafult.withOpacity(0.1)
                      : Colors.black.withOpacity(0.06),
                  spreadRadius: _isFocused ? 2 : 0,
                  blurRadius: _isFocused ? 16 : 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: TextField(
                  focusNode: _focusNode,
                  onChanged: widget.onChanged,
                  style: TextStyles.bimini16W400Body.copyWith(
                    fontSize: 15.sp,
                  ),
                  decoration: InputDecoration(
                    hintText: AppStrings.searchYourRestuarnt.tr(),
                    hintStyle: TextStyles.bimini16W400Body.copyWith(
                      color: AppColors.grey.withOpacity(0.7),
                      fontSize: 14.sp,
                    ),
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(14.r),
                      child: ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          colors: [
                            AppColors.primaryDeafult,
                            AppColors.primaryDeafult.withOpacity(0.7),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ).createShader(bounds),
                        child: Image.asset(
                          AppImages.searchIcon,
                          width: 20.w,
                          height: 20.h,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 16.h,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        horizontalSpace(10),
        // Enhanced filter button with glassmorphism
        _buildFilterButton(isDark),
      ],
    );
  }

  Widget _buildFilterButton(bool isDark) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14.r),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Container(
            color: isDark
                ? AppColors.darkGrey.withOpacity(0.6)
                : Colors.white.withOpacity(0.9),
            child: FilterDialog(
              theme: widget.themeState,
              lat: widget.lat,
              long: widget.long,
            ),
          ),
        ),
      ),
    );
  }
}

SizedBox horizontalSpace(double width) => SizedBox(width: width.w);
