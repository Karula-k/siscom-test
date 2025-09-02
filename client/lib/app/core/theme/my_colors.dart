import 'package:flutter/material.dart';

extension MyColors on Color {
  static MaterialColor primaryColor = const MaterialColor(
    0xFFF42619,
    {
      50: Color(0xFFFFEBEB),
      100: Color(0xFFFFC6C2),
      200: Color(0xFFFF9C95),
      300: Color(0xFFFF7066),
      400: Color(0xFFFF4F44),
      500: Color(0xFFF42619),
      600: Color(0xFFD91F15),
      700: Color(0xFFB71712),
      800: Color(0xFF94100E),
      900: Color(0xFF700909),
    },
  );

  static MaterialColor errorColor = const MaterialColor(
    0xFFFF5630,
    {
      50: Color(0xFFFFEDE9),
      100: Color(0xFFFFD1C8),
      200: Color(0xFFFFB29F),
      300: Color(0xFFFF8F73),
      400: Color(0xFFFF7553),
      500: Color(0xFFFF5630),
      600: Color(0xFFE64D2B),
      700: Color(0xFFCC4325),
      800: Color(0xFFB33920),
      900: Color(0xFF8C2A17),
    },
  );

  static MaterialColor successColor = const MaterialColor(
    0xFF52BD94,
    {
      50: Color(0xFFE8F8F2),
      100: Color(0xFFC6EFE0),
      200: Color(0xFFA1E5CC),
      300: Color(0xFF7BDAB7),
      400: Color(0xFF5ED1A6),
      500: Color(0xFF52BD94),
      600: Color(0xFF47A983),
      700: Color(0xFF3B9471),
      800: Color(0xFF307F60),
      900: Color(0xFF225F45),
    },
  );

  static MaterialColor secondaryColor = const MaterialColor(
    0xFF322E2E,
    {
      50: Color(0xFFE9E8E8),
      100: Color(0xFFC8C6C6),
      200: Color(0xFFA4A1A1),
      300: Color(0xFF807C7C),
      400: Color(0xFF655F5F),
      500: Color(0xFF322E2E),
      600: Color(0xFF2C2929),
      700: Color(0xFF252222),
      800: Color(0xFF1F1C1C),
      900: Color(0xFF151111),
    },
  );
  static Color backgroundWhite = const Color(0XFFFFFFFF);
}
