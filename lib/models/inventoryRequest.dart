import 'package:frontend_inventary_mobile/models/productOrder.dart';

class InventoryRequest {
  final String idArea;
  final String fechaHora;
  final String idUser;
  final List<ProductOrder> products;

  InventoryRequest({
    required this.idArea,
    required this.fechaHora,
    required this.idUser,
    required this.products,
  });

  Map<String, dynamic> toJson() {
    return {
      'id_area': idArea,
      'fechaHora': fechaHora,
      'id_user': idUser,
      'products': products.map((product) => product.toJson()).toList(),
    };
  }
}