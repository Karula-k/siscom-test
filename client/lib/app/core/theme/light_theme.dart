import 'package:client/app/core/theme/my_colors.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  colorScheme: ColorScheme(
      surfaceTint: Colors.transparent,
      onSurfaceVariant: Colors.transparent,
      brightness: Brightness.light,
      primary: MyColors.primaryColor,
      onPrimary: MyColors.backgroundWhite,
      secondary: MyColors.secondaryColor,
      onSecondary: MyColors.primaryColor,
      error: MyColors.errorColor,
      onError: MyColors.backgroundWhite,
      surface: MyColors.backgroundWhite,
      onSurface: MyColors.secondaryColor),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
        backgroundColor: MyColors.primaryColor,
        foregroundColor: MyColors.backgroundWhite,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))),
  ),
  inputDecorationTheme: InputDecorationTheme(
      border: const OutlineInputBorder(),
      hintStyle: TextStyle(color: MyColors.secondaryColor.shade200),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: MyColors.secondaryColor.shade200),
      ),
      hoverColor: MyColors.secondaryColor,
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: MyColors.errorColor),
      ),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: MyColors.secondaryColor)),
      prefixIconColor: MyColors.secondaryColor.shade200,
      suffixIconColor: MyColors.secondaryColor.shade200),
  snackBarTheme: SnackBarThemeData(
      showCloseIcon: true,
      closeIconColor: MyColors.primaryColor,
      behavior: SnackBarBehavior.floating,
      backgroundColor: MyColors.primaryColor.shade100,
      contentTextStyle: TextStyle(color: MyColors.primaryColor),
      actionBackgroundColor: MyColors.primaryColor),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    unselectedItemColor: MyColors.secondaryColor.shade200,
    backgroundColor: MyColors.backgroundWhite,
    selectedItemColor: MyColors.secondaryColor,
  ),
);
