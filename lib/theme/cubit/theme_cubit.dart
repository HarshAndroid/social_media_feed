import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../global.dart';
import '../../service/pref.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState(Pref.isDarkMode));

  void changeTheme() {
    Pref.isDarkMode = !state.isDarkMode;
    emit(ThemeState(!state.isDarkMode));
  }

  // light
  get lightTheme => ThemeData(
        primaryColorLight: Colors.black54, // light text color
        colorSchemeSeed: pColor,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          titleTextStyle: TextStyle(fontSize: 19, color: Colors.black),
          elevation: 3,
        ),

        //text field theme
        inputDecorationTheme: const InputDecorationTheme(
          prefixIconColor: pColor,

          contentPadding: EdgeInsets.all(16),
          hintStyle: TextStyle(fontSize: 14),

          //border
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.black38),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: pColor),
            // borderSide: BorderSide(width: 0.5, color: pColor),
          ),

          //
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.black38),
          ),

          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.black38),
          ),

          //
          isDense: true,
        ),
      );

  // dark
  get darkTheme => ThemeData(
        brightness: Brightness.dark,
        colorSchemeSeed: pColor,

        primaryColorLight: Colors.white70, // light text color

        appBarTheme: const AppBarTheme(
            centerTitle: true,
            titleTextStyle: TextStyle(fontSize: 19),
            elevation: 3),

        //text field theme
        inputDecorationTheme: const InputDecorationTheme(
          prefixIconColor: pColor,

          contentPadding: EdgeInsets.all(16),
          hintStyle: TextStyle(fontSize: 14),

          //border
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.white38),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: pColor),
          ),

          //
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.white38),
          ),

          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.white38),
          ),

          //
          isDense: true,
        ),
      );
}
