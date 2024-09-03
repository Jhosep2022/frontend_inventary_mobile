class ProductOrder {
  final int idProduct;
  final int idUserOrder;

  ProductOrder({
    required this.idProduct,
    required this.idUserOrder,
  });

  Map<String, dynamic> toJson() {
    return {
      'id_product': idProduct,
      'id_userOrder': idUserOrder,
    };
  }
}