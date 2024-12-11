import 'package:flutter/material.dart';
import 'package:habit_app/theme/text_theme.dart';

class HabitTheme {
  static ThemeData lightTheme = ThemeData(
    appBarTheme: const AppBarTheme(
        color: Colors.teal,
        centerTitle: false,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.normal)),
    buttonTheme: const ButtonThemeData(
      buttonColor: Color.fromARGB(249, 76, 212, 31),
    ),
    iconButtonTheme: const IconButtonThemeData(
        style: ButtonStyle(
            foregroundColor: WidgetStatePropertyAll(
      Color.fromARGB(248, 16, 62, 1),
    ))),
    elevatedButtonTheme: const ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(
          Color.fromARGB(249, 76, 212, 31),
        ),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color.fromARGB(210, 58, 173, 30),
        foregroundColor: Colors.white),
    textTheme: TextStyleTheme.lightTextTheme,
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: const TextStyle(color: Colors.green),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey, width: 2.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.green, width: 2.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey, width: 1.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return Colors.green; // Color when selected
        }
        return Colors.lightGreen; // Color when not selected
      }),
      checkColor: MaterialStateProperty.all(Colors.white), // Check mark color
      side: BorderSide(color: Colors.black, width: 2.0), // Border customization
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0), // Rounded checkbox
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      color: Colors.grey,
      centerTitle: false,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 28,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.normal),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Color.fromARGB(178, 232, 233, 232),
    ),
    elevatedButtonTheme: const ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(
          Color.fromARGB(178, 232, 233, 232),
        ),
      ),
    ),
    iconTheme: IconThemeData(color: Colors.black),
    textTheme: TextStyleTheme.darkTextTheme,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color.fromARGB(44, 29, 39, 29),
        foregroundColor: Colors.black),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: const TextStyle(color: Color.fromARGB(44, 29, 39, 29)),
      enabledBorder: OutlineInputBorder(
        borderSide:
            const BorderSide(color: Color.fromARGB(44, 29, 39, 29), width: 2.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide:
            const BorderSide(color: Color.fromARGB(44, 29, 39, 29), width: 2.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey, width: 1.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return Colors.grey[100]; // Color when selected
        }
        return Colors.grey; // Color when not selected
      }),
      checkColor: MaterialStateProperty.all(Colors.white), // Check mark color
      side: BorderSide(color: Colors.black, width: 2.0), // Border customization
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0), // Rounded checkbox
      ),
    ),
  );
}
