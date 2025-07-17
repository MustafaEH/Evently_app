import 'package:evently/core/resources/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeManager {
  static final ThemeData light = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: ColorsManager.light,
      primary: ColorsManager.light,
      primaryContainer: ColorsManager.white,
    ),
    cardColor: ColorsManager.light,
    cardTheme: CardTheme(
      color: ColorsManager.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
    ),
    useMaterial3: false,
    scaffoldBackgroundColor: ColorsManager.light,
    primaryColor: ColorsManager.blue,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: ColorsManager.blue,
        textStyle: const TextStyle(fontWeight: FontWeight.w600),
      ),
    ),

    tabBarTheme: TabBarTheme(
      indicatorColor: Colors.transparent,
      tabAlignment: TabAlignment.start,
      labelStyle: TextStyle(color: ColorsManager.light),
      unselectedLabelStyle: TextStyle(color: ColorsManager.blue),
    ),
    textTheme: TextTheme(
      labelSmall: TextStyle(
        color: ColorsManager.grey,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
      ),
      labelMedium: TextStyle(
        color: ColorsManager.blue,
        fontSize: 20.sp,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: TextStyle(
        color: ColorsManager.blue,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        decoration: TextDecoration.underline,
        decorationColor: ColorsManager.blue,
      ),
      titleMedium: TextStyle(
        fontSize: 20.sp,
        color: ColorsManager.white,
        fontWeight: FontWeight.w600,
      ),
      headlineMedium: TextStyle(
        color: ColorsManager.black,
        fontSize: 22.sp,
        fontWeight: FontWeight.w400,
      ),
      headlineSmall: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.normal,
        color: ColorsManager.white,
      ),
      displaySmall: TextStyle(
        fontSize: 16.sp,
        color: ColorsManager.black,
        fontWeight: FontWeight.w500,
      ),
    ),
    iconTheme: IconThemeData(color: ColorsManager.black),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(
        color: ColorsManager.grey,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
      ),
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
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: ColorsManager.blue,
      selectionColor: ColorsManager.blue.withOpacity(0.3),
      selectionHandleColor: ColorsManager.blue,
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
      type: BottomNavigationBarType.fixed,
      // Keeps items aligned even if >3
      selectedLabelStyle: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: TextStyle(fontSize: 12.sp),
    ),

    timePickerTheme: TimePickerThemeData(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      hourMinuteColor: ColorsManager.blue.withOpacity(0.1),
      hourMinuteTextColor: ColorsManager.blue,
      dialBackgroundColor: Colors.grey.shade100,
      dialHandColor: ColorsManager.blue,
      entryModeIconColor: ColorsManager.blue,
      dayPeriodColor: Colors.grey.shade200,
      dayPeriodTextColor: ColorsManager.blue,
    ),
  );
  static final ThemeData dark = ThemeData(
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: ColorsManager.blue),
      backgroundColor: ColorsManager.dark,
    ),
    cardColor: ColorsManager.light,
    cardTheme: CardTheme(
      color: ColorsManager.dark,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
    ),
    useMaterial3: false,
    scaffoldBackgroundColor: ColorsManager.dark,
    primaryColor: ColorsManager.dark,
    colorScheme: ColorScheme.fromSeed(
      primaryContainer: ColorsManager.blue,
      seedColor: ColorsManager.blue,
      primary: ColorsManager.blue,
    ),
    tabBarTheme: TabBarTheme(
      indicatorColor: Colors.transparent,
      tabAlignment: TabAlignment.start,
      labelStyle: TextStyle(color: ColorsManager.light),
      unselectedLabelStyle: TextStyle(color: ColorsManager.blue),
    ),
    textTheme: TextTheme(
      labelSmall: TextStyle(
        color: ColorsManager.grey,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
      ),
      labelMedium: TextStyle(
        color: ColorsManager.blue,
        fontSize: 20.sp,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: TextStyle(
        color: ColorsManager.blue,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        decoration: TextDecoration.underline,
        decorationColor: ColorsManager.blue,
      ),
      titleMedium: TextStyle(
        fontSize: 20.sp,
        color: ColorsManager.white,
        fontWeight: FontWeight.w600,
      ),
      headlineMedium: TextStyle(
        color: ColorsManager.white,
        fontSize: 22.sp,
        fontWeight: FontWeight.w400,
      ),
      headlineSmall: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.normal,
        color: ColorsManager.white,
      ),
      displaySmall: TextStyle(
        fontSize: 16.sp,
        color: ColorsManager.white,
        fontWeight: FontWeight.w500,
      ),
    ),
    iconTheme: IconThemeData(color: ColorsManager.white),
    inputDecorationTheme: InputDecorationTheme(
      prefixIconColor: ColorsManager.grey,
      suffixIconColor: ColorsManager.grey,
      hintStyle: TextStyle(
        color: ColorsManager.grey,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: ColorsManager.blue, width: 1.w),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: ColorsManager.blue, width: 1.w),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: ColorsManager.red, width: 1.w),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: ColorsManager.blue, width: 1.w),
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
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: ColorsManager.blue,
      selectionColor: ColorsManager.blue.withOpacity(0.3),
      selectionHandleColor: ColorsManager.blue,
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
      backgroundColor: ColorsManager.dark,
      selectedItemColor: ColorsManager.white,
      unselectedItemColor: Colors.white38,
      type: BottomNavigationBarType.fixed,
      // Keeps items aligned even if >3
      selectedLabelStyle: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: TextStyle(fontSize: 12.sp),
    ),
  );
}
