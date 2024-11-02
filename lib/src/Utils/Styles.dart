import 'package:flutter/material.dart';

TextStyle bigTitle(BuildContext context) {
  final isDarkMode = Theme.of(context).brightness == Brightness.dark;
  return TextStyle(
    color: isDarkMode ? Colors.pinkAccent : Colors.black,
    fontFamily: 'CM Sans Serif', 
    fontSize: 36.0,
    height: 1.5,
  );
}

TextStyle titleGeneral(BuildContext context) {
  final isDarkMode = Theme.of(context).brightness == Brightness.dark;
  return TextStyle(
    color: isDarkMode ? Colors.pinkAccent : Colors.grey,
    fontFamily: 'CM Sans Serif',
    fontSize: 24,
    height: 1.5,
    letterSpacing: 0.5,
  );
}

TextStyle smallitle(BuildContext context) {
  final isDarkMode = Theme.of(context).brightness == Brightness.dark;
  return TextStyle(
    color: isDarkMode ? Colors.pinkAccent : Colors.grey,
    fontFamily: 'CM Sans Serif',
    fontSize: 20.0,
    height: 1.5,
    letterSpacing: 0.5,
  );
}

TextStyle smallitlefecha(BuildContext context) {
  final isDarkMode = Theme.of(context).brightness == Brightness.dark;
  return TextStyle(
    color: isDarkMode ? Colors.black : Colors.grey,
    fontFamily: 'CM Sans Serif',
    fontSize: 12.0,
    height: 1.5,
  );
}
