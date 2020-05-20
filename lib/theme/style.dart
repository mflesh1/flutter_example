import 'package:flutter/material.dart';
import 'package:flutter_example/theme/theme.dart';


ThemeData appTheme(context) {

  return ThemeData(
    backgroundColor: ThemeColors.greyBackground,
    primaryColor: ThemeColors.primaryColor,
    primaryColorLight: Color(0xffA6C1F6),
    scaffoldBackgroundColor: ThemeColors.greyBackground,
    toggleableActiveColor: ThemeColors.primaryColor,
    sliderTheme: SliderThemeData(
      activeTrackColor: ThemeColors.primaryColor,
      inactiveTrackColor: Color(0xffA6C1F6),
      thumbColor: ThemeColors.primaryColor
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: ThemeColors.primaryColor
    ),
    textTheme: TextTheme(
      button: TextStyle(fontSize: 18.0),
    ),
    buttonTheme: ButtonThemeData(
        buttonColor: ThemeColors.primaryColor,
    ),
    appBarTheme: AppBarTheme(
      color: Colors.white,
      iconTheme: IconThemeData(
        color: Colors.black
      ),
      textTheme: TextTheme(
          title: Theme.of(context).textTheme.title
      )
    ),
    dialogTheme : DialogTheme(
      titleTextStyle: TextStyle(
        fontSize: 22.0,
        color: Colors.black,
        fontWeight: FontWeight.bold
      ),
      contentTextStyle: TextStyle(
        fontSize: Theme.of(context).textTheme.body1.fontSize,
        color: Colors.black
      ),
    )

  );

}
