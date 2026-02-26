import 'package:delveria/core/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// Utility class for getting the appropriate font family based on locale
class AppFonts {
  /// English font family (Bimini)
  static const String english = 'Bimini';
  
  /// Arabic font family (Lantx)
  static const String arabic = 'Lantx';
  
  /// Returns the appropriate font family based on the current locale
  static String getFontFamily(BuildContext context) {
    final locale = Localizations.localeOf(context);
    return locale.languageCode == 'ar' ? arabic : english;
  }
  
  /// Returns font family based on language code string
  static String getFontFamilyFromCode(String languageCode) {
    return languageCode == 'ar' ? arabic : english;
  }
}

class TextStyles {
  // ============ Static Styles (inherit font from Theme) ============
  // These styles do NOT specify fontFamily so they inherit from ThemeData
  // ThemeData sets: Lantx for Arabic, Bimini for English
  
  static TextStyle bimini31W700PrimaryDeafult = TextStyle(
    fontSize: 31.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryDeafult,
  );
  
  static TextStyle bimini32W400White = TextStyle(
    fontSize: 32.sp,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );
  
  static TextStyle bimini20W700 = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
  );
  
  static TextStyle bimini20W400 = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w400,
  );
  
  static TextStyle bimini14W700 = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w700,
  );
  
  static TextStyle bimini14W500 = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
  );
  
  static TextStyle bimini16W400Body = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
  );

  static TextStyle bimini14W400Body = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
  );
  
  static TextStyle bimini18W700 = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w700,
  );
  
  static TextStyle bimini16W700BoldWhite = TextStyle(
    fontSize: 16.sp,
    color: Colors.white,
    fontWeight: FontWeight.w700,
  );
  
  static TextStyle bimini16W700 = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
  );
  
  static TextStyle bimini14W400White = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: Color(0xffF6F6F6),
  );
  
  static TextStyle bimini13W400Grey = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.w400,
    color: Color(0xff868686),
  );
  
  static TextStyle bimini12W400Grey = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    color: Color(0xff979899),
  );
  
  static TextStyle bimini10W400Grey = TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeight.w400,
    color: Color(0xff979899),
  );
  
  static TextStyle bimini13W700Deafult = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryDeafult,
  );

  static TextStyle bimini16W500 = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
  );

  static TextStyle bimini12W500 = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
  );

  static TextStyle bimini10W700 = TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeight.w700,
  );

  static TextStyle bimini10W500 = TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeight.w500,
  );

  static TextStyle bimini14W600 = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
  );
  
  static TextStyle sen14W400 = GoogleFonts.sen(
    fontSize: 14.sp, 
    fontWeight: FontWeight.w400
  );
  
  static TextStyle bimini32W700 = TextStyle(
    fontSize: 32.sp,
    fontWeight: FontWeight.w700,
  );

  static TextStyle bimini12W700 = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w700,
  );
  
  static TextStyle sen22W700 = GoogleFonts.sen(
    fontSize: 22.sp, 
    fontWeight: FontWeight.w700
  );

  // ============ Localized Style Getters (explicit font) ============
  // Use these when Theme inheritance doesn't work (e.g. in overlays)

  static TextStyle localized31W700PrimaryDeafult(BuildContext context) => TextStyle(
    fontFamily: AppFonts.getFontFamily(context),
    fontSize: 31.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryDeafult,
  );

  static TextStyle localized20W700(BuildContext context) => TextStyle(
    fontFamily: AppFonts.getFontFamily(context),
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
  );

  static TextStyle localized18W700(BuildContext context) => TextStyle(
    fontFamily: AppFonts.getFontFamily(context),
    fontSize: 18.sp,
    fontWeight: FontWeight.w700,
  );

  static TextStyle localized16W700(BuildContext context) => TextStyle(
    fontFamily: AppFonts.getFontFamily(context),
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
  );

  static TextStyle localized14W700(BuildContext context) => TextStyle(
    fontFamily: AppFonts.getFontFamily(context),
    fontSize: 14.sp,
    fontWeight: FontWeight.w700,
  );

  static TextStyle localized14W400(BuildContext context) => TextStyle(
    fontFamily: AppFonts.getFontFamily(context),
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
  );

  static TextStyle localized13W400Grey(BuildContext context) => TextStyle(
    fontFamily: AppFonts.getFontFamily(context),
    fontSize: 13.sp,
    fontWeight: FontWeight.w400,
    color: Color(0xff868686),
  );
}
