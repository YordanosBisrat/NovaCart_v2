import 'package:dio/dio.dart';
import 'api_endpoints.dart';

class DioClient {
  final Dio dio;

  DioClient()
    : dio = Dio(
        BaseOptions(
          baseUrl: ApiEndpoints.baseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          headers: {'Content-Type': 'application/json'},
        ),
      );

  // GET
  Future<Response> get(String path) async {
    try {
      return await dio.get(path);
    } catch (e) {
      rethrow;
    }
  }

  // POST
  Future<Response> post(String path, dynamic data) async {
    try {
      return await dio.post(path, data: data);
    } catch (e) {
      rethrow;
    }
  }

  // PUT
  Future<Response> put(String path, dynamic data) async {
    try {
      return await dio.put(path, data: data);
    } catch (e) {
      rethrow;
    }
  }

  // DELETE
  Future<Response> delete(String path) async {
    try {
      return await dio.delete(path);
    } catch (e) {
      rethrow;
    }
  }
}
