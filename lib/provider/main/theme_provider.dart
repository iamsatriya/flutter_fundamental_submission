import 'package:flutter/widgets.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkmode = false;

  bool get isDarkmode => _isDarkmode;

  void toggleDarkmode() {
    _isDarkmode = !_isDarkmode;
    notifyListeners();
  }
}
