import 'dart:ui';

import 'package:flutter/material.dart';

class ThemeTextStyles {
  static const TextStyle pageHeading = TextStyle(fontWeight: FontWeight.bold, fontSize: 26.0, color: Color(0xFF1F1F1F));
  static const TextStyle subHeading = TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Color(0xFF1F1F1F));
  static const TextStyle paragraphHeading = TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0, color: Color(0xFF5D666D));
  static const TextStyle drawerMenuItem = TextStyle(fontSize: 16.0, color: ThemeColors.mainFont);

}

class ThemeColors {
  static const Color mainFont = Color(0xFF292929);
  static const Color greyBackground = Color(0xffF3F4F5);
  static const Color primaryColor = Color(0xff0C60A5);
  static const Color greyBoxBackground = Color(0xFFF0F1F2);
  static const Color greyBoxBorder = Color(0xFFDADCDF);
  static const Color locationCircleBorder = Color(0xFF2977B1);
  static const Color locationCircleFill = Color.fromARGB(100, 199, 223, 243);
  static const Color bodyText = Color(0xFF1F1F1F);
  static const Color bodyTextGrey = Color(0xFF566169);
  static const Color alertErrorBackground = Color(0xFFB00020);
  static const Color alertErrorText = Color(0xFFFFFFFF);
}

class ThemeBorder {
  static BoxBorder greyBoxBorder = Border.all(color: ThemeColors.greyBoxBorder, width: 1);
}

class ThemeButton {
  static BorderRadius borderRadius = BorderRadius.circular(3);
  static EdgeInsets padding = EdgeInsets.fromLTRB(5.0, 12.0, 5.0, 12.0);
}