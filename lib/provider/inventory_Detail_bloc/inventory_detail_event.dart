import 'package:meta/meta.dart';

@immutable
abstract class InventoryDetailEvent {}

class LoadInventoryDetail extends InventoryDetailEvent {
  final List<int> productIds;
  final int areaId;

  LoadInventoryDetail({required this.productIds, required this.areaId});
}
