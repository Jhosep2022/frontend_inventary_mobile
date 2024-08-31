import 'package:equatable/equatable.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object> get props => [];
}

class FetchProducts extends ProductsEvent {
  final int companyId;

  const FetchProducts(this.companyId);

  @override
  List<Object> get props => [companyId];
}
