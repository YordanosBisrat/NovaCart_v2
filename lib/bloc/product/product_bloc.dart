import 'package:flutter_bloc/flutter_bloc.dart';
import 'product_event.dart';
import 'product_state.dart';
import '../../data/datasources/product_remote_data_source.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRemoteDataSource dataSource;

  ProductBloc(this.dataSource) : super(ProductInitial()) {
    on<LoadProducts>(_onLoadProducts);
    on<AddProduct>(_onAddProduct);
    on<UpdateProduct>(_onUpdateProduct);
    on<DeleteProduct>(_onDeleteProduct);
  }

  // GET
  Future<void> _onLoadProducts(
    LoadProducts event,
    Emitter<ProductState> emit,
  ) async {
    try {
      emit(ProductLoading());
      final raw = await dataSource.getProducts();
      final products = raw.cast<Map<String, dynamic>>();
      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError("Failed to load products"));
    }
  }

  // CREATE — add to local list, no re-fetch
  Future<void> _onAddProduct(
    AddProduct event,
    Emitter<ProductState> emit,
  ) async {
    final currentState = state;
    if (currentState is! ProductLoaded) return;
    try {
      emit(ProductLoading());
      final newProduct = await dataSource.addProduct(event.product);
      final updated = List<Map<String, dynamic>>.from(currentState.products)
        ..add(newProduct);
      emit(ProductOperationSuccess(updated, "Product added"));
    } catch (e) {
      emit(ProductError("Failed to add product"));
    }
  }

  // UPDATE — update in local list, no re-fetch
  Future<void> _onUpdateProduct(
    UpdateProduct event,
    Emitter<ProductState> emit,
  ) async {
    final currentState = state;
    if (currentState is! ProductLoaded) return;
    try {
      emit(ProductLoading());
      final updatedProduct = await dataSource.updateProduct(
        event.id,
        event.product,
      );
      final updated = currentState.products.map((p) {
        return p['id'] == event.id ? updatedProduct : p;
      }).toList();
      emit(ProductOperationSuccess(updated, "Product updated"));
    } catch (e) {
      emit(ProductError("Failed to update product"));
    }
  }

  // DELETE — remove from local list, no re-fetch
  Future<void> _onDeleteProduct(
    DeleteProduct event,
    Emitter<ProductState> emit,
  ) async {
    final currentState = state;
    if (currentState is! ProductLoaded) return;
    try {
      emit(ProductLoading());
      await dataSource.deleteProduct(event.id);
      final updated = currentState.products
          .where((p) => p['id'] != event.id)
          .toList();
      emit(ProductOperationSuccess(updated, "Product deleted"));
    } catch (e) {
      emit(ProductError("Failed to delete product"));
    }
  }
}
