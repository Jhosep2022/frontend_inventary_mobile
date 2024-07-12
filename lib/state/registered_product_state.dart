import 'package:flutter/material.dart';

class RegisteredProductState with ChangeNotifier {
  String? _selectedValue = 'estado_bueno';

  String? get selectedValue => _selectedValue;

  void setSelectedValue(String? value) {
    _selectedValue = value;
    notifyListeners();
  }
}
