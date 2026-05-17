import '../../core/network/dio_client.dart';
import '../../core/network/api_endpoints.dart';

class ProductRemoteDataSource {
  final DioClient client;

  ProductRemoteDataSource(this.client);

  // GET all products
  Future<List<dynamic>> getProducts() async {
    final response = await client.get(ApiEndpoints.products);
    return response.data;
  }

  // ADD product
  Future<void> addProduct(Map<String, dynamic> data) async {
    await client.post(ApiEndpoints.products, data);
  }

  // UPDATE product
  Future<void> updateProduct(int id, Map<String, dynamic> data) async {
    await client.put("${ApiEndpoints.products}/$id", data);
  }

  // DELETE product
  Future<void> deleteProduct(int id) async {
    await client.delete("${ApiEndpoints.products}/$id");
  }
}
