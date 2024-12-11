import 'package:flutter/material.dart';

class TextStyleTheme {
  static TextTheme lightTextTheme = const TextTheme(
      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(205, 16, 58, 3),
      ),
      titleMedium: TextStyle(fontSize: 16, color: Colors.white),
      titleSmall: TextStyle(
          fontSize: 18,
          color: Color.fromARGB(210, 58, 173, 30),
          fontWeight: FontWeight.bold),
      displaySmall:
          TextStyle(fontSize: 16, color: Color.fromARGB(210, 19, 87, 2)));

  static TextTheme darkTextTheme = const TextTheme(
      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(44, 29, 39, 29),
      ),
      titleMedium: TextStyle(
          fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
      titleSmall: TextStyle(
          fontSize: 18,
          color: Color.fromARGB(44, 29, 39, 29),
          fontWeight: FontWeight.bold),
      displaySmall:
          TextStyle(fontSize: 16, color: Color.fromARGB(44, 29, 39, 29)));
}
