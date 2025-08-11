import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

final ThemeData customTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF121212),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF8687E7),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
    ),
  ),

  // Outlined Button Style
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: Colors.white,
      side: const BorderSide(color: Color(0xFF8687E7)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
    ),
  ),

  // Text Theme
  textTheme: TextTheme(
    displayLarge: GoogleFonts.lato(
      fontSize: 32.sp,
      fontWeight: FontWeight.w700,
    ),
    displayMedium: GoogleFonts.lato(
      fontSize: 45,
      fontWeight: FontWeight.normal,
    ),
    displaySmall: GoogleFonts.lato(fontSize: 36, fontWeight: FontWeight.normal),
    headlineLarge: GoogleFonts.lato(
      fontSize: 32,
      fontWeight: FontWeight.normal,
    ),
    headlineMedium: GoogleFonts.lato(
      fontSize: 28,
      fontWeight: FontWeight.normal,
    ),
    headlineSmall: GoogleFonts.lato(
      fontSize: 24,
      fontWeight: FontWeight.normal,
    ),
    titleLarge: GoogleFonts.lato(fontSize: 22, fontWeight: FontWeight.w500),
    titleMedium: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w500),
    titleSmall: GoogleFonts.lato(fontSize: 14, fontWeight: FontWeight.w500),
    bodyLarge: GoogleFonts.lato(fontSize: 16.sp, fontWeight: FontWeight.w400),
    bodyMedium: GoogleFonts.lato(fontSize: 14, fontWeight: FontWeight.normal),
    bodySmall: GoogleFonts.lato(fontSize: 12.sp, fontWeight: FontWeight.w400),
    labelLarge: GoogleFonts.lato(fontSize: 14, fontWeight: FontWeight.w500),
    labelMedium: GoogleFonts.lato(fontSize: 12, fontWeight: FontWeight.w500),
    labelSmall: GoogleFonts.lato(fontSize: 11, fontWeight: FontWeight.w500),
  ),

  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF121212),
    foregroundColor: Colors.white, // Optional: sets icon/text color
    elevation: 0, // Optional: removes shadow
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFF1D1D1D),
    // TextField background color
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: const BorderSide(
        color: Color(0xFF979797), // Border color
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: const BorderSide(color: Color(0xFF979797)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: const BorderSide(color: Color(0xFF979797), width: 1.5),
    ),
    hintStyle: GoogleFonts.lato(
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
      color: Color(0xFF535353),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
  ),

  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: AppColors.primaryColor,
    foregroundColor: AppColors.white,
  ),

  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color(0xFF363636),
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.grey,
    showSelectedLabels: true,
    showUnselectedLabels: true,
  ),

  dialogTheme: const DialogThemeData(backgroundColor: AppColors.lightGrey),

  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: AppColors.lightGrey,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
    ),
    modalBackgroundColor: AppColors.lightGrey,
    elevation: 10,
    clipBehavior: Clip.antiAlias,
  ),

  datePickerTheme: DatePickerThemeData(
    backgroundColor: AppColors.lightGrey,
    headerBackgroundColor: AppColors.primaryColor,
    dayForegroundColor: WidgetStateProperty.all(Colors.white),
    dayOverlayColor: WidgetStateProperty.all(Colors.white),
    todayBackgroundColor: WidgetStateProperty.all(AppColors.primaryColor),
    headerForegroundColor: Colors.white,
  ),

  timePickerTheme: TimePickerThemeData(
    backgroundColor: AppColors.lightGrey,
    // Dialog background
    hourMinuteShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8.r)),
      side: const BorderSide(color: Color(0xFF979797), width: 1),
    ),
    dayPeriodShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8.r)),
      side: const BorderSide(color: Color(0xFF979797), width: 1),
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16.r)),
    ),
    // Hour/Minute selector colors
    hourMinuteColor: WidgetStateColor.resolveWith(
      (states) => states.contains(WidgetState.selected)
          ? AppColors.primaryColor
          : const Color(0xFF1D1D1D),
    ),
    hourMinuteTextColor: WidgetStateColor.resolveWith(
      (states) =>
          states.contains(WidgetState.selected) ? Colors.white : Colors.white,
    ),
    // AM/PM selector colors
    dayPeriodColor: WidgetStateColor.resolveWith(
      (states) => states.contains(WidgetState.selected)
          ? AppColors.primaryColor
          : const Color(0xFF1D1D1D),
    ),
    dayPeriodTextColor: WidgetStateColor.resolveWith(
      (states) =>
          states.contains(WidgetState.selected) ? Colors.white : Colors.white,
    ),
    // Entry mode icon color
    entryModeIconColor: AppColors.primaryColor,
    // Header colors
    helpTextStyle: GoogleFonts.lato(
      fontSize: 16.sp,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    hourMinuteTextStyle: GoogleFonts.lato(
      fontSize: 24.sp,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    dayPeriodTextStyle: GoogleFonts.lato(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    dialHandColor: AppColors.primaryColor,
    dialBackgroundColor: const Color(0xFF1D1D1D),
    dialTextColor: Colors.white,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF1D1D1D),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.r),
        borderSide: const BorderSide(color: Color(0xFF979797)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.r),
        borderSide: const BorderSide(color: Color(0xFF979797)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.r),
        borderSide: const BorderSide(color: AppColors.primaryColor, width: 2),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
    ),
  ),
);
