import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

// Load all products
class LoadProducts extends ProductEvent {}

// Add product
class AddProduct extends ProductEvent {
  final Map<String, dynamic> product;

  const AddProduct(this.product);

  @override
  List<Object> get props => [product];
}

// Update product
class UpdateProduct extends ProductEvent {
  final int id;
  final Map<String, dynamic> product;

  const UpdateProduct(this.id, this.product);

  @override
  List<Object> get props => [id, product];
}

// Delete product
class DeleteProduct extends ProductEvent {
  final int id;

  const DeleteProduct(this.id);

  @override
  List<Object> get props => [id];
}
