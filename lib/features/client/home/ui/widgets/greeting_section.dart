import 'package:delveria/core/func/continue_as_a_guest.dart';
import 'package:delveria/core/func/permissions_function.dart';
import 'package:delveria/core/helper/constants.dart';
import 'package:delveria/core/helper/extentions.dart';
import 'package:delveria/core/helper/images.dart';
import 'package:delveria/core/helper/shared_pref_helper.dart';
import 'package:delveria/core/helper/spacing.dart';
import 'package:delveria/core/helper/strings.dart';
import 'package:delveria/core/routing/routes.dart';
import 'package:delveria/core/theme/color.dart';
import 'package:delveria/core/theme/styles.dart';
import 'package:delveria/features/client/accountInfo/logic/cubit/user_data_cubit.dart';
import 'package:delveria/features/client/accountInfo/logic/cubit/user_data_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GreetingSection extends StatefulWidget {
  const GreetingSection({super.key});

  @override
  State<GreetingSection> createState() => _GreetingSectionState();
}

class _GreetingSectionState extends State<GreetingSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  Future<void> initLocationPermission(BuildContext context) async {
    final phone = await SharedPrefHelper.getString(SharedPrefKeys.userPhone);
    getLocationPermission(context, phone);
  }

  String _getTimeBasedGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return AppStrings.goodMorning.tr();
    } else if (hour < 17) {
      return "Good Afternoon";
    } else {
      return "Good Evening";
    }
  }

  @override
  void initState() {
    super.initState();
    loadContinueAsGuest();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Row(
      children: [
        // Enhanced Avatar with animated glow
        AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryDeafult.withOpacity(0.3 * _scaleAnimation.value),
                    blurRadius: 12,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primaryDeafult,
                      AppColors.primaryDeafult.withOpacity(0.6),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: CircleAvatar(
                  radius: 24.r,
                  backgroundColor: isDark ? AppColors.darkGrey : Colors.white,
                  backgroundImage: ExactAssetImage(AppImages.person),
                ),
              ),
            );
          },
        ),
        horizontalSpace(14),
        // Enhanced greeting text
        BlocBuilder<UserDataCubit, UserDataState>(
          builder: (context, state) {
            final cubit = context.read<UserDataCubit>();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getTimeBasedGreeting(),
                  style: TextStyles.bimini12W400Grey.copyWith(
                    color: AppColors.grey,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  isContinueAsGuest
                      ? "Guest"
                      : "${cubit.firstName} ${cubit.lastName}",
                  style: TextStyles.bimini16W400Body.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 17.sp,
                  ),
                ),
              ],
            );
          },
        ),
        const Spacer(),
        // Enhanced icon buttons with containers
        _buildIconButton(
          icon: AppImages.locationAdd,
          onTap: () => context.pushNamed(Routes.addressListScreen),
          isDark: isDark,
        ),
        horizontalSpace(12),
        _buildIconButton(
          icon: AppImages.cartFull,
          onTap: () => context.pushReplacementNamed(Routes.bottomBarScreen, arguments: 1),
          isDark: isDark,
          showBadge: true,
        ),
      ],
    );
  }

  Widget _buildIconButton({
    required String icon,
    required VoidCallback onTap,
    required bool isDark,
    bool showBadge = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          color: isDark 
              ? AppColors.darkGrey.withOpacity(0.5) 
              : Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Image.asset(icon, width: 22.w, height: 22.h),
            if (showBadge)
              Positioned(
                right: -4,
                top: -4,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: AppColors.primaryDeafult,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1.5),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
