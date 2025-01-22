import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _currentTheme = lightTheme;

  ThemeData get currentTheme => _currentTheme;

  void setTheme(ThemeData theme) {
    _currentTheme = theme;
    notifyListeners(); // Notifica cambios a los widgets
  }

  // Define tus temas aquí, claro y oscuro
  static final lightTheme = ThemeData(
    primaryColor: const Color(0xFF13293E),
    scaffoldBackgroundColor: const Color(0xFF325569),
    colorScheme: const ColorScheme.light(
      secondary: Color(0xFFF66B0F),
    ).copyWith(surface: const Color(0xFF325569)),
  );

  static final darkTheme = ThemeData(
    primaryColor: const Color(0xFF000000),
    scaffoldBackgroundColor: const Color(0xff1c1c1c),
    colorScheme: const ColorScheme.dark(
      secondary: Color(0xFFb3d818),
    ).copyWith(surface: const Color(0xFF333E07)),
  );
}
