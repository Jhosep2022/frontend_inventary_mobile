import 'package:flutter/material.dart';

class SelectedScreenProvider with ChangeNotifier {
  int _selectedScreen = 0;

  int get selectedScreen => _selectedScreen;

  void selectScreen(int screenIndex) {
    _selectedScreen = screenIndex;
    notifyListeners();
  }
}
