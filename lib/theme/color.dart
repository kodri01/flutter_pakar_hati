import 'package:flutter/material.dart';

const primaryColor = Color(0xFF2AB163);
const primaryColorLight = Color(0xFFf05545);
const primaryColorDark = Color(0xFF7f0000);

const secondaryColor = Color(0xFFFC9836);
const secondaryColorLight = Color(0xFFe5ffff);
const secondaryColorDark = Color(0xFF82ada9);

const thirdColor = Color(0xFF1993FD);
const thirdColorLight = Color(0xFFe5ffff);
const thirdColorDark = Color(0xFF82ada9);

const backgroundColor = Color(0xFFffffff);
const primaryTextColor = Color(0xFFffffff);
const secondaryTextColor = Color(0xFF000000);
const buttonColor = Color(0xFF000000);
const shadowColor = Color(0x33000000);

class MyTheme {
  static final ThemeData defaultTheme = _buildMyTheme();

  static ThemeData _buildMyTheme() {
    final ThemeData base = ThemeData.light();

    return base.copyWith(
      primaryColor: primaryColor,
      primaryColorDark: primaryColorDark,
      primaryColorLight: primaryColorLight,
      buttonTheme: base.buttonTheme.copyWith(
        buttonColor: secondaryColor,
        textTheme: ButtonTextTheme.primary,
      ),
      scaffoldBackgroundColor: backgroundColor,
      cardColor: backgroundColor,
      backgroundColor: backgroundColor,
      // textTheme: base.textTheme.copyWith(
      //     title: base.textTheme.title.copyWith(color: textColor),
      //     body1: base.textTheme.body1.copyWith(color: textColor),
      //     body2: base.textTheme.body2.copyWith(color: textColor)),
    );
  }
}
