import 'package:equatable/equatable.dart';
import 'package:frontend_inventary_mobile/models/producto.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object> get props => [];
}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsLoaded extends ProductsState {
  final List<Producto> products;

  const ProductsLoaded(this.products);

  @override
  List<Object> get props => [products];
}


class ProductsOfflineLoaded extends ProductsState {
  final List<Producto> products;

  const ProductsOfflineLoaded(this.products);

  @override
  List<Object> get props => [products];
}


class ProductsError extends ProductsState {
  final String message;

  const ProductsError(this.message);

  @override
  List<Object> get props => [message];
}


class ProductsSynced extends ProductsState {}
