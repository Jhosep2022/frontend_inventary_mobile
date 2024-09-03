import 'package:meta/meta.dart';
import 'package:frontend_inventary_mobile/models/area.dart';
import 'package:frontend_inventary_mobile/models/producto.dart';

@immutable
abstract class InventoryDetailState {}

class InventoryDetailInitial extends InventoryDetailState {}

class InventoryDetailLoading extends InventoryDetailState {}

class InventoryDetailLoaded extends InventoryDetailState {
  final List<Producto> selectedProducts;
  final Area selectedArea;

  InventoryDetailLoaded({
    required this.selectedProducts,
    required this.selectedArea,
  });
}

class InventoryDetailError extends InventoryDetailState {
  final String message;

  InventoryDetailError(this.message);
}
