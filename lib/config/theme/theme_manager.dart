import 'package:evently/core/resources/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeManager {
  static final ThemeData light = ThemeData(
    useMaterial3: false,
    scaffoldBackgroundColor: ColorsManager.light,
    textTheme: TextTheme(
      labelSmall: GoogleFonts.inter(
        color: ColorsManager.grey,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
      ),
      labelMedium: GoogleFonts.inter(
        color: ColorsManager.blue,
        fontSize: 20.sp,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: GoogleFonts.inter(
        color: ColorsManager.blue,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        decoration: TextDecoration.underline,
        decorationColor: ColorsManager.blue,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 20.sp,
        color: ColorsManager.white,
        fontWeight: FontWeight.w600,
      ),
      headlineMedium: GoogleFonts.inter(
        color: ColorsManager.black,
        fontSize: 22.sp,
        fontWeight: FontWeight.w400,
      ),
    ),
    iconTheme: IconThemeData(color: ColorsManager.grey),
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: ColorsManager.grey, width: 1.w),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: ColorsManager.grey, width: 1.w),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: ColorsManager.red, width: 1.w),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: ColorsManager.red, width: 1.w),
      ),
      labelStyle: GoogleFonts.inter(
        color: ColorsManager.grey,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: ColorsManager.grey, width: 1.w),
      ),

    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        padding: REdgeInsets.symmetric(vertical: 16),
        backgroundColor: ColorsManager.blue,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: ColorsManager.blue,
      selectedItemColor: ColorsManager.white,
      unselectedItemColor: Colors.white38,
      type: BottomNavigationBarType.fixed, // Keeps items aligned even if >3
      selectedLabelStyle: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
      unselectedLabelStyle: TextStyle(fontSize: 12.sp),
    ),

  );
  static final ThemeData dark = ThemeData();
}
