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

  // ADD product — returns the created product map
  Future<Map<String, dynamic>> addProduct(Map<String, dynamic> data) async {
    final response = await client.post(ApiEndpoints.products, data);
    return Map<String, dynamic>.from(response.data);
  }

  // UPDATE product — returns the updated product map
  Future<Map<String, dynamic>> updateProduct(
    int id,
    Map<String, dynamic> data,
  ) async {
    final response = await client.put("${ApiEndpoints.products}/$id", data);
    return Map<String, dynamic>.from(response.data);
  }

  // DELETE product
  Future<void> deleteProduct(int id) async {
    await client.delete("${ApiEndpoints.products}/$id");
  }
}
