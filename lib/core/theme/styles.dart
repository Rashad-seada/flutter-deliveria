import 'package:delveria/core/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyles {
  static String fontFamily = 'Bimini';
  static TextStyle bimini31W700PrimaryDeafult = TextStyle(
    fontFamily: fontFamily,
    fontSize: 31.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryDeafult,
  );
  static TextStyle bimini32W400White = TextStyle(
    fontFamily: fontFamily,
    fontSize: 32.sp,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );
  static TextStyle bimini20W700 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
  );
  static TextStyle bimini20W400 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20.sp,
    fontWeight: FontWeight.w400,
  );
  static TextStyle bimini14W700 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14.sp,
    fontWeight: FontWeight.w700,
  );
  static TextStyle bimini14W500 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
  );
  static TextStyle bimini16W400Body = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
  );
  static TextStyle bimini18W700 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18.sp,
    fontWeight: FontWeight.w700,
  );
  static TextStyle bimini16W700BoldWhite = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16.sp,
    color: Colors.white,
    fontWeight: FontWeight.w700,
  );
  static TextStyle bimini16W700 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
  );
  static TextStyle bimini14W400White = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: Color(0xffF6F6F6),
  );
  static TextStyle bimini13W400Grey = TextStyle(
    fontFamily: fontFamily,
    fontSize: 13.sp,
    fontWeight: FontWeight.w400,
    color: Color(0xff868686),
  );
  static TextStyle bimini12W400Grey = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    color: Color(0xff979899),
  );
  static TextStyle bimini10W400Grey = TextStyle(
    fontFamily: fontFamily,
    fontSize: 10.sp,
    fontWeight: FontWeight.w400,
    color: Color(0xff979899),
  );
  static TextStyle bimini13W700Deafult = TextStyle(
    fontFamily: fontFamily,
    fontSize: 13.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryDeafult,
  );
  static TextStyle sen14W400 = GoogleFonts.sen(
    fontSize: 14.sp, 
    fontWeight: FontWeight.w400
  );
  static TextStyle sen22W700 = GoogleFonts.sen(
    fontSize: 22.sp, 
    fontWeight: FontWeight.w700
  );
}
