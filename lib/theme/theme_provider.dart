import 'package:flutter/material.dart';
import 'package:my_todo_app_isar/theme/theme.dart';

class ThemeProvider with ChangeNotifier {
  // initial theme setting = light mode
  ThemeData _themeData = lightMode;

  // getter for ThemeData
  ThemeData get themeData => _themeData;

  // getting to check if in dark mode or not
  bool get isDarkMode => _themeData == darkMode;

  // setter method to set the new theme
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  // method to switch mode
  void toggleTheme() {
    if (_themeData == lightMode) {
      // switch light mode to dark mode
      themeData = darkMode;
    } else {
      // switch dark mode to light mode
      themeData = lightMode;
    }
  }
}
