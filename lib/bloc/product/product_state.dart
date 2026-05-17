import 'package:equatable/equatable.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

// Initial state
class ProductInitial extends ProductState {}

// Loading state
class ProductLoading extends ProductState {}

// Loaded state — used for initial fetch only
class ProductLoaded extends ProductState {
  final List<Map<String, dynamic>> products;

  const ProductLoaded(this.products);

  @override
  List<Object> get props => [products];
}

// CUD operation success — extends ProductLoaded so builder still renders the list
class ProductOperationSuccess extends ProductLoaded {
  final String message;

  const ProductOperationSuccess(super.products, this.message);

  @override
  List<Object> get props => [products, message];
}

// Error state
class ProductError extends ProductState {
  final String message;

  const ProductError(this.message);

  @override
  List<Object> get props => [message];
}
