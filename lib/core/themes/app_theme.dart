import 'package:flutter/material.dart';
import 'colors_palette.dart';

final lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    backgroundColor: crPrimary,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w600,
      fontSize: 20,
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
      size: 24,
    ),
    actionsIconTheme: IconThemeData(
      color: Colors.white,
      size: 24,
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(),
    isDense: true,
  ),
  textButtonTheme: const TextButtonThemeData(
    style: ButtonStyle(
      alignment: Alignment.center,
      elevation: WidgetStatePropertyAll(3.0),
      backgroundColor:  WidgetStatePropertyAll(crPrimary),
      foregroundColor: WidgetStatePropertyAll(Colors.white),
      minimumSize: WidgetStatePropertyAll(Size(140, 40)),
      maximumSize: WidgetStatePropertyAll(Size(double.infinity, 40)),
      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(6)),
      )),
      textStyle: WidgetStatePropertyAll(TextStyle(
        fontWeight: FontWeight.w600,
        color: Colors.white,
        fontSize: 18,
        letterSpacing: 1.0
      )),
    ),
  ),
);

final darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    backgroundColor: crPrimaryDark,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w600,
      fontSize: 20,
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
      size: 24,
    ),
    actionsIconTheme: IconThemeData(
      color: Colors.white,
      size: 24,
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(),
    isDense: true,
  ),
  textButtonTheme: const TextButtonThemeData(
    style: ButtonStyle(
      alignment: Alignment.center,
      elevation: WidgetStatePropertyAll(3.0),
      backgroundColor:  WidgetStatePropertyAll(crPrimaryDark),
      foregroundColor: WidgetStatePropertyAll(Colors.white),
      minimumSize: WidgetStatePropertyAll(Size(140, 40)),
      maximumSize: WidgetStatePropertyAll(Size(double.infinity, 40)),
      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(6)),
      )),
      textStyle: WidgetStatePropertyAll(TextStyle(
        fontWeight: FontWeight.w600,
        color: Colors.white,
        fontSize: 18,
        letterSpacing: 1.0
      )),
    ),
  ),
);
