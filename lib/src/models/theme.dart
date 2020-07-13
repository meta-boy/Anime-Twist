// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:equatable/equatable.dart';

class AnimeTwistTheme extends Equatable {
  final MaterialColor primary;
  final Color accent;
  final Color appbarFont;
  final Color textPrimary;
  final Color bodyBackground;
  final Color listTileCardBackground;
  final ListTileFontColor listTileFontColor;
  final ListTileIconColor listTileIconColor;
  final ButtonColor buttonPrimary;
  final ButtonColor buttonSecondary;

  AnimeTwistTheme({
    @required this.primary,
    @required this.accent,
    @required this.appbarFont,
    @required this.textPrimary,
    @required this.bodyBackground,
    @required this.listTileCardBackground,
    @required this.listTileFontColor,
    @required this.listTileIconColor,
    @required this.buttonPrimary,
    @required this.buttonSecondary,
  });

  @override
  List<Object> get props => [
        primary,
        accent,
        appbarFont,
        textPrimary,
        bodyBackground,
        listTileCardBackground,
        listTileFontColor,
        listTileIconColor,
        buttonPrimary,
        buttonSecondary,
      ];
}

class ListTileFontColor extends Equatable {
  final Color primary;
  final Color secondary;

  ListTileFontColor({
    @required this.primary,
    @required this.secondary,
  });

  @override
  List<Object> get props => [
        primary,
        secondary,
      ];
}

class ListTileIconColor extends Equatable {
  final Color normal;
  final Color primary;
  final Color secondary;
  final Color danger;

  ListTileIconColor({
    @required this.normal,
    @required this.primary,
    @required this.secondary,
    @required this.danger,
  });

  @override
  List<Object> get props => [
        normal,
        primary,
        secondary,
        danger,
      ];
}

class ButtonColor extends Equatable {
  final Color background;
  final Color fontColor;

  ButtonColor({
    @required this.background,
    @required this.fontColor,
  });

  @override
  List<Object> get props => [
        background,
        fontColor,
      ];
}


// Available AnimeTwistthemes



var indigoPinkLight = AnimeTwistTheme(
  primary: Colors.pink,
  accent: Colors.pink,
  appbarFont: Colors.white,
  textPrimary: Colors.black.withOpacity(0.80),
  bodyBackground: Color(0xffFAFAFA),
  listTileCardBackground: Colors.white,
  listTileFontColor: ListTileFontColor(
    primary: Colors.black.withOpacity(0.7),
    secondary: Color(0xff737373),
  ),
  listTileIconColor: ListTileIconColor(
    normal: Color(0xff8C8C8C),
    primary: Colors.green,
    secondary: Colors.pink,
    danger: Colors.red,
  ),
  buttonPrimary: ButtonColor(
    background: Colors.indigo,
    fontColor: Colors.white,
  ),
  buttonSecondary: ButtonColor(
    background: Colors.pink,
    fontColor: Colors.white,
  ),
);

var indigoPinkDark = AnimeTwistTheme(
  primary: Colors.pink,
  accent: Colors.pink,
  appbarFont: Colors.white,
  textPrimary: Colors.white,
  bodyBackground: Colors.black,
  listTileCardBackground: Color(0xff21252B),
  listTileFontColor: ListTileFontColor(
    primary: Colors.white.withOpacity(0.80),
    secondary: Color(0xff737373),
  ),
  listTileIconColor: ListTileIconColor(
    normal: Color(0xff8C8C8C),
    primary: Colors.green,
    secondary: Colors.pink,
    danger: Colors.redAccent,
  ),
  buttonPrimary: ButtonColor(
    background: Colors.indigo,
    fontColor: Colors.white,
  ),
  buttonSecondary: ButtonColor(
    background: Colors.pink,
    fontColor: Colors.white,
  ),
);
