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
    emit(ProductLoading());
    try {
      final products = await dataSource.getProducts();
      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError("Failed to load products"));
    }
  }

  // CREATE
  Future<void> _onAddProduct(
    AddProduct event,
    Emitter<ProductState> emit,
  ) async {
    try {
      await dataSource.addProduct(event.product);
      add(LoadProducts());
    } catch (e) {
      emit(ProductError("Failed to add product"));
    }
  }

  // UPDATE
  Future<void> _onUpdateProduct(
    UpdateProduct event,
    Emitter<ProductState> emit,
  ) async {
    try {
      await dataSource.updateProduct(event.id, event.product);
      add(LoadProducts());
    } catch (e) {
      emit(ProductError("Failed to update product"));
    }
  }

  // DELETE
  Future<void> _onDeleteProduct(
    DeleteProduct event,
    Emitter<ProductState> emit,
  ) async {
    try {
      await dataSource.deleteProduct(event.id);
      add(LoadProducts());
    } catch (e) {
      emit(ProductError("Failed to delete product"));
    }
  }
}
