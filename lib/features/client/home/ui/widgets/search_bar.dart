import 'dart:async';
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
  final TextEditingController _controller = TextEditingController();
  bool _isFocused = false;

  // Typewriter Animation logic
  final List<String> _hints = [
    "Burgers", "Sushi", "Pizza", "Desserts", "Pasta", "Shawarma"
  ];
  int _currentHintIndex = 0;
  String _displayedHint = "";
  Timer? _typewriterTimer;
  int _charIndex = 0;
  bool _isDeleting = false;

  @override
  void initState() {
    super.initState();
    _startTypewriter();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
    _controller.addListener(() {
      setState(() {}); // Rebuild to hide/show hint
    });
  }

  void _startTypewriter() {
    _typewriterTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (!mounted) return;
      
      final currentWord = _hints[_currentHintIndex];
      
      setState(() {
        if (_isDeleting) {
          if (_charIndex > 0) {
            _charIndex--;
            _displayedHint = currentWord.substring(0, _charIndex);
          } else {
            _isDeleting = false;
            _currentHintIndex = (_currentHintIndex + 1) % _hints.length;
          }
        } else {
          if (_charIndex < currentWord.length) {
            _charIndex++;
            _displayedHint = currentWord.substring(0, _charIndex);
          } else {
            // Wait before deleting
            _typewriterTimer?.cancel();
            Future.delayed(const Duration(seconds: 2), () {
              if (mounted) {
                _isDeleting = true;
                _startTypewriter();
              }
            });
          }
        }
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    _typewriterTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.themeState.themeMode == ThemeMode.dark;
    final hintColor = AppColors.grey.withOpacity(0.7);

    return Row(
      children: [
        Expanded(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOutCubic,
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.darkCharcoal.withOpacity(0.8) // Using new constant if available, else fallback
                  : Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: _isFocused
                    ? AppColors.primaryDeafult.withOpacity(0.5)
                    : Colors.white.withOpacity(0.1),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: _isFocused
                      ? AppColors.primaryDeafult.withOpacity(0.15)
                      : Colors.black.withOpacity(0.05),
                  spreadRadius: _isFocused ? 2 : 0,
                  blurRadius: _isFocused ? 16 : 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    // Hint Text Layer
                    if (_controller.text.isEmpty)
                      Positioned(
                        left: 52.w, // Align with text field content
                        child: Text(
                          "${AppStrings.searchYourRestuarnt.tr()} '$_displayedHint'",
                          style: TextStyles.bimini16W400Body.copyWith(
                            color: hintColor,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                      
                    // Actual TextField
                    TextField(
                      controller: _controller,
                      focusNode: _focusNode,
                      onChanged: widget.onChanged,
                      style: TextStyles.bimini16W400Body.copyWith(
                        fontSize: 15.sp,
                      ),
                      decoration: InputDecoration(
                        hintText: "", // Managed by custom text above
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
                  ],
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
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14.r),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            color: isDark
                ? AppColors.darkGrey.withOpacity(0.6)
                : Colors.white.withOpacity(0.8),
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
