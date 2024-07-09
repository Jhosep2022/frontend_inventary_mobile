import 'package:flutter/material.dart';

class MovementsState with ChangeNotifier {
  Map<String, bool> _filters = {
    'Ingresos': false,
    'Salidas': false,
    'Finalizados': false,
    'Cancelados': false,
    'Fecha': false,
    'Cliente': false,
  };

  bool _isFilterVisible = true;

  Map<String, bool> get filters => _filters;

  bool get isFilterVisible => _isFilterVisible;

  void toggleFilter(String key) {
    _filters[key] = !_filters[key]!;
    notifyListeners();
  }

  void toggleFilterVisibility() {
    _isFilterVisible = !_isFilterVisible;
    notifyListeners();
  }
}
