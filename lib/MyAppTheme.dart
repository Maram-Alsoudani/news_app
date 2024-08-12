import 'package:flutter/material.dart';

import 'AppColors.dart';

class MyAppTheme {
  static final ThemeData lightMode = ThemeData(
      appBarTheme: AppBarTheme(
          color: Colors.green,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)))),
      scaffoldBackgroundColor: Colors.transparent,
      textTheme: TextTheme(
          titleLarge: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.white),
          titleMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          bodySmall: TextStyle(fontSize: 18, color: AppColors.white)));
}
