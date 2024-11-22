import 'package:flutter/material.dart';
import 'package:uscunionmobile/custom/theme_colors.dart';

@immutable
class AppTheme {
  static const colors = AppColors();

  const AppTheme._();

  static ThemeData define() {
    return ThemeData(
      primaryColor: Color.fromRGBO(28, 63, 148, 1),
      primaryColorLight: Color.fromRGBO(213, 172, 0, 1),
    );
  }
}



// uscl Blue = rgb (28,63,148)
//uscl Gold = rgb(213,172,0)
//USCU Red = RGB(115,0,10)