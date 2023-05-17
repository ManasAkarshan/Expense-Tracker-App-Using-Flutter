import 'package:flutter/material.dart';

import 'widgets/expenses.dart';

var kColorScreen = ColorScheme.fromSeed(seedColor:const Color.fromARGB(255, 96, 59, 181));
var kDarkColorScreen = ColorScheme.fromSeed(
  brightness: Brightness.dark,    // Tells flutter that it is for dark theme
  seedColor:const Color.fromARGB(255, 5, 99, 126)
);

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
     // THEMING
    themeMode: ThemeMode.system,     //default
    darkTheme: ThemeData.dark().copyWith(
      useMaterial3: true,
      colorScheme: kDarkColorScreen,
      cardTheme: const CardTheme().copyWith(
        color: kDarkColorScreen.secondaryContainer,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: kDarkColorScreen.primaryContainer,
          foregroundColor: kDarkColorScreen.onPrimaryContainer
        )
      ),
    ),


    theme: ThemeData().copyWith(               
      colorScheme: kColorScreen,
      appBarTheme: const AppBarTheme().copyWith(
        backgroundColor: kColorScreen.onPrimaryContainer,
        foregroundColor: kColorScreen.onPrimary,
      ),

      cardTheme: const CardTheme().copyWith(
        color: kColorScreen.secondaryContainer,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: kColorScreen.primaryContainer,
          foregroundColor: kDarkColorScreen.onPrimary
        )
      ),

      textTheme: ThemeData().textTheme.copyWith(
        titleLarge: TextStyle(
          fontWeight: FontWeight.normal,
          color: kColorScreen.onSecondaryContainer,
          fontSize: 17,
        ),
      )
    ),
    home: const Expenses()
    )
  );
}
