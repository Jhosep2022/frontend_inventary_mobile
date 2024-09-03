import 'package:equatable/equatable.dart';
import 'package:frontend_inventary_mobile/models/inventoryRequest.dart';

abstract class InventoryEvent extends Equatable {
  const InventoryEvent();

  @override
  List<Object> get props => [];
}

class UploadInventory extends InventoryEvent {
  final InventoryRequest inventoryRequest;

  const UploadInventory(this.inventoryRequest);

  @override
  List<Object> get props => [inventoryRequest];
}
