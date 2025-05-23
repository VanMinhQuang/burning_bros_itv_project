import 'package:flutter/material.dart';

class TextThemeStyle{
  TextThemeStyle._();

  static TextStyle textBoxCustomSize({Color? color,FontWeight? fontWeight,required  double fontSize}) {
    return TextStyle(
      color: color ?? Colors.black,
      fontSize: fontSize,
      fontWeight: fontWeight ?? FontWeight.w400,
      letterSpacing: 0,
    );
  }
}