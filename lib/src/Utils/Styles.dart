import 'package:flutter/material.dart';

TextStyle bigTitle(BuildContext context) {
  final isDarkMode = Theme.of(context).brightness == Brightness.dark;
  return TextStyle(
    color: isDarkMode
        ? Colors.pinkAccent
        : Colors.black, // Ajusta el color según el tema
    fontFamily: 'Averta_Black',
    fontSize: 36.0,
    height: 1.5,
  );
}

TextStyle titleGeneral(BuildContext context) {
  final isDarkMode = Theme.of(context).brightness == Brightness.dark;
  return TextStyle(
    color: isDarkMode ? Colors.pinkAccent : Colors.grey,
    fontFamily: 'Averta_Black',
    fontSize: 24,
    height: 1.5,
    letterSpacing: 0.5, // Ajusta el espaciado entre letras
  );
}

TextStyle smallitle(BuildContext context) {
  final isDarkMode = Theme.of(context).brightness == Brightness.dark;
  return TextStyle(
    color: isDarkMode ? Colors.pinkAccent : Colors.grey,
    fontFamily: 'Averta_Black',
    fontSize: 20.0,
    height: 1.5,
    letterSpacing: 0.5, // Ajusta el espaciado entre letras
  );
}

TextStyle smallitlefecha(BuildContext context) {
  final isDarkMode = Theme.of(context).brightness == Brightness.dark;
  return TextStyle(
    color: isDarkMode
        ? Colors.black
        : Colors.grey, // Ajusta el color según el tema
    fontFamily: 'Averta_Black',
    fontSize: 12.0,
    height: 1.5,
  );
}
