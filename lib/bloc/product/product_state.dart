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

// Loaded state
class ProductLoaded extends ProductState {
  final List products;

  const ProductLoaded(this.products);

  @override
  List<Object> get props => [products];
}

// Error state
class ProductError extends ProductState {
  final String message;

  const ProductError(this.message);

  @override
  List<Object> get props => [message];
}
